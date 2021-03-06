#!/bin/sh
set -e

export DEPLOY_BRANCH=${DEPLOY_BRANCH:-development}
export PUBLISH_BRANCH=${PUBLISH_BRANCH:-master}

if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_REPO_SLUG" != "fossasia/badge-magic-android" ] || ! [ "$TRAVIS_BRANCH" == "$DEPLOY_BRANCH" -o "$TRAVIS_BRANCH" == "$PUBLISH_BRANCH" ]; then
    echo "We decrypt key only for pushes to the master or development branch and not PRs. So, skip."
    exit 0
fi

openssl aes-256-cbc -K $encrypted_f10b5e0e5262_key -iv $encrypted_f10b5e0e5262_iv -in ./scripts/secrets.tar.enc -out ./scripts/secrets.tar -d
tar xvf ./scripts/secrets.tar -C scripts/