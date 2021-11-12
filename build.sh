#!/bin/bash

set -xe
rm -rf working
mkdir working
cd working

# Checkout upstream

git clone --depth 1 --branch master https://github.com/docker-library/gcc
cd gcc

# Transform

# This sed syntax is GNU sed specific
[ -z $(command -v gsed) ] && GNU_SED=sed || GNU_SED=gsed

sed -i -e "1 s/FROM.*/FROM ghcr.io\/golden-containers\/buildpack-deps\:bullseye/; t" -e "1,// s//FROM ghcr.io\/golden-containers\/buildpack-deps\:bullseye/" 11/Dockerfile

# Build

docker build 11/ --tag ghcr.io/golden-containers/gcc:11 --label ${1:-DEBUG=TRUE}

# Push

docker push ghcr.io/golden-containers/gcc -a
