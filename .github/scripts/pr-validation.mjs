const requiredSections = [
  "## Description",
  "## Type of Change",
  "## How Has This Been Tested?",
  "## Checklist",
];

const checklistItems = [
  "My code follows the style guidelines of this project",
  "I have performed a self-review of my code",
  "I have commented my code, particularly in hard-to-understand areas",
  "I have made corresponding changes to the documentation",
  "My changes generate no new warnings",
  "Any dependent changes have been merged and published in downstream modules",
  "I have checked my code and corrected any misspellings",
];

const releaseTitle = /^(version packages|chore: version packages|chore\(release\):|chore: release\b)/i;
const issueReference = /\b(?:closes|fixes|resolves|refs|see|related to|part of)\s+(?:#\d+|https:\/\/github\.com\/[\w.-]+\/[\w.-]+\/issues\/\d+)|(?<![#\w])#\d+\b/im;
const isTestFile = (path) => /test.*\.[tj]s?$/.test(path);

export function evaluatePullRequest({ title, body, author, files }) {
  const failures = [];
  const warnings = [];
  const prBody = body ?? "";
  const prTitle = title ?? "";
  const bot = author?.endsWith("[bot]") || author?.startsWith("app/");
  const exempt = bot || releaseTitle.test(prTitle);

  if (!prBody) failures.push("Add a `## Description` summary to the PR body.");
  if (!prTitle) failures.push("Add a PR title.");

  if (!exempt && !issueReference.test(prBody.replace(/```[\s\S]*?```/g, "").replace(/#ISSUE\b/gi, "")) &&
      !issueReference.test(prTitle)) {
    failures.push("Reference the related issue with `Closes #N` or `Refs #N` in the PR body or title.");
  }

  if (!bot) {
    for (const section of requiredSections) {
      if (!prBody.includes(section)) failures.push(`Include the ${section} section in the PR body.`);
    }
    for (const item of checklistItems) {
      if (!prBody.includes(`- [x] ${item}`)) warnings.push(`Checklist item is unchecked: ${item}`);
    }
  }

  const paths = files.map((file) => file.filename);
  const patches = files.map((file) => file.patch ?? "");
  const added = patches.reduce((count, patch) => count + patch.split("\n").filter((line) => line.startsWith("+") && !line.startsWith("+++")).length, 0);
  const removed = patches.reduce((count, patch) => count + patch.split("\n").filter((line) => line.startsWith("-") && !line.startsWith("---")).length, 0);
  const lines = added + removed;

  if (added < removed) warnings.push("Thanks for removing more lines than you added.");
  if (lines <= 200 && files.length <= 10) warnings.push("Thanks for keeping this PR small.");
  if (lines > 200) warnings.push(`This PR changes more than 200 lines (${lines}).`);
  if (files.length > 10) warnings.push(`This PR changes more than 10 files (${files.length}).`);
  if (paths.some((path) => path.endsWith(".md"))) warnings.push("Documentation files are included.");
  if (paths.some(isTestFile)) warnings.push("Test files are included.");
  if (files.some((file) => file.filename === "package.json" && file.status === "modified")) {
    warnings.push("A package.json file was modified; review dependency changes and lockfiles.");
  }

  return { failures, warnings, added, removed, files: files.length };
}

async function main() {
  const event = JSON.parse(await (await import("node:fs/promises")).readFile(process.env.GITHUB_EVENT_PATH, "utf8"));
  const pull = event.pull_request;
  if (!pull) throw new Error("Expected a pull_request event payload.");

  const [owner, repo] = process.env.GITHUB_REPOSITORY.split("/");
  const number = pull.number;
  const token = process.env.GITHUB_TOKEN;
  const api = `https://api.github.com/repos/${owner}/${repo}`;
  const request = async (path, options = {}) => {
    const response = await fetch(`${api}${path}`, {
      ...options,
      headers: {
        Accept: "application/vnd.github+json",
        Authorization: `Bearer ${token}`,
        "X-GitHub-Api-Version": "2022-11-28",
        ...(options.body ? { "Content-Type": "application/json" } : {}),
        ...options.headers,
      },
    });
    if (!response.ok) throw new Error(`GitHub API ${response.status}: ${await response.text()}`);
    return response.status === 204 ? null : response.json();
  };

  const files = await request(`/pulls/${number}/files?per_page=100`);
  const result = evaluatePullRequest({
    title: pull.title,
    body: pull.body,
    author: pull.user?.login,
    files,
  });
  const sections = ["<!-- pr-validation-summary -->", "## Pull request validation"];
  sections.push(result.failures.length ? "### Required changes\n" + result.failures.map((item) => `- ${item}`).join("\n") : "Required sections and issue reference are present.");
  if (result.warnings.length) sections.push("### Notes\n" + result.warnings.map((item) => `- ${item}`).join("\n"));
  sections.push(`Diff summary: ${result.files} files, ${result.added} additions, ${result.removed} deletions.`);
  const comment = sections.join("\n\n");

  const comments = await request(`/issues/${number}/comments?per_page=100`);
  const existing = comments.find((item) => item.user?.login === "github-actions[bot]" && item.body?.includes("<!-- pr-validation-summary -->"));
  if (existing) {
    await request(`/issues/comments/${existing.id}`, { method: "PATCH", body: JSON.stringify({ body: comment }) });
  } else {
    await request(`/issues/${number}/comments`, { method: "POST", body: JSON.stringify({ body: comment }) });
  }

  for (const failure of result.failures) {
    console.error(`::error title=PR validation::${failure.replace(/%/g, "%25").replace(/\r/g, "%0D").replace(/\n/g, "%0A")}`);
  }
  for (const warning of result.warnings) {
    console.log(`::warning title=PR validation::${warning.replace(/%/g, "%25").replace(/\r/g, "%0D").replace(/\n/g, "%0A")}`);
  }
  await import("node:fs/promises").then(({ appendFile }) => appendFile(process.env.GITHUB_STEP_SUMMARY, `${comment.replace("<!-- pr-validation-summary -->\n\n", "")}\n`));
  if (result.failures.length) process.exitCode = 1;
}

if (process.argv[1] && import.meta.url === new URL(`file://${process.argv[1]}`).href) {
  main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });
}
