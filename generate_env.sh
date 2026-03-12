#!/bin/bash

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

ENV_FILE=${1:-.env}
LOG_FILE="script.log"

echo "----------------------Script started at $(date)------------" >> "$LOG_FILE"

# Check if jq is installed or not
if ! command -v jq &> /dev/null
then
    echo -e "${RED} Error: jq is not installed.${NC}" | tee -a "$LOG_FILE"
    exit 1
fi

echo -e "${YELLOW}Fetching secrets from mock API.....${NC}" | tee -a "$LOG_FILE"

# Call mock secret API
SECRET_RESPONSE=$(./mock_secret_api.sh)

# Check if response is empty
if [ -z "$SECRET_RESPONSE" ]; then
    echo -e "${RED} Error: Empty response from Secret Manager.${NC}" | tee -a "$LOG_FILE"
    exit 1
fi

# Validate json format
if ! echo "$SECRET_RESPONSE" | jq empty 2>/dev/null; then
    echo -e  "${RED} Error: Invalid JSON received.${NC}" | tee -a "$LOG_FILE"
    exit 1
fi

# Convert Json TO KEY=VALUE format
echo "$SECRET_RESPONSE" | jq -r 'to_entries | .[] | "\(.key)=\(.value)"' > "$ENV_FILE"

# Verify env file created or not
if [ -s "$ENV_FILE" ]; then
    echo -e "${GREEN}.env file generated successfully!! ${NC}" | tee -a "$LOG_FILE"
else
    echo -e "${RED} Error: Failed to generate .env file.${NC}" | tee -a "$LOG_FILE"
    exit 1
fi

echo -e "----------Script Finished at $(date)---------------" >> "$LOG_FILE"