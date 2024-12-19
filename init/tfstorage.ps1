$RESOURCE_GROUP_NAME="tfstate"
$STORAGE_ACCOUNT_NAME="tfstateaslamdev01"
$CONTAINER_NAME="tfstate"

az group create --name $RESOURCE_GROUP_NAME --location "East US"

az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME