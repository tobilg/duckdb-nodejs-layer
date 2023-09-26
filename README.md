# duckdb-nodejs-layer
Packaging DuckDB for usage in AWS Lambda functions with Node.js, with and without community extensions, and publishing as public Lambda layers.

# Usage
You can use the published layers in your own serverless applications by referencing it as outlined in the different framework's docs:

* [Serverless Framework](https://www.serverless.com/framework/docs/providers/aws/guide/serverless.yml/#functions)
* [SAM](https://aws.amazon.com/blogs/compute/working-with-aws-lambda-and-lambda-layers-in-aws-sam/)
* [CDK](https://docs.aws.amazon.com/cdk/api/v1/docs/aws-lambda-readme.html#layers)
* [CloudFormation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-function.html#cfn-lambda-function-layers)

The layers get automatically published to all currently available (in the moment of publishing) AWS regions.

## Example usage
You can have a look at the example repository, which uses this AWS Lambda layer: [tobilg/serverless-duckdb](https://github.com/tobilg/serverless-duckdb). More specifically, the [src/functions/query.js](https://github.com/tobilg/serverless-duckdb/blob/main/src/functions/query.js) should give you a good idea on how it can be used.

The recommendation is to use a bundler such as WebPack for the packaging of your application. This means you can locally use (e.g. for testing) the official [duckdb](https://www.npmjs.com/package/duckdb) npm package (via `npm i --save duckdb`), but [exclude it](https://github.com/tobilg/serverless-duckdb/blob/main/webpack.config.serverless.js#L27) in the packaging process, because after being deployed to a Lambda function, the updated DuckDB version from the Lambda layer will be used.

### Code example

```javascript
import DuckDB from 'duckdb';

// Instantiate DuckDB
const duckDB = new DuckDB.Database(':memory:');

// Create connection
const connection = duckDB.connect();

// Promisify query method
const query = (query) => {
  return new Promise((resolve, reject) => {
    connection.all(query, (err, res) => {
      if (err) reject(err);
      resolve(res);
    })
  })
}

// Will show DuckDB version
await query(`PRAGMA version;`);
```

# Layer flavors
The layer comes in two different flavors, one "pure" DuckDB layer with some basic extensions enabled, and a version that contains the [spatial](https://github.com/duckdblabs/duckdb_spatial) extension.

## Pure DuckDB layer
The ARNs follow the following logic:
```text
arn:aws:lambda:$REGION:041475135427:layer:duckdb-nodejs-$ARCHITECTURE:$VERSION
```

where `$ARCHITECTURE` can have the following values:

* `x86`
* `arm64`

### Enabled extensions
The following DuckDB default extensions are enabled and contained in the static build:

* `parquet`: Adds support for reading and writing parquet files
* `httpfs`: Adds support for reading and writing files over a HTTP(S) connection
* `json`: Adds support for JSON operations
* `fts`: Adds support for Full-Text Search Indexes
* `icu`: Adds support for time zones and collations using the ICU library

### x86 layer ARNs

**Layer version to DuckDB version mapping:**
| Layer version   | DuckDB version |
|-----------------|----------------|
| 3               | v0.8.0         |
| 4               | v0.8.1         |
| 5               | v0.9.0         |

The **ARNs** of the latest x86 version of the DuckDB Node.js Lambda layer are:
| Region          | Layer ARN |
|-----------------|-----------|
| af-south-1 | arn:aws:lambda:af-south-1:041475135427:layer:duckdb-nodejs-x86:5 |
| ap-east-1 | arn:aws:lambda:ap-east-1:041475135427:layer:duckdb-nodejs-x86:5 |
| ap-northeast-1 | arn:aws:lambda:ap-northeast-1:041475135427:layer:duckdb-nodejs-x86:5 |
| ap-northeast-2 | arn:aws:lambda:ap-northeast-2:041475135427:layer:duckdb-nodejs-x86:5 |
| ap-northeast-3 | arn:aws:lambda:ap-northeast-3:041475135427:layer:duckdb-nodejs-x86:5 |
| ap-south-1 | arn:aws:lambda:ap-south-1:041475135427:layer:duckdb-nodejs-x86:5 |
| ap-south-2 | arn:aws:lambda:ap-south-2:041475135427:layer:duckdb-nodejs-x86:5 |
| ap-southeast-1 | arn:aws:lambda:ap-southeast-1:041475135427:layer:duckdb-nodejs-x86:5 |
| ap-southeast-2 | arn:aws:lambda:ap-southeast-2:041475135427:layer:duckdb-nodejs-x86:5 |
| ap-southeast-3 | arn:aws:lambda:ap-southeast-3:041475135427:layer:duckdb-nodejs-x86:5 |
| ap-southeast-4 | arn:aws:lambda:ap-southeast-4:041475135427:layer:duckdb-nodejs-x86:5 |
| ca-central-1 | arn:aws:lambda:ca-central-1:041475135427:layer:duckdb-nodejs-x86:5 |
| eu-central-1 | arn:aws:lambda:eu-central-1:041475135427:layer:duckdb-nodejs-x86:5 |
| eu-central-2 | arn:aws:lambda:eu-central-2:041475135427:layer:duckdb-nodejs-x86:5 |
| eu-north-1 | arn:aws:lambda:eu-north-1:041475135427:layer:duckdb-nodejs-x86:5 |
| eu-south-1 | arn:aws:lambda:eu-south-1:041475135427:layer:duckdb-nodejs-x86:5 |
| eu-south-2 | arn:aws:lambda:eu-south-2:041475135427:layer:duckdb-nodejs-x86:5 |
| eu-west-1 | arn:aws:lambda:eu-west-1:041475135427:layer:duckdb-nodejs-x86:5 |
| eu-west-2 | arn:aws:lambda:eu-west-2:041475135427:layer:duckdb-nodejs-x86:5 |
| eu-west-3 | arn:aws:lambda:eu-west-3:041475135427:layer:duckdb-nodejs-x86:5 |
| me-central-1 | arn:aws:lambda:me-central-1:041475135427:layer:duckdb-nodejs-x86:5 |
| me-south-1 | arn:aws:lambda:me-south-1:041475135427:layer:duckdb-nodejs-x86:5 |
| sa-east-1 | arn:aws:lambda:sa-east-1:041475135427:layer:duckdb-nodejs-x86:5 |
| us-east-1 | arn:aws:lambda:us-east-1:041475135427:layer:duckdb-nodejs-x86:5 |
| us-east-2 | arn:aws:lambda:us-east-2:041475135427:layer:duckdb-nodejs-x86:5 |
| us-west-1 | arn:aws:lambda:us-west-1:041475135427:layer:duckdb-nodejs-x86:5 |
| us-west-2 | arn:aws:lambda:us-west-2:041475135427:layer:duckdb-nodejs-x86:5 |

### arm64 layer ARNs

**Layer version to DuckDB version mapping:**
| Layer version   | DuckDB version |
|-----------------|----------------|
| 1               | v0.8.0         |
| 2               | v0.8.1         |
| 3               | v0.9.0         |

The **ARNs** of the latest arm64 version of the DuckDB Node.js Lambda layer are:
| Region          | Layer ARN |
|-----------------|-----------|
| us-east-1 | arn:aws:lambda:us-east-1:041475135427:layer:duckdb-nodejs-arm64:3 |
| us-east-2 | arn:aws:lambda:us-east-2:041475135427:layer:duckdb-nodejs-arm64:3 |
| us-west-1 | arn:aws:lambda:us-west-1:041475135427:layer:duckdb-nodejs-arm64:3 |
| us-west-2 | arn:aws:lambda:us-west-2:041475135427:layer:duckdb-nodejs-arm64:3 |
| af-south-1 | arn:aws:lambda:af-south-1:041475135427:layer:duckdb-nodejs-arm64:3 |
| ap-east-1 | arn:aws:lambda:ap-east-1:041475135427:layer:duckdb-nodejs-arm64:3 |
| ap-southeast-3 | arn:aws:lambda:ap-southeast-3:041475135427:layer:duckdb-nodejs-arm64:3 |
| ap-south-1 | arn:aws:lambda:ap-south-1:041475135427:layer:duckdb-nodejs-arm64:3 |
| ap-northeast-3 | arn:aws:lambda:ap-northeast-3:041475135427:layer:duckdb-nodejs-arm64:3 |
| ap-northeast-2 | arn:aws:lambda:ap-northeast-2:041475135427:layer:duckdb-nodejs-arm64:3 |
| ap-southeast-1 | arn:aws:lambda:ap-southeast-1:041475135427:layer:duckdb-nodejs-arm64:3 |
| ap-southeast-2 | arn:aws:lambda:ap-southeast-2:041475135427:layer:duckdb-nodejs-arm64:3 |
| ap-northeast-1 | arn:aws:lambda:ap-northeast-1:041475135427:layer:duckdb-nodejs-arm64:3 |
| ca-central-1 | arn:aws:lambda:ca-central-1:041475135427:layer:duckdb-nodejs-arm64:3 |
| eu-central-1 | arn:aws:lambda:eu-central-1:041475135427:layer:duckdb-nodejs-arm64:3 |
| eu-west-1 | arn:aws:lambda:eu-west-1:041475135427:layer:duckdb-nodejs-arm64:3 |
| eu-west-2 | arn:aws:lambda:eu-west-2:041475135427:layer:duckdb-nodejs-arm64:3 |
| eu-south-1 | arn:aws:lambda:eu-south-1:041475135427:layer:duckdb-nodejs-arm64:3 |
| eu-west-3 | arn:aws:lambda:eu-west-3:041475135427:layer:duckdb-nodejs-arm64:3 |
| eu-north-1 | arn:aws:lambda:eu-north-1:041475135427:layer:duckdb-nodejs-arm64:3 |
| me-south-1 | arn:aws:lambda:me-south-1:041475135427:layer:duckdb-nodejs-arm64:3 |
| sa-east-1 | arn:aws:lambda:sa-east-1:041475135427:layer:duckdb-nodejs-arm64:3 |

## Spatial extension DuckDB layer
The ARNs follow the following logic:
```text
arn:aws:lambda:$REGION:041475135427:layer:duckdb-nodejs-spatial-x86:$VERSION
```

### Enabled default extensions
The following DuckDB extensions are enabled and contained in the static build:

* `parquet`: Adds support for reading and writing parquet files
* `httpfs`: Adds support for reading and writing files over a HTTP(S) connection
* `json`: Adds support for JSON operations
* `fts`: Adds support for Full-Text Search Indexes
* `icu`: Adds support for time zones and collations using the ICU library

### Loadable spatial extension
The [duckdb_spatial](https://github.com/duckdblabs/duckdb_spatial) extension is contained in the layer, and can be loaded via

```sql
LOAD '/opt/nodejs/node_modules/duckdb/extensions/spatial.duckdb_extension';
```

### Usage
To check if the loaded extenstion works, you can run the following query:

```sql
SELECT * FROM st_drivers();
```

This will show you the list of supported file type drivers. For more info please have a look at the following resources:

* [Spatial extension blog post](https://duckdb.org/2023/04/28/spatial.html)
* [Spatial extension GitHub repo](https://github.com/duckdblabs/duckdb_spatial)


### ARNs

The **ARNs** of the latest version of the DuckDB Node.js Lambda layer with community extensions are:
| Region          | Layer ARN |
|-----------------|-----------|
| af-south-1 | arn:aws:lambda:af-south-1:041475135427:layer:duckdb-nodejs-spatial-x86:2 |
| ap-east-1 | arn:aws:lambda:ap-east-1:041475135427:layer:duckdb-nodejs-spatial-x86:2 |
| ap-northeast-1 | arn:aws:lambda:ap-northeast-1:041475135427:layer:duckdb-nodejs-spatial-x86:2 |
| ap-northeast-2 | arn:aws:lambda:ap-northeast-2:041475135427:layer:duckdb-nodejs-spatial-x86:2 |
| ap-northeast-3 | arn:aws:lambda:ap-northeast-3:041475135427:layer:duckdb-nodejs-spatial-x86:2 |
| ap-south-1 | arn:aws:lambda:ap-south-1:041475135427:layer:duckdb-nodejs-spatial-x86:2 |
| ap-south-2 | arn:aws:lambda:ap-south-2:041475135427:layer:duckdb-nodejs-spatial-x86:2 |
| ap-southeast-1 | arn:aws:lambda:ap-southeast-1:041475135427:layer:duckdb-nodejs-spatial-x86:2 |
| ap-southeast-2 | arn:aws:lambda:ap-southeast-2:041475135427:layer:duckdb-nodejs-spatial-x86:2 |
| ap-southeast-3 | arn:aws:lambda:ap-southeast-3:041475135427:layer:duckdb-nodejs-spatial-x86:2 |
| ap-southeast-4 | arn:aws:lambda:ap-southeast-4:041475135427:layer:duckdb-nodejs-spatial-x86:2 |
| ca-central-1 | arn:aws:lambda:ca-central-1:041475135427:layer:duckdb-nodejs-spatial-x86:2 |
| eu-central-1 | arn:aws:lambda:eu-central-1:041475135427:layer:duckdb-nodejs-spatial-x86:2 |
| eu-central-2 | arn:aws:lambda:eu-central-2:041475135427:layer:duckdb-nodejs-spatial-x86:2 |
| eu-north-1 | arn:aws:lambda:eu-north-1:041475135427:layer:duckdb-nodejs-spatial-x86:2 |
| eu-south-1 | arn:aws:lambda:eu-south-1:041475135427:layer:duckdb-nodejs-spatial-x86:2 |
| eu-south-2 | arn:aws:lambda:eu-south-2:041475135427:layer:duckdb-nodejs-spatial-x86:2 |
| eu-west-1 | arn:aws:lambda:eu-west-1:041475135427:layer:duckdb-nodejs-spatial-x86:2 |
| eu-west-2 | arn:aws:lambda:eu-west-2:041475135427:layer:duckdb-nodejs-spatial-x86:2 |
| eu-west-3 | arn:aws:lambda:eu-west-3:041475135427:layer:duckdb-nodejs-spatial-x86:2 |
| me-central-1 | arn:aws:lambda:me-central-1:041475135427:layer:duckdb-nodejs-spatial-x86:2 |
| me-south-1 | arn:aws:lambda:me-south-1:041475135427:layer:duckdb-nodejs-spatial-x86:2 |
| sa-east-1 | arn:aws:lambda:sa-east-1:041475135427:layer:duckdb-nodejs-spatial-x86:2 |
| us-east-1 | arn:aws:lambda:us-east-1:041475135427:layer:duckdb-nodejs-spatial-x86:2 |
| us-east-2 | arn:aws:lambda:us-east-2:041475135427:layer:duckdb-nodejs-spatial-x86:2 |
| us-west-1 | arn:aws:lambda:us-west-1:041475135427:layer:duckdb-nodejs-spatial-x86:2 |
| us-west-2 | arn:aws:lambda:us-west-2:041475135427:layer:duckdb-nodejs-spatial-x86:2 |
