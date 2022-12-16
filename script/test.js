const DuckDB = require('duckdb');

const duckDB = new DuckDB.Database(':memory:');

// Create connection
const connection = duckDB.connect();
