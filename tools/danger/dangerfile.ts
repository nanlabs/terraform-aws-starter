import { danger, warn, fail, message, TextDiff } from "danger";

const SMALL_PR_FILES = 10;
const SMALL_PR_LINES = 200;

const DOC_FILE_MATCH = "**/*.md";
const SRC_FILE_REGEXP = /test.*\.([tj]s?)$/;

const templateSections = [
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

// No PR is too small to include a description of why you made a change
if (!danger.github.pr.body) {
  const title = ":clipboard: Missing Summary";
  const idea =
    "Can you add a Summary? " +
    "To do so, add a `## Description` section to your PR description. " +
    "This is a good place to explain the motivation for making this change. Include a summary of the changes and the related issue, and list any dependencies that are required for this change.";
  fail(`${title} - <i>${idea}</i>`);
}

if (!danger.github.pr.title) {
  const title = ":id: Missing PR Title";
  const idea = "Can you add the relevant title?";
  fail(`${title} - <i>${idea}</i>`);
}

// Function to check if a section exists in the PR body
const hasSection = (section: string) => danger.github.pr.body.includes(section);

// Function to check if a checklist item is checked in the PR body
const isChecklistItemChecked = (item: string) =>
  danger.github.pr.body.includes(`- [x] ${item}`);

// Check for missing sections
templateSections.forEach((section) => {
  if (!hasSection(section)) {
    fail(
      `:clipboard: Missing Section - Please include the section: <i>${section}</i> in your PR description.`
    );
  }
});

// Check for missing or unchecked checklist items
checklistItems.forEach((item) => {
  if (!isChecklistItemChecked(item)) {
    warn(
      `:clipboard: Unchecked Checklist Item - Please check the item: <i>${item}</i> in your PR description.`
    );
  }
});

const touchedFiles = danger.git.created_files.concat(danger.git.modified_files);
const allFiles = touchedFiles.concat(danger.git.deleted_files);

const diffsList: Promise<(TextDiff | null)[]> = Promise.all(
  allFiles.map((p) => danger.git.diffForFile(p))
);

diffsList
  .then((diffs) => diffs.filter(Boolean) as TextDiff[])
  .then((diffs) => ({
    removed: diffs.reduce(
      (lines, diff) => lines + diff.removed.split("\n").length,
      0
    ),
    added: diffs.reduce(
      (lines, diff) => lines + diff.added.split("\n").length,
      0
    ),
    lines: diffs.reduce(
      (lines, diff) =>
        lines + diff.added.split("\n").length + diff.removed.split("\n").length,
      0
    ),
    files: diffs.length,
  }))
  .then((diff) => {
    if (diff.added < diff.removed) {
      message("Thanks! We :heart: removing more lines than added!");
    }

    if (diff.lines <= SMALL_PR_LINES && diff.files <= SMALL_PR_FILES) {
      message("Thanks! We :heart: small PRs!");
    }

    if (diff.lines > SMALL_PR_LINES) {
      warn(`This PR is changing more than ${SMALL_PR_LINES} lines.`);
    }

    if (diff.files > SMALL_PR_FILES) {
      warn(`This PR is changing more than ${SMALL_PR_FILES} files.`);
    }
  });

// Request changes to src also include changes to tests.
const docs = danger.git.fileMatch(DOC_FILE_MATCH);
const appModified = touchedFiles.some((p) => p.match(SRC_FILE_REGEXP));

if (docs.edited) {
  message("Thanks for updating docs! We :heart: documentation!");
}

if (appModified) {
  message(
    "Thanks for updating tests! Only YOU can prevent production fires. :fire::evergreen_tree::bear:"
  );
}

// Warns if there are changes to package.json, and tags the team.
const packageJSON = danger.git.fileMatch("package.json");

if (packageJSON.modified) {
  const title = ":lock: package.json";
  const idea = "Changes were made to package.json.";
  warn(`${title} - <i>${idea}</i>`);
}
