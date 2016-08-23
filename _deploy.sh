#!/bin/sh

set -e


GITHUB_PAT=PXSNgd3uFca/LIhW86thBEnoH4SvU2t/LCCpkX0VO4ulooJI7HgZHGmkaorOv229FmMzN2HRAEeIPBS9qzpJxcRzua8Kp9GhumVzs9fQ9apJVVsyhrZcv4x7jgq85/aIZ/1pJeeQQ0PairJhvQ7gppYZx0tzXkEbGu1jUJ9ftf4XArh1Z+LOTB2qHXrBs3cj70+3SVzqw9/e7CUbL4HvqLZDBzpShYVEdGjikyyoE34+jrR4MYIqYMQ0njMWUuq3zhqp/WcfT2ESgi1Ptm1PebNpKWMUyqjK5tNpUENGT7BzziTJjFJJYirUZNRXrJBwLw4qAslSfsRJkcBLN8WST4govTVbdiaFV25yLrSgm87+ZyKpcANrmrNfshhaZ2HBDZQQttlCNoIwmeT8XkIH7eGhTYC0PI9iuptpF8ATFN++RTitXNFWOKiaZerQ8/8zn4/GRdmwOwK2a1Krp+eTfEOOTNj1dTfFe1j0IGABaMPIiPJ/UO1wrQzzkAQMJrUafW8/z/UTizKKS3gDs+uiPuDlnXU8DsgV3QzI+l2Vi4wO+snSJdfeAn7MZ8mL/9/dLhbe1B62sj2b/+tsjTUb/e8o8P7i4tssoVUPjyOye5VPl9gEaMhURnrAoPv1nO8v8co5DYoIghp3mEWdlNMIHEye+VUBhIbsxBstyxW1hO8=
# may put anything instead of test??? just no spaces around = (!)


echo GH_TOKEN:
echo ${GH_TOKEN}
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

git add --all
# removed * at the end of the line

git commit -a -m "Update the book (${TRAVIS_BUILD_NUMBER})" || true

git push origin gh-pages
