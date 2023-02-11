#!/usr/bin/env bash

set -e

# Cleanup
rm -rf $PWD/release

# Create release folder
mkdir -p $PWD/release

# Run build
docker build -t duckdb-lambda .
