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

duckdb_extension_load(postgres_scanner
        DONT_LINK
        GIT_URL https://github.com/duckdblabs/postgres_scanner
        GIT_TAG 844f46536b5d5f9e65b57b7ff92f4ce3346e2829
        )

################# ARROW
if (NOT WIN32)
    duckdb_extension_load(arrow
            LOAD_TESTS DONT_LINK
            GIT_URL https://github.com/duckdblabs/arrow
            GIT_TAG 1b5b9649d28cd7f79496fb3f2e4dd7b03bf90ac5
            )
endif()

################# ICEBERG
# Windows tests for iceberg currently not working
if (NOT WIN32)
    set(LOAD_ICEBERG_TESTS "LOAD_TESTS")
else ()
    set(LOAD_ICEBERG_TESTS "")
endif()

duckdb_extension_load(iceberg
        ${LOAD_ICEBERG_TESTS}
        GIT_URL https://github.com/duckdblabs/duckdb_iceberg
        GIT_TAG 51ba9564859698c29db4165f17143a2f6af2bb18
        )

################# SPATIAL
duckdb_extension_load(spatial
        DONT_LINK LOAD_TESTS
        GIT_URL https://github.com/duckdblabs/duckdb_spatial.git
        GIT_TAG 36e5a126976ac3b66716893360ef7e6295707082
        INCLUDE_DIR spatial/include
        TEST_DIR test/sql
        )

################# SQLITE_SCANNER
# Static linking on windows does not properly work due to symbol collision
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

################# SUBSTRAIT
if (NOT WIN32)
    duckdb_extension_load(substrait
            LOAD_TESTS DONT_LINK
            GIT_URL https://github.com/duckdblabs/substrait
            GIT_TAG 5d621b1d7d16fe86f8b1930870c8e6bf05bcb92a
            )
endif()
