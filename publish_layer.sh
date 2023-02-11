#!/bin/bash -e

# AWS Regions
REGIONS="us-east-1"
# REGIONS=$(aws ssm get-parameters-by-path \
#     --path /aws/service/global-infrastructure/regions \
#     --query 'Parameters[].Value | sort(@)' 
#     --output text)

LAYER_NAME="duckdb-node-layer-test"
DESCRIPTION="Run DuckDB Node.js in AWS Lambda (https://github.com/tobilg/duckdb-lambda)"
COMPATIBLE_RUNTIMES="nodejs14.x nodejs16.x nodejs18.x"
COMPATIBLE_ARCHITECTURES="x86_64"

for region in ${REGIONS[@]}; do
  echo "Publishing layer to $region..."

  LAYER_ARN=$(aws lambda publish-layer-version --region $region --layer-name $LAYER_NAME --description "$DESCRIPTION" --compatible-architectures "$COMPATIBLE_ARCHITECTURES" --compatible-runtimes $COMPATIBLE_RUNTIMES --license MIT --zip-file fileb://release/duckdb-layer.zip | jq -r .LayerVersionArn)
  POLICY=$(aws lambda add-layer-version-permission --region $region --layer-name $LAYER_NAME --version-number $(echo -n $LAYER_ARN | tail -c 1) --statement-id $LAYER_NAME-public --action lambda:GetLayerVersion --principal \*)
  
  # echo $LAYER_ARN
  echo "$region complete"
done