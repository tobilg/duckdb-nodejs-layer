#!/usr/bin/env bash

set -e

# Cleanup
rm -rf $PWD/release

# Create release folder
mkdir -p $PWD/release

# Run build
docker build -t duckdb-lambda .

# Copy release
docker run -v $PWD/release:/opt/mount --rm -ti duckdb-lambda bash -c "cp /tmp/release/duckdb-layer.zip /opt/mount/"
