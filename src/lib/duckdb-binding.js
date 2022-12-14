// See https://github.com/mapbox/node-pre-gyp#3-dynamically-require-your-node

// Release can be found in release/duckdb.node
var binding = require('../release/duckdb.node');

module.exports = exports = binding;
