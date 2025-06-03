#!/bin/bash -e

# Create layer folder
mkdir -p $PWD/layer

# Unzip to layer folder
unzip -d layer/ $PWD/duckdb-layer-x86_64.zip

cd $PWD/layer/nodejs/node_modules/duckdb

# Set package version to DuckDB version (make sure it doesn't fail if the same version exists locally)
npm version $DUCKDB_VERSION-1 2>/dev/null || true

# Check the lastest published package version
CURRENT_PUBLISHED_PACKAGE_VERSION="${$(npm view duckdb-lambda-x86 version 2>/dev/null):-not_published}"
# Check local package version
CURRENT_LOCAL_PACKAGE_VERSION=$(node -p "require('./package.json').version")

# Check if package shall be published
if [[ "$CURRENT_PUBLISHED_PACKAGE_VERSION" = "not_published" || "$CURRENT_LOCAL_PACKAGE_VERSION" != "$CURRENT_PUBLISHED_PACKAGE_VERSION" ]]; then
  # Publish to npm
  npm publish
fi
