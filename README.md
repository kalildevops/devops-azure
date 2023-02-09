# Azure DevOps samples

## Prerequisites
1. Azure account with subscription creation permission
2. A Resource Group to create Azure resources
3. Storage Account to store tfstate (Terraform metadata)

## Create Azure Credentials for the workflow

We use the follow action:
```
      - name: 'Az CLI login'
        uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}
````

But before, you need to create credentials. Run the commands:
```
az login
az account set --subscription "<subscription_id>"
az ad sp create-for-rbac --name "<name>" --role="Contributor" --scopes="/subscriptions/<subscription_id>" --sdk-auth
```

Copy the json result and paste as a new Github Actions Secret with name ```AZURE_CREDENTIALS```
Then you can run your workflow. In this repo, I use ```update-infra-terragrunt.yml```

## How to authenticate for local tests

To run Terraform/Terragrunt locally, follow these steps below to create ARM env vars:

```
az login
az account set --subscription "<subscription_id>"
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<subscription_id>" > $HOME/azure_creds.json
cat $HOME/azure_creds.json

export ARM_CLIENT_ID=$(jq '.appId' $HOME/azure_creds.json |sed 's/"//g')
export ARM_CLIENT_SECRET=$(jq '.password' $HOME/azure_creds.json |sed 's/"//g')
export ARM_SUBSCRIPTION_ID=<subscription_id>
export ARM_TENANT_ID=$(jq '.tenant' $HOME/azure_creds.json |sed 's/"//g')

env |grep ARM
```