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
Hava a look at the example repository which uses this AWS Lambda layer:

* https://github.com/tobilg/serverless-duckdb

# Layer flavors
The layer comes in two different flavors, one "pure" DuckDB layer with some basic extensions enabled, and a version that contains selected community extensions.

## Pure DuckDB layer
The ARNs follow the following logic:
```text
arn:aws:lambda:$REGION:041475135427:layer:duckdb-nodejs-x86:$VERSION
```

### Enabled extensions
The following DuckDB extensions are enabled and contained in the static build:

* `parquet`: Adds support for reading and writing parquet files
* `httpfs`: Adds support for reading and writing files over a HTTP(S) connection
* `json`: Adds support for JSON operations
* `fts`: Adds support for Full-Text Search Indexes
* `icu`: Adds support for time zones and collations using the ICU library

### ARNs

The **ARNs** of the latest version of the DuckDB Node.js Lambda layer are:
| Region          | Layer ARN |
|-----------------|-----------|
| af-south-1 | arn:aws:lambda:af-south-1:041475135427:layer:duckdb-nodejs-x86:2 |
| ap-east-1 | arn:aws:lambda:ap-east-1:041475135427:layer:duckdb-nodejs-x86:2 |
| ap-northeast-1 | arn:aws:lambda:ap-northeast-1:041475135427:layer:duckdb-nodejs-x86:2 |
| ap-northeast-2 | arn:aws:lambda:ap-northeast-2:041475135427:layer:duckdb-nodejs-x86:2 |
| ap-northeast-3 | arn:aws:lambda:ap-northeast-3:041475135427:layer:duckdb-nodejs-x86:2 |
| ap-south-1 | arn:aws:lambda:ap-south-1:041475135427:layer:duckdb-nodejs-x86:2 |
| ap-south-2 | arn:aws:lambda:ap-south-2:041475135427:layer:duckdb-nodejs-x86:2 |
| ap-southeast-1 | arn:aws:lambda:ap-southeast-1:041475135427:layer:duckdb-nodejs-x86:2 |
| ap-southeast-2 | arn:aws:lambda:ap-southeast-2:041475135427:layer:duckdb-nodejs-x86:2 |
| ap-southeast-3 | arn:aws:lambda:ap-southeast-3:041475135427:layer:duckdb-nodejs-x86:2 |
| ap-southeast-4 | arn:aws:lambda:ap-southeast-4:041475135427:layer:duckdb-nodejs-x86:2 |
| ca-central-1 | arn:aws:lambda:ca-central-1:041475135427:layer:duckdb-nodejs-x86:2 |
| eu-central-1 | arn:aws:lambda:eu-central-1:041475135427:layer:duckdb-nodejs-x86:2 |
| eu-central-2 | arn:aws:lambda:eu-central-2:041475135427:layer:duckdb-nodejs-x86:2 |
| eu-north-1 | arn:aws:lambda:eu-north-1:041475135427:layer:duckdb-nodejs-x86:2 |
| eu-south-1 | arn:aws:lambda:eu-south-1:041475135427:layer:duckdb-nodejs-x86:2 |
| eu-south-2 | arn:aws:lambda:eu-south-2:041475135427:layer:duckdb-nodejs-x86:2 |
| eu-west-1 | arn:aws:lambda:eu-west-1:041475135427:layer:duckdb-nodejs-x86:2 |
| eu-west-2 | arn:aws:lambda:eu-west-2:041475135427:layer:duckdb-nodejs-x86:2 |
| eu-west-3 | arn:aws:lambda:eu-west-3:041475135427:layer:duckdb-nodejs-x86:2 |
| me-central-1 | arn:aws:lambda:me-central-1:041475135427:layer:duckdb-nodejs-x86:2 |
| me-south-1 | arn:aws:lambda:me-south-1:041475135427:layer:duckdb-nodejs-x86:2 |
| sa-east-1 | arn:aws:lambda:sa-east-1:041475135427:layer:duckdb-nodejs-x86:2 |
| us-east-1 | arn:aws:lambda:us-east-1:041475135427:layer:duckdb-nodejs-x86:2 |
| us-east-2 | arn:aws:lambda:us-east-2:041475135427:layer:duckdb-nodejs-x86:2 |
| us-west-1 | arn:aws:lambda:us-west-1:041475135427:layer:duckdb-nodejs-x86:2 |

## Community extensions DuckDB layer
The ARNs follow the following logic:
```text
arn:aws:lambda:$REGION:041475135427:layer:duckdb-nodejs-extensions-x86:$VERSION
```

### Enabled extensions
The following DuckDB extensions are enabled and contained in the static build:

* `parquet`: Adds support for reading and writing parquet files
* `httpfs`: Adds support for reading and writing files over a HTTP(S) connection
* `json`: Adds support for JSON operations
* `fts`: Adds support for Full-Text Search Indexes
* `icu`: Adds support for time zones and collations using the ICU library

### Loadable extensions
The following DuckDB community extensions are contained in the layer, and can be loaded via

```sql
INSTALL './extensions/${NAME}.duckdb_extension';
LOAD    './extensions/${NAME}.duckdb_extension';
```

* `prql`: Adds support for [prql](https://prql-lang.org/) via [ywelsch/duckdb-prql](https://github.com/ywelsch/duckdb-prql)
* `goe`: Adds support for geo functions via [handstuyennn/geo](https://github.com/handstuyennn/geo)

**Feel free to request othe community extensions by creating a [feature request issue](https://github.com/tobilg/duckdb-nodejs-layer/issues) in this repo!**

### ARNs

The **ARNs** of the latest version of the DuckDB Node.js Lambda layer with community extensions are:
| Region          | Layer ARN |
|-----------------|-----------|
| af-south-1 | arn:aws:lambda:af-south-1:041475135427:layer:duckdb-nodejs-extensions-x86:1 |
| ap-east-1 | arn:aws:lambda:ap-east-1:041475135427:layer:duckdb-nodejs-extensions-x86:1 |
| ap-northeast-1 | arn:aws:lambda:ap-northeast-1:041475135427:layer:duckdb-nodejs-extensions-x86:1 |
| ap-northeast-2 | arn:aws:lambda:ap-northeast-2:041475135427:layer:duckdb-nodejs-extensions-x86:1 |
| ap-northeast-3 | arn:aws:lambda:ap-northeast-3:041475135427:layer:duckdb-nodejs-extensions-x86:1 |
| ap-south-1 | arn:aws:lambda:ap-south-1:041475135427:layer:duckdb-nodejs-extensions-x86:1 |
| ap-south-2 | arn:aws:lambda:ap-south-2:041475135427:layer:duckdb-nodejs-extensions-x86:1 |
| ap-southeast-1 | arn:aws:lambda:ap-southeast-1:041475135427:layer:duckdb-nodejs-extensions-x86:1 |
| ap-southeast-2 | arn:aws:lambda:ap-southeast-2:041475135427:layer:duckdb-nodejs-extensions-x86:1 |
| ap-southeast-3 | arn:aws:lambda:ap-southeast-3:041475135427:layer:duckdb-nodejs-extensions-x86:1 |
| ap-southeast-4 | arn:aws:lambda:ap-southeast-4:041475135427:layer:duckdb-nodejs-extensions-x86:1 |
| ca-central-1 | arn:aws:lambda:ca-central-1:041475135427:layer:duckdb-nodejs-extensions-x86:1 |
| eu-central-1 | arn:aws:lambda:eu-central-1:041475135427:layer:duckdb-nodejs-extensions-x86:1 |
| eu-central-2 | arn:aws:lambda:eu-central-2:041475135427:layer:duckdb-nodejs-extensions-x86:1 |
| eu-north-1 | arn:aws:lambda:eu-north-1:041475135427:layer:duckdb-nodejs-extensions-x86:1 |
| eu-south-1 | arn:aws:lambda:eu-south-1:041475135427:layer:duckdb-nodejs-extensions-x86:1 |
| eu-south-2 | arn:aws:lambda:eu-south-2:041475135427:layer:duckdb-nodejs-extensions-x86:1 |
| eu-west-1 | arn:aws:lambda:eu-west-1:041475135427:layer:duckdb-nodejs-extensions-x86:1 |
| eu-west-2 | arn:aws:lambda:eu-west-2:041475135427:layer:duckdb-nodejs-extensions-x86:1 |
| eu-west-3 | arn:aws:lambda:eu-west-3:041475135427:layer:duckdb-nodejs-extensions-x86:1 |
| me-central-1 | arn:aws:lambda:me-central-1:041475135427:layer:duckdb-nodejs-extensions-x86:1 |
| me-south-1 | arn:aws:lambda:me-south-1:041475135427:layer:duckdb-nodejs-extensions-x86:1 |
| sa-east-1 | arn:aws:lambda:sa-east-1:041475135427:layer:duckdb-nodejs-extensions-x86:1 |
| us-east-1 | arn:aws:lambda:us-east-1:041475135427:layer:duckdb-nodejs-extensions-x86:1 |
| us-east-2 | arn:aws:lambda:us-east-2:041475135427:layer:duckdb-nodejs-extensions-x86:1 |
| us-west-1 | arn:aws:lambda:us-west-1:041475135427:layer:duckdb-nodejs-extensions-x86:1 |
