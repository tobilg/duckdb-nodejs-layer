#!/bin/bash -e

# Default region for testing etc.
REGIONS=(us-east-1)

# Default compatible architecture
COMPATIBLE_ARCHITECTURES="x86_64"

# Compatible runtimes
COMPATIBLE_RUNTIMES="nodejs14.x nodejs16.x nodejs18.x"

# Get parameters
LAYER_NAME="duckdb-extensions-nodejs-x86"
ARCHITECTURE="$1"

# Set description
DESCRIPTION="Run DuckDB Node.js in AWS Lambda with extensions (https://github.com/tobilg/duckdb-nodejs-layer) for ${ARCHITECTURE}"

ls -la $GITHUB_WORKSPACE/

for region in ${REGIONS[@]}; do
  # Exclude gov and cn regions
  if [[ ${region} != *"gov"* && ${region} != *"cn"* ]];then
    echo "Publishing $ARCHITECTURE layer to $region..."

    LAYER_ARN=$(aws lambda publish-layer-version --region $region --layer-name $LAYER_NAME --description "$DESCRIPTION" --compatible-runtimes $COMPATIBLE_RUNTIMES --compatible-architectures $COMPATIBLE_ARCHITECTURES --license MIT --zip-file fileb://duckdb-extensions-layer-$ARCHITECTURE.zip | jq -r .LayerVersionArn)
    POLICY=$(aws lambda add-layer-version-permission --region $region --layer-name $LAYER_NAME --version-number $(echo -n $LAYER_ARN | tail -c 1) --statement-id $LAYER_NAME-public --action lambda:GetLayerVersion --principal \*)
    
    echo $LAYER_ARN
    echo "...complete!"
  fi
done
