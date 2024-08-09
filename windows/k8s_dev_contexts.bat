@echo off
echo "Adding Auzure Kubernetes Dev Contexts"
az account set --subscription c625d1e3-6dad-4246-912d-c8dc76869df4 
az aks get-credentials --name gravitate-k8s-dev-kube --resource-group gravitate-k8s-dev-rg --context gravitate-dev