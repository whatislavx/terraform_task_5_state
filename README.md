# Configuring Remote State in Terraform

Transition from a local Terraform state file to a remote state backend in Azure Blob Storage. This setup is essential for collaborative infrastructure management, ensuring that the state is safely stored and accessible by the entire team.

## Prerequisites

To complete this task, you must have:
- Terraform installed (version 1.8.4 or later)
- Azure CLI installed and configured
- An Azure subscription


## Steps to Complete the Task

**1. Fork this Repository**

**2. Create a Service Principal in Azure**

- Log in to Azure CLI:
   ```bash
   az login
   ```
- Create a resource group for Terraform state storage:
   ```bash
   az group create --name tfstate --location eastus
   ```
- Create an Azure storage account:
   ```bash
   az storage account create --resource-group tfstate --name <unique-storage-account-name> --sku Standard_LRS --encryption-services blob
   ```
- Create a blob container:
   ```bash
   az storage container create --name tfstate --account-name <storage-account-name>
   ```
- Create a service principal and generate its credentials:
   ```bash
   az ad sp create-for-rbac --name "TerraformSP" --role contributor --scopes /subscriptions/<subscription-id> --sdk-auth
   ```

**3. Configure GitHub Secrets**

Add the following secrets to your GitHub repository:

   * `AZURE_CLIENT_ID`: The client ID of the managed identity 
      ```bash
      az identity show --name TerraformMSI --resource-group tfstate --query clientId -o tsv
      ```
   * `AZURE_SUBSCRIPTION_ID`: Your Azure subscription ID
      ```bash
      az account show --query id -o tsv
      ```
   * `AZURE_TENANT_ID`: Your Azure tenant ID
      ```bash
      az account show --query tenantId -o tsv
      ```

**4. Set Up Local Backend**

- Create an initial `main.tf` file with a basic setup for the local backend and Azure provider.
- Initialize Terraform to use the local backend.

**5. Transition to Remote State Backend**

- Modify your main.tf file to include the Azure backend configuration.
- Use `use_oidc = true` setting in both the backend and provider blocks for enabling OIDC authentication with Azure.

**6. Verify the Remote State Configuration**

- Run Terraform plan and apply commands to verify the setup.
- Check the Azure Blob Storage to ensure the `terraform.tfstate` file is stored there.

**7. Pull request's description should also contain a reference to a successful workflow run**

OK
