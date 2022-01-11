#!/usr/bin/env bash

set -e
script_dir=$(cd "$(dirname "$0")" ; pwd -P)

goal_build() {
  pushd "${script_dir}" > /dev/null
    docker build -t github-runner .
  popd > /dev/null
}

goal_run() {
  pushd "${script_dir}" > /dev/null
    ${script_dir}/run.sh "$@"
  popd > /dev/null
}

TARGET=${1:-}
if type -t "goal_${TARGET}" &>/dev/null; then
  "goal_${TARGET}" ${@:2}
else
  echo "Usage: $0 <goal>

goal:
    build                       - builds container
    run                         - runs container
"
  exit 1
fi
