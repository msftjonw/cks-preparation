#!/bin/bash
#Create resource group
az group create --name RG-CKS --location westus2

#Create VNet and Subnet
az network vnet create \
    --resource-group RG-CKS \
    --name VNet-CKS \
    --address-prefix 192.168.0.0/16 \
    --subnet-name Subnet-CKS \
    --subnet-prefix 192.168.1.0/24

##===##

##Create CKS-Master

#Create public IP address
az network public-ip create \
    --resource-group RG-CKS \
    --name PIP-CKS-Master \
    --dns-name cks-master

#Create NSG and its rules
az network nsg create \
    --resource-group RG-CKS\
    --name NSG-CKS

az network nsg rule create \
    --resource-group RG-CKS\
    --nsg-name NSG-CKS \
    --name SSH \
    --protocol tcp \
    --priority 1000 \
    --destination-port-range 22 \
    --access allow
    
az network nsg rule create \
    --resource-group RG-CKS \
    --nsg-name NSG-CKS \
    --name K8sServicePorts \
    --priority 2000 \
    --protocol tcp \
    --destination-port-ranges 30000-40000 \
    --access allow

#Associate NSG to subnet
az network vnet subnet update -g RG-CKS -n Subnet-CKS --vnet-name VNet-CKS --network-security-group NSG-CKS

#Create NIC
az network nic create \
    --resource-group RG-CKS \
    --name NIC-CKS-Master \
    --vnet-name VNet-CKS \
    --subnet Subnet-CKS \
    --public-ip-address PIP-CKS-Master

#Create VM
az vm create \
    --resource-group RG-CKS \
    --name CKS-Master \
    --location westus2 \
    --nics NIC-CKS-Master \
    --image UbuntuLTS \
    --admin-username azureuser \
    --admin-password zaq1@WSXcde3
    
##===##

##Create CKS-Worker

#Create public IP address
az network public-ip create \
    --resource-group RG-CKS \
    --name PIP-CKS-Worker\
    --dns-name cks-worker

#Create NIC
az network nic create \
    --resource-group RG-CKS \
    --name NIC-CKS-Worker\
    --vnet-name VNet-CKS \
    --subnet Subnet-CKS \
    --public-ip-address PIP-CKS-Worker

#Create VM
az vm create \
    --resource-group RG-CKS \
    --name CKS-Worker\
    --location westus2 \
    --nics NIC-CKS-Worker\
    --image UbuntuLTS \
    --admin-username azureuser \
    --admin-password zaq1@WSXcde3
