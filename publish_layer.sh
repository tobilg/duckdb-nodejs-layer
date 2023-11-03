#!/bin/bash -e

# Default region for testing etc.
REGIONS=(us-east-1)

# Default compatible architecture
COMPATIBLE_ARCHITECTURES="x86_64"

# Compatible runtimes
COMPATIBLE_RUNTIMES="nodejs14.x nodejs16.x nodejs18.x"

# Get parameters
LAYER_NAME="duckdb-nodejs-test-x86"
ARCHITECTURE="$1"

# Set description
DESCRIPTION="Run DuckDB Node.js in AWS Lambda (https://github.com/tobilg/duckdb-nodejs-layer) for ${ARCHITECTURE}"

# # Set regions when x86_64
# if [[ $ARCHITECTURE == "x86_64" ]]; then
#   # List sourced from SSM
#   REGIONS=$(aws ssm get-parameters-by-path --region us-east-1 \
#     --path /aws/service/global-infrastructure/regions \
#     --query 'Parameters[].Value | sort(@)' --output text)
#   # Set layer name
#   LAYER_NAME="duckdb-nodejs-x86"
# fi

# # Set regions when arm64
# if [[ $ARCHITECTURE == "arm64" ]]; then
#   # List sourced from https://aws.amazon.com/lambda/pricing/
#   REGIONS=("us-east-1" "us-east-2" "us-west-1" "us-west-2" "af-south-1" "ap-east-1" "ap-southeast-3" "ap-south-1" "ap-northeast-3" "ap-northeast-2" "ap-southeast-1" "ap-southeast-2" "ap-northeast-1" "ca-central-1" "eu-central-1" "eu-west-1" "eu-west-2" "eu-south-1" "eu-west-3" "eu-north-1" "me-south-1" "sa-east-1")
#   # Set compatible architecture to arm64
#   COMPATIBLE_ARCHITECTURES="arm64"
#   # Set layer name
#   LAYER_NAME="duckdb-nodejs-arm64"
# fi

ls -la $GITHUB_WORKSPACE/

for region in ${REGIONS[@]}; do
  # Exclude gov and cn regions
  if [[ ${region} != *"gov"* && ${region} != *"cn"* ]];then
    echo "Publishing $ARCHITECTURE layer to $region..."

    LAYER_ARN=$(aws lambda publish-layer-version --region $region --layer-name $LAYER_NAME --description "$DESCRIPTION" --compatible-runtimes $COMPATIBLE_RUNTIMES --compatible-architectures $COMPATIBLE_ARCHITECTURES --license MIT --zip-file fileb://duckdb-layer-$ARCHITECTURE.zip | jq -r .LayerVersionArn)
    POLICY=$(aws lambda add-layer-version-permission --region $region --layer-name $LAYER_NAME --version-number $(echo -n $LAYER_ARN | tail -c 1) --statement-id $LAYER_NAME-public --action lambda:GetLayerVersion --principal \*)
    
    echo $LAYER_ARN
    echo "...complete!"
  fi
done
