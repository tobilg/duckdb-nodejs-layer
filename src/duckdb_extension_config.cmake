################################################################################
# NodeJS DuckDB extension config
################################################################################
#
# This is the default extension configuration for NodeJS builds. Basically it means that all these extensions are
# "baked in" to the NodeJS binaries Note that the configuration here is only when building Node using the main
# CMakeLists.txt file with the `BUILD_R` variable.
# TODO: unify this by making setup.py also use this configuration, making this the config for all Node builds

# See https://github.com/duckdb/duckdb/blob/main/.github/config/out_of_tree_extensions.cmake

duckdb_extension_load(autocomplete)
duckdb_extension_load(fts)
duckdb_extension_load(httpfs)
duckdb_extension_load(inet)
duckdb_extension_load(icu)
duckdb_extension_load(json)
duckdb_extension_load(parquet)
duckdb_extension_load(sqlsmith)
duckdb_extension_load(visualizer)

################# SPATIAL
duckdb_extension_load(spatial
        DONT_LINK LOAD_TESTS
        GIT_URL https://github.com/duckdblabs/duckdb_spatial.git
        GIT_TAG 36e5a126976ac3b66716893360ef7e6295707082
        INCLUDE_DIR spatial/include
        TEST_DIR test/sql
        )
