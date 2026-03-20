#!/usr/bin/env bash
set -euo pipefail

# VS-style Git sync for current branch:
# 1. Fetch remote updates
# 2. Rebase local branch onto remote tracking branch
# 3. Push local branch
#
# Optional:
#   AUTO_COMMIT=1 ./git-sync.sh
#   COMMIT_MSG="sync" AUTO_COMMIT=1 ./git-sync.sh

REMOTE="${REMOTE:-origin}"
BRANCH="${BRANCH:-$(git branch --show-current)}"
AUTO_COMMIT="${AUTO_COMMIT:-0}"
COMMIT_MSG="${COMMIT_MSG:-sync}"

if [[ -z "${BRANCH}" ]]; then
  echo "ERROR: Could not determine current branch."
  exit 1
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "ERROR: Not inside a git repository."
  exit 1
fi

echo "Repo:   $(git rev-parse --show-toplevel)"
echo "Remote: ${REMOTE}"
echo "Branch: ${BRANCH}"
echo

# Verify remote exists
if ! git remote get-url "${REMOTE}" >/dev/null 2>&1; then
  echo "ERROR: Remote '${REMOTE}' does not exist."
  exit 1
fi

# Optional auto-commit
if [[ "${AUTO_COMMIT}" == "1" ]]; then
  if [[ -n "$(git status --porcelain)" ]]; then
    echo "Staging and committing local changes..."
    git add -A
    # Commit only if there is something staged
    if ! git diff --cached --quiet; then
      git commit -m "${COMMIT_MSG}"
    fi
  fi
fi

echo "Fetching latest refs..."
git fetch --all --prune

# Ensure local branch exists
if ! git show-ref --verify --quiet "refs/heads/${BRANCH}"; then
  echo "ERROR: Local branch '${BRANCH}' does not exist."
  exit 1
fi

# Ensure upstream exists; if not, set it
if ! git rev-parse --abbrev-ref --symbolic-full-name "@{u}" >/dev/null 2>&1; then
  echo "No upstream set for '${BRANCH}'. Setting upstream to ${REMOTE}/${BRANCH}..."
  git branch --set-upstream-to="${REMOTE}/${BRANCH}" "${BRANCH}" 2>/dev/null || true
fi

UPSTREAM="$(git rev-parse --abbrev-ref --symbolic-full-name "@{u}" 2>/dev/null || true)"
if [[ -z "${UPSTREAM}" ]]; then
  echo "ERROR: Could not determine upstream branch for '${BRANCH}'."
  echo "Set it manually with:"
  echo "  git branch --set-upstream-to=${REMOTE}/${BRANCH} ${BRANCH}"
  exit 1
fi

echo "Local HEAD:   $(git rev-parse --short HEAD)"
echo "Upstream ref: ${UPSTREAM}"
echo "Remote HEAD:  $(git rev-parse --short "${UPSTREAM}")"
echo

# Prevent destructive sync if working tree still dirty
if [[ -n "$(git status --porcelain)" ]]; then
  echo "ERROR: Working tree is not clean."
  echo "Commit, stash, or run with AUTO_COMMIT=1."
  exit 1
fi

echo "Rebasing '${BRANCH}' onto '${UPSTREAM}'..."
git pull --rebase "${REMOTE}" "${BRANCH}"

echo "Pushing '${BRANCH}' to '${REMOTE}'..."
git push "${REMOTE}" "${BRANCH}"

echo
echo "Sync complete."
echo "Local HEAD:  $(git rev-parse --short HEAD)"
echo "Remote HEAD: $(git rev-parse --short "${UPSTREAM}")"
