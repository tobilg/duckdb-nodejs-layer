################################################################################
# NodeJS DuckDB extension config
################################################################################
#
# This is the default extension configuration for NodeJS builds. Basically it means that all these extensions are
# "baked in" to the NodeJS binaries Note that the configuration here is only when building Node using the main
# CMakeLists.txt file with the `BUILD_R` variable.
# TODO: unify this by making setup.py also use this configuration, making this the config for all Node builds

# See https://github.com/duckdb/duckdb/blob/main/.github/config/out_of_tree_extensions.cmake

duckdb_extension_load(postgres_scanner
        DONT_LINK
        GIT_URL https://github.com/duckdblabs/postgres_scanner
        GIT_TAG 844f46536b5d5f9e65b57b7ff92f4ce3346e2829
        )

if (WIN32)
    set(STATIC_LINK_SQLITE "DONT_LINK")
else ()
    set(STATIC_LINK_SQLITE "")
endif()

duckdb_extension_load(sqlite_scanner
        ${STATIC_LINK_SQLITE} LOAD_TESTS
        GIT_URL https://github.com/duckdblabs/sqlite_scanner
        GIT_TAG 3443b2999ae1e68a108568fd32145705237a5760
        )