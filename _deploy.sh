#!/bin/sh

set -e

echo GITHUB_PAT:
echo ${GITHUB_PAT}
echo TRAVIS_BRANCH:
echo ${TRAVIS_BRANCH}
echo TRAVIS_REPO_SLUG:
echo ${TRAVIS_REPO_SLUG}


[ -z "${GITHUB_PAT}" ] && exit 0
[ "${TRAVIS_BRANCH}" != "master" ] && exit 0

git config --global user.email "boris.demeshev@gmail.com"
git config --global user.name "Boris Demeshev"

git clone -b gh-pages https://${GITHUB_PAT}@github.com/${TRAVIS_REPO_SLUG}.git book-output
cd book-output
cp -r ../_book/* ./
git add --all *
git commit -m "Update the book" || true
git push origin gh-pages
