#!/bin/bash

scriptname=$(basename "$0")
scriptbuildnum="1.0.0"
scriptbuilddate="2022-12-13"

# Display version
displayVer() {
  echo -e "${scriptname} v${scriptbuildnum} (${scriptbuilddate})"
}

# Display usage
usage() {
  echo -e "AWS Lambda Layer Publisher\n"
  echo -e "Usage: ${scriptname} [-l NODEJS_RUNTIME_VERSION] [-n NAME] [-b BUCKET_NAME] [-c] [-h] [-v]"
  echo -e "  -l NODEJS_RUNTIME_VERSION\t: Node runtime version to use: 12.x, 14.x, 16.x, 18.x (default 16.x)"
  echo -e "  -n NAME\t\t\t: Name of the layer"
  echo -e "  -b BUCKET_NAME\t\t: Name of the S3 bucket to use for uploading the layer contents"
  echo -e "  -c\t\t\t\t: Create S3 Bucket for layer upload"
  echo -e "  -h\t\t\t\t: Help"
  echo -e "  -v\t\t\t\t: Display ${scriptname} version"
}

# Handle configuration
while getopts ":l:n:b:chv" arg; do
  case "${arg}" in
    l)  NODEJS_RUNTIME_VERSION=${OPTARG};;
    n)  NAME=${OPTARG};;
    b)  BUCKET_NAME=${OPTARG};;
    c)  CREATE_S3_BUCKET=true;;
    h)  usage; exit;;
    v)  displayVer; exit;;
    \?) echo -e "Error - Invalid option: $OPTARG"; usage; exit;;
    :)  echo "Error - $OPTARG requires an argument"; usage; exit 1;;
  esac
done
shift $((OPTIND-1))

CREATE_S3_BUCKET="${CREATE_S3_BUCKET:-false}"
NODEJS_RUNTIME_VERSION="${NODEJS_RUNTIME_VERSION:-16.x}"
NAME="${NAME:-base}"
LAYER_FILE_NAME="${NAME}_node${NODEJS_RUNTIME_VERSION}.zip"
LAYER_NAME="${NAME}-lambda-layer"
AWS_REGION="${AWS_REGION:-us-east-1}"

if [[ -z "$NAME" ]]; then
    echo "Please specify a name via the -n flag"; usage; exit 1;
fi

if [[ -z "$BUCKET_NAME" && "$CREATE_S3_BUCKET" = false ]]; then
    echo "Either need to specify an existing S3 bucket name via the -b flag, or set the -c flag to create a S3 bucket"; usage; exit 1;
elif [[ -z "$BUCKET_NAME" && "$CREATE_S3_BUCKET" = true ]]; then
    AWS_ACCOUNT_ID="$(aws sts get-caller-identity | jq -r '.Account')"
    S3_BUCKET_NAME="layer-uploads-${AWS_ACCOUNT_ID}"
    echo "Creating S3 bucket ${S3_BUCKET_NAME}"
    CREATE_RESULT="$(aws s3api create-bucket --bucket $S3_BUCKET_NAME --region $AWS_REGION)"
    CREATE_RESULT_CODE="$?"
    if [[ "$CREATE_RESULT_CODE" == "0" ]]; then
        echo "Created S3 bucket"
    fi
elif [[ "$BUCKET_NAME" ]]; then
    echo "Using existing S3 bucket ${BUCKET_NAME}"
    S3_BUCKET_NAME="${BUCKET_NAME}"
    CHECK_RESULT="$(aws s3api head-bucket --bucket $S3_BUCKET_NAME)"
    CHECK_RESULT_CODE="$?"
    if [[ "$CHECK_RESULT_CODE" == "0" ]]; then
        echo "Found S3 bucket"
    fi
else 
    echo "No S3 bucket info given. Exiting"
    exit 1
fi

if [[ -f "${LAYER_FILE_NAME}" ]]; then
    echo "Layer file ${LAYER_FILE_NAME} found"
    echo "Uploading layer file to S3"
    aws s3 sync . s3://${S3_BUCKET_NAME}/layers/ --exclude "*" --include "${LAYER_FILE_NAME}"

    echo "Publishing layer"
    PUBLISH_RESULT="$(aws lambda publish-layer-version \
        --layer-name "${LAYER_NAME}" \
        --content "S3Bucket=${S3_BUCKET_NAME},S3Key=layers/${LAYER_FILE_NAME}" \
        --compatible-runtimes "nodejs${NODEJS_RUNTIME_VERSION}" \
        --license-info "MIT" \
        --region "${AWS_REGION}")"
    PUBLISH_RESULT_CODE="$?"
    if [[ "$PUBLISH_RESULT_CODE" == "0" ]]; then
        echo "Publishing successful"
        echo "Layer ARN: $(echo $PUBLISH_RESULT | jq -r '.LayerVersionArn')"
    fi
else
    echo "Layer file ${LAYER_FILE_NAME} not found"
    exit 1
fi
