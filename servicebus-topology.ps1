# Install asb-transport tool
dotnet tool install -g NServiceBus.Transport.AzureServiceBus.CommandLine

# Select az account
az account set --subscription "Cito-BV"

# Create an Azure Service Bus
az servicebus namespace create --name dibrantestsb
                               --resource-group nservicebusfunctions
# Get the connection string
$manageConnectionString = az servicebus namespace authorization-rule keys list --name RootManageSharedAccessKey 
                                                                               --query primaryConnectionString 
                                                                               --resource-group nservicebusfunctions 
                                                                               --namespace dibrantestsb 
                                                                               -o tsv

# Create NServiceBus Endpoint
asb-transport endpoint create test-endpoint -c $manageConnectionString

# Subscribe to an endpoint
asb-transport endpoint subscribe dibrantestsb Cito.LasSync.Models.Messages.BrinReqMsg -c $manageConnectionString