import test from "node:test";
import assert from "node:assert/strict";
import { evaluatePullRequest } from "./pr-validation.mjs";

const body = [
  "## Description",
  "Change summary. Closes #114",
  "## Type of Change",
  "## How Has This Been Tested?",
  "## Checklist",
];

test("accepts required sections and issue references, and reports changed files", () => {
  const result = evaluatePullRequest({
    title: "fix: replace PR validation dependency",
    body: body.join("\n"),
    author: "contributor",
    files: [
      { filename: "README.md", status: "modified", patch: "@@\n-old\n+new\n+another" },
      { filename: "src.test.ts", status: "added", patch: "@@\n+test" },
    ],
  });

  assert.deepEqual(result.failures, []);
  assert.equal(result.added, 3);
  assert.equal(result.removed, 1);
  assert.equal(result.files, 2);
  assert.ok(result.warnings.some((warning) => warning.includes("Documentation")));
  assert.ok(result.warnings.some((warning) => warning.includes("Test files")));
});

test("requires a reference outside of fenced examples", () => {
  const result = evaluatePullRequest({
    title: "fix: update validation",
    body: `${body.join("\n").replace("Change summary. Closes #114", "Change summary.")}\n\n\`\`\`text\nCloses #123\n\`\`\``,
    author: "contributor",
    files: [],
  });

  assert.ok(result.failures.some((failure) => failure.includes("related issue")));
});

test("release automation is exempt from template and issue-reference requirements", () => {
  const result = evaluatePullRequest({
    title: "chore(release): publish packages",
    body: "Generated release PR",
    author: "release-bot[bot]",
    files: [],
  });

  assert.deepEqual(result.failures, []);
});
