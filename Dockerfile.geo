FROM amazon/aws-lambda-nodejs:16 as builder

ARG DUCKDB_VERSION=v0.7.1

# Install dependencies
RUN yum update -y && \
  yum install git zip ninja-build make gcc-c++ openssl11-devel cmake3 -y && \
  yum remove cmake -y && \
  ln -s /usr/bin/cmake3 /usr/bin/cmake

# Get DuckDB sources
RUN mkdir -p /tmp/from-git && cd /tmp/from-git && git clone https://github.com/handstuyennn/geo.git --branch $DUCKDB_VERSION && cd geo && git fetch --all --tags

# Configure
RUN cd /tmp/from-git/geo && make

RUN strip --strip-unneeded /tmp/from-git/geo/build/release/extension/geo/geo.duckdb_extension

# Create zip file with layer contents
RUN mkdir -p /tmp/release && cp /tmp/from-git/geo/build/release/extension/geo/geo.duckdb_extension /tmp/release/geo.duckdb_extension
