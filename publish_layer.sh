#!/bin/bash -e

# AWS Regions
REGIONS=$(aws ssm get-parameters-by-path --region us-east-1 \
  --path /aws/service/global-infrastructure/regions \
  --query 'Parameters[].Value | sort(@)' --output text)
#REGIONS=(us-east-1)

LAYER_NAME="$1"
DESCRIPTION="Run DuckDB Node.js in AWS Lambda (https://github.com/tobilg/duckdb-nodejs-layer)"
COMPATIBLE_RUNTIMES="nodejs14.x nodejs16.x nodejs18.x"
COMPATIBLE_ARCHITECTURES="x86_64"

for region in ${REGIONS[@]}; do
  # Exclude gov and cn regions
  if [[ ${region} != *"gov"* && ${region} != *"cn"* ]];then
    echo "Publishing layer to $region..."

    LAYER_ARN=$(aws lambda publish-layer-version --region $region --layer-name $LAYER_NAME --description "$DESCRIPTION" --compatible-runtimes $COMPATIBLE_RUNTIMES --license MIT --zip-file fileb://duckdb-layer.zip | jq -r .LayerVersionArn)
    POLICY=$(aws lambda add-layer-version-permission --region $region --layer-name $LAYER_NAME --version-number $(echo -n $LAYER_ARN | tail -c 1) --statement-id $LAYER_NAME-public --action lambda:GetLayerVersion --principal \*)
    
    echo $LAYER_ARN
    echo "$region complete"
  fi
done
