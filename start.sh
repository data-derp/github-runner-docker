#!/bin/bash

if [ -z "${REGISTRATION_TOKEN}" ]; then
  echo "REGISTRATION_TOKEN not set. Exiting"
  exit 1
fi

if [ -z "${REPO_URL}" ]; then
  echo "REPO_URL not set. Exiting"
  exit 1
fi

RUNNER_ALLOW_RUNASROOT=1 /actions-runner/config.sh --url ${REPO_URL} --token "${REGISTRATION_TOKEN}" --unattended
RUNNER_ALLOW_RUNASROOT=1 /actions-runner/run.sh