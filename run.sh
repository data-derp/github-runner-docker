#!/bin/bash

set -e

repo_url=${1}
username=${2}

if [ -z "${repo_url}" ]; then
  echo "REPO_URL not set. Usage <func> REPO_URL GITHUB_USERNAME"
  exit 1
fi

if [ -z "${username}" ]; then
  echo "GITHUB_USERNAME not set. Usage <func> REPO_URL GITHUB_USERNAME"
  exit 1
fi

repo_name=$([[ $repo_url =~ github.com.*[\/|\:](.*[\/|\:].*)$ ]] && echo "${BASH_REMATCH[1]}")

fetch-github-registration-token() {
  username="${1}"

  if [ -z "${username}" ]; then
    echo "USERNAME not set. Usage <func:fetch-github-registration-token> USERNAME"
    exit 1
  fi

  response=$(curl \
    -u $username \
    -X POST \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/repos/${repo_name}/actions/runners/registration-token)

  echo $response | jq -r .token
}

reg_token=$(fetch-github-registration-token $username)

docker run -it \
  -e REPO_URL="${repo_url}" \
  -e REGISTRATION_TOKEN="${reg_token}" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /var/lib/docker:/var/lib/docker \
  -v $HOME/.aws/credentials:/root/.aws/credentials:ro \
  github-runner bash
