#!/bin/sh

set -xe
rm -rf working
mkdir working
cd working

# Checkout upstream

git clone --depth 1 --branch master https://github.com/docker-library/gcc
cd gcc

# Transform

sed -i -e "1 s/FROM.*/FROM ghcr.io\/golden-containers\/buildpack-deps\:bullseye/; t" -e "1,// s//FROM ghcr.io\/golden-containers\/buildpack-deps\:bullseye/" 11/Dockerfile
echo "LABEL ${1:-DEBUG=TRUE}" >> 11/Dockerfile

# Build

docker build --tag ghcr.io/golden-containers/gcc:11 11/

# Push

docker push ghcr.io/golden-containers/gcc -a
