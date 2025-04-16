#!/bin/sh
set -e

# Default to showing only current user's commits
AUTHOR="--author=$(git config user.email)"
BASE_BRANCH=""

# Parse arguments
for arg in "$@"; do
    case "$arg" in
        --all)
            AUTHOR=""
            ;;
        *)
            if [ -z "$BASE_BRANCH" ]; then
                BASE_BRANCH="$arg"
            fi
            ;;
    esac
done

# Auto-detect base branch if not provided
if [ -z "$BASE_BRANCH" ]; then
    BASE_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
    if [ -z "$BASE_BRANCH" ]; then
        echo "❌ Unable to determine default remote branch. Using 'main' as fallback."
        BASE_BRANCH="main"
    fi
fi

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

git log "$BASE_BRANCH..$CURRENT_BRANCH" $AUTHOR \
  --oneline --graph \
  --pretty=format:'%C(yellow)%h%Creset - %Cblue[%an]%Creset: %s %Cgreen(%ar)%Creset'
