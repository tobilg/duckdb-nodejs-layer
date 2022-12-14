# duckdb-lambda
Packaging DuckDB for Lambda functions

## Building

Run `$ ./build_layer.sh` to build the DuckDB custom Node.js client

## Getting the artifacts

Run `docker run -v $PWD/release:/opt/mount --rm -ti --entrypoint bash duckdb-lambda` to get a shell in the container. After that, run `cp /tmp/release/duckdb-layer.zip /opt/mount/` to copy the artifacts to the mounted directory.

To unzip the artifacts, run `cd release && unzip duckdb-layer.zip`.

## Publishing the layer

You need an installed Serverless Framework (v2/v3). Then run `sls deploy`.
