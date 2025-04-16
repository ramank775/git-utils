#!/bin/bash

set -e

git fetch -p

remote_branches=$(git branch -r | awk '{print $1}')
branches_to_delete=$(egrep -v -f <(echo "$remote_branches") <(git branch -vv | grep origin) | awk '{print $1}')

if [[ -z "$branches_to_delete" ]]; then
  echo "✅ No local branches to delete."
  exit 0
fi

echo "$branches_to_delete" | xargs git branch -d
