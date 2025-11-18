#!/bin/bash

# Function to deploy using Azure CLI
validate_runner() {
    local template_file="$1"

    az deployment group validate --resource-group apim-rg --template-file "$template_file" 
}

# Main script starts here
template_file="./storage.bicep"

validate_runner "$template_file
