# duckdb-nodejs-layer
Packaging DuckDB for usage in AWS Lambda functions with Node.js, and publishing as public Lambda layers.

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

# DuckDB layer
This contains a AWS Lambda layer in different flavors, both `x86` and `arm64` architectures are supported.

The ARNs follow the following logic:
```text
arn:aws:lambda:$REGION:041475135427:layer:duckdb-nodejs-$ARCHITECTURE:$VERSION
```

where `$ARCHITECTURE` can have the following values:

* `x86`
* `arm64`

## Enabled extensions
The following DuckDB default extensions are enabled and contained in the static build:

* `parquet`: Adds support for reading and writing parquet files
* `httpfs`: Adds support for reading and writing files over a HTTP(S) connection
* `json`: Adds support for JSON operations
* `icu`: Adds support for time zones and collations using the ICU library

## x86 layer ARNs

**Layer version to DuckDB version mapping:**
| Layer version   | DuckDB version |
|-----------------|----------------|
| 3               | v0.8.0         |
| 4               | v0.8.1         |
| 5               | v0.9.0         |
| 6               | v0.9.1         |
| 7               | v0.9.2         |
| 8               | v0.10.0        |
| 9               | v0.10.1        |
| 10              | v0.10.2        |
| 11              | v1.0.0         |
| 12              | v1.1.0         |
| 13              | v1.1.1         |
| 14              | v1.1.3         |
| 15              | v1.2.0         |
| 16              | v1.2.1         |
| 17              | v1.3.0         |

The **ARNs** of the latest x86 version of the DuckDB Node.js Lambda layer are:
| Region          | Layer ARN |
|-----------------|-----------|
| af-south-1 | arn:aws:lambda:af-south-1:041475135427:layer:duckdb-nodejs-x86:17 |
| ap-east-1 | arn:aws:lambda:ap-east-1:041475135427:layer:duckdb-nodejs-x86:17 |
| ap-northeast-1 | arn:aws:lambda:ap-northeast-1:041475135427:layer:duckdb-nodejs-x86:17 |
| ap-northeast-2 | arn:aws:lambda:ap-northeast-2:041475135427:layer:duckdb-nodejs-x86:17 |
| ap-northeast-3 | arn:aws:lambda:ap-northeast-3:041475135427:layer:duckdb-nodejs-x86:17 |
| ap-south-1 | arn:aws:lambda:ap-south-1:041475135427:layer:duckdb-nodejs-x86:17 |
| ap-south-2 | arn:aws:lambda:ap-south-2:041475135427:layer:duckdb-nodejs-x86:17 |
| ap-southeast-1 | arn:aws:lambda:ap-southeast-1:041475135427:layer:duckdb-nodejs-x86:17 |
| ap-southeast-2 | arn:aws:lambda:ap-southeast-2:041475135427:layer:duckdb-nodejs-x86:17 |
| ap-southeast-3 | arn:aws:lambda:ap-southeast-3:041475135427:layer:duckdb-nodejs-x86:17 |
| ap-southeast-4 | arn:aws:lambda:ap-southeast-4:041475135427:layer:duckdb-nodejs-x86:17 |
| ca-central-1 | arn:aws:lambda:ca-central-1:041475135427:layer:duckdb-nodejs-x86:17 |
| eu-central-1 | arn:aws:lambda:eu-central-1:041475135427:layer:duckdb-nodejs-x86:17 |
| eu-central-2 | arn:aws:lambda:eu-central-2:041475135427:layer:duckdb-nodejs-x86:17 |
| eu-north-1 | arn:aws:lambda:eu-north-1:041475135427:layer:duckdb-nodejs-x86:17 |
| eu-south-1 | arn:aws:lambda:eu-south-1:041475135427:layer:duckdb-nodejs-x86:17 |
| eu-south-2 | arn:aws:lambda:eu-south-2:041475135427:layer:duckdb-nodejs-x86:17 |
| eu-west-1 | arn:aws:lambda:eu-west-1:041475135427:layer:duckdb-nodejs-x86:17 |
| eu-west-2 | arn:aws:lambda:eu-west-2:041475135427:layer:duckdb-nodejs-x86:17 |
| eu-west-3 | arn:aws:lambda:eu-west-3:041475135427:layer:duckdb-nodejs-x86:17 |
| me-central-1 | arn:aws:lambda:me-central-1:041475135427:layer:duckdb-nodejs-x86:17 |
| me-south-1 | arn:aws:lambda:me-south-1:041475135427:layer:duckdb-nodejs-x86:17 |
| sa-east-1 | arn:aws:lambda:sa-east-1:041475135427:layer:duckdb-nodejs-x86:17 |
| us-east-1 | arn:aws:lambda:us-east-1:041475135427:layer:duckdb-nodejs-x86:17 |
| us-east-2 | arn:aws:lambda:us-east-2:041475135427:layer:duckdb-nodejs-x86:17 |
| us-west-1 | arn:aws:lambda:us-west-1:041475135427:layer:duckdb-nodejs-x86:17 |
| us-west-2 | arn:aws:lambda:us-west-2:041475135427:layer:duckdb-nodejs-x86:17 |

## arm64 layer ARNs

**Layer version to DuckDB version mapping:**
| Layer version   | DuckDB version |
|-----------------|----------------|
| 1               | v0.8.0         |
| 2               | v0.8.1         |
| 3               | v0.9.0         |
| 4               | v0.9.1         |
| 5               | v0.9.2         |
| 6               | v0.10.0        |
| 7               | v0.10.1        |
| 8               | v0.10.2        |
| 9               | v1.0.0         |
| 10              | v1.1.0         |
| 11              | v1.1.1         |
| 12              | v1.1.3         |
| 13              | v1.2.0         |
| 14              | v1.2.1         |
| 15              | v1.3.0         |

The **ARNs** of the latest arm64 version of the DuckDB Node.js Lambda layer are:
| Region          | Layer ARN |
|-----------------|-----------|
| us-east-1 | arn:aws:lambda:us-east-1:041475135427:layer:duckdb-nodejs-arm64:15 |
| us-east-2 | arn:aws:lambda:us-east-2:041475135427:layer:duckdb-nodejs-arm64:15 |
| us-west-1 | arn:aws:lambda:us-west-1:041475135427:layer:duckdb-nodejs-arm64:15 |
| us-west-2 | arn:aws:lambda:us-west-2:041475135427:layer:duckdb-nodejs-arm64:15 |
| af-south-1 | arn:aws:lambda:af-south-1:041475135427:layer:duckdb-nodejs-arm64:15 |
| ap-east-1 | arn:aws:lambda:ap-east-1:041475135427:layer:duckdb-nodejs-arm64:15 |
| ap-southeast-3 | arn:aws:lambda:ap-southeast-3:041475135427:layer:duckdb-nodejs-arm64:15 |
| ap-south-1 | arn:aws:lambda:ap-south-1:041475135427:layer:duckdb-nodejs-arm64:15 |
| ap-northeast-3 | arn:aws:lambda:ap-northeast-3:041475135427:layer:duckdb-nodejs-arm64:15 |
| ap-northeast-2 | arn:aws:lambda:ap-northeast-2:041475135427:layer:duckdb-nodejs-arm64:15 |
| ap-southeast-1 | arn:aws:lambda:ap-southeast-1:041475135427:layer:duckdb-nodejs-arm64:15 |
| ap-southeast-2 | arn:aws:lambda:ap-southeast-2:041475135427:layer:duckdb-nodejs-arm64:15 |
| ap-northeast-1 | arn:aws:lambda:ap-northeast-1:041475135427:layer:duckdb-nodejs-arm64:15 |
| ca-central-1 | arn:aws:lambda:ca-central-1:041475135427:layer:duckdb-nodejs-arm64:15 |
| eu-central-1 | arn:aws:lambda:eu-central-1:041475135427:layer:duckdb-nodejs-arm64:15 |
| eu-west-1 | arn:aws:lambda:eu-west-1:041475135427:layer:duckdb-nodejs-arm64:15 |
| eu-west-2 | arn:aws:lambda:eu-west-2:041475135427:layer:duckdb-nodejs-arm64:15 |
| eu-south-1 | arn:aws:lambda:eu-south-1:041475135427:layer:duckdb-nodejs-arm64:15 |
| eu-west-3 | arn:aws:lambda:eu-west-3:041475135427:layer:duckdb-nodejs-arm64:15 |
| eu-north-1 | arn:aws:lambda:eu-north-1:041475135427:layer:duckdb-nodejs-arm64:15 |
| me-south-1 | arn:aws:lambda:me-south-1:041475135427:layer:duckdb-nodejs-arm64:15 |
| sa-east-1 | arn:aws:lambda:sa-east-1:041475135427:layer:duckdb-nodejs-arm64:15 |


## x86_64 layer with arrow, aws and httpfs extensions ARNs
This layer contains the arrow, aws and httpfs extensions. This enables Lambda functions that are in a VPC and have no internet access to download these extensions via HTTP (e.g. from [extensions.quacking.cloud](https://extensions.quacking.cloud)) for cost savings.

VPC access is for example necessary if you want your Lambda functions to access S3 Express One Zone. You can have a look at how to deploy such kind of setup in the [tobilg/serverless-duckdb](https://github.com/tobilg/serverless-duckdb/blob/main/serverless.yml#L112-L147) repo.

Currently, it's only available in `us-east-1`.

**Layer version to DuckDB version mapping:**
| Layer version   | DuckDB version |
|-----------------|----------------|
| 1               | v0.10.0        |
| 2               | v0.10.1        |
| 4               | v0.10.2        |
| 5               | v1.0.0         |
| 6               | v1.1.0         |

The **ARNs** of the latest x86_64 version of the DuckDB Node.js Lambda layer with extensions are:
| Region          | Layer ARN |
|-----------------|-----------|
| us-east-1 | arn:aws:lambda:us-east-1:041475135427:layer:duckdb-extensions-nodejs-x86:6 |
