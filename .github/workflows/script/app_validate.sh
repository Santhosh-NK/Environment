#!/bin/bash


# Function to deploy using Azure CLI
validate_runner() {
    local uuid="$(cat /proc/sys/kernel/random/uuid)"
    local app_name="Deployments/$1/$1.json"



            az deployment group validate --name $uuid --resource-group apim-rg --template-file $template_file 
            az deployment group what-if --name $uuid --resource-group apim-rg --template-file $template_file 
    
            

}

# Main script starts here
template_file="./app_service.bicep"
apps = ("app1", "app2")
for app in "{$apps[@]}"; do 
    validate_runner "$app" 
done

