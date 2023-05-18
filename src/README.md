# duckdb-lambda
This npm package contain the current DuckDB version (`0.8.0`) specifically built to be able to run on Amazon Linux 2-based environments, such as AWS Lambda functions. The original [duckdb](https://www.npmjs.com/package/duckdb) npm package unfortunately doesn't work on AL2 due to the OSes outdated package versions, and the packaging. 

## Installation
You can install it for your project by running

```bash
npm i --save duckdb-lambda
```

## Usage
As this package is a repackaged version of the [duckdb](https://www.npmjs.com/package/duckdb) npm package, the same Node.js API can be used. Have a look at the [docs](https://duckdb.org/docs/api/nodejs/overview) to learn more.

```javascript
const duckdb = require('duckdb-lambda');

const db = new duckdb.Database(':memory:'); // or a file name for a persistent DB
```
## Lambda layer
You can alternatively use the free and public Lambda layer [tobilg/duckdb-nodejs-layer](https://github.com/tobilg/duckdb-nodejs-layer#pure-duckdb-layer).
