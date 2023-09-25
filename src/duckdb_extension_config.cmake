################################################################################
# NodeJS DuckDB extension config
################################################################################
#
# This is the default extension configuration for NodeJS builds. Basically it means that all these extensions are
# "baked in" to the NodeJS binaries Note that the configuration here is only when building Node using the main
# CMakeLists.txt file with the `BUILD_R` variable.
# TODO: unify this by making setup.py also use this configuration, making this the config for all Node builds

# See https://github.com/duckdb/duckdb/blob/main/.github/config/out_of_tree_extensions.cmake

duckdb_extension_load(fts)
duckdb_extension_load(httpfs)
duckdb_extension_load(icu)
duckdb_extension_load(json)
duckdb_extension_load(parquet)
duckdb_extension_load(visualizer)

duckdb_extension_load(postgres_scanner
        DONT_LINK
        GIT_URL https://github.com/duckdblabs/postgres_scanner
        GIT_TAG 828578442d18fb3acb53b08f4f54a0683217a2c8
	APPLY_PATCHES
        )
