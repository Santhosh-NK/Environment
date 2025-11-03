#!/bin/bash

# Function to deploy using Azure CLI
validate_runner() {
    local uuid="$(cat /proc/sys/kernel/random/uuid)"
    local parameters_file="Deployments/$1/$1.json"
    local template_file="$2"

    az deployment group validate --name "$uuid" --resource-group apim-rg --template-file "$template_file" --parameters "$parameters_file"
}

# Main script starts here
template_file="./app_service.bicep"
apps=("app1" "app2")

for app in "${apps[@]}"; do 
    validate_runner "$app" "$template_file"
done
