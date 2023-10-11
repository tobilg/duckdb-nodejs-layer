#
# This config file holds all out-of-tree extension that are built with DuckDB's CI
#
# to build duckdb with this configuration run:
#   EXTENSION_CONFIGS=.github/config/out_of_tree_extensions.cmake make
#

################# SPATIAL
duckdb_extension_load(spatial
        DONT_LINK LOAD_TESTS
        GIT_URL https://github.com/duckdblabs/duckdb_spatial.git
        GIT_TAG 36e5a126976ac3b66716893360ef7e6295707082
        INCLUDE_DIR spatial/include
        TEST_DIR test/sql
        )
