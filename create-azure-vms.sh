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
    --ssh-key-values "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDc3abkg72tuqhIG+1Dxj7ASX3rvIu6cT/Fh7i2m4dqiDaAj7QP7F8NjhTzpAPOPUM2TeD0UK+8k8W6R8xi2djCIUTXWg/hxuZVKYE2Im/z3G8zauc4R2RtCH6MJIZ15CfL88fqjaRSViaRDh+BKyVH6iARASrWTat80+hj4Tcc1dlBJ30C4gfD7Ol5iP6/FvFLiCSxb1SlGSYTO+Ps+YAuJNqmjZPk/+pKkZ+FXqjmula7LVLgcsPB1l2PPdxC+9pwV1JsDCLSBZICrxZEil7cEBZ43L9w0Yi+OcCaNOtHIqRQnEtaWsykZaGPutHGs854KRaTQLuNOEwh5ok4bCTv pejastojakovic@JONWSL3"

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
    --ssh-key-values "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDc3abkg72tuqhIG+1Dxj7ASX3rvIu6cT/Fh7i2m4dqiDaAj7QP7F8NjhTzpAPOPUM2TeD0UK+8k8W6R8xi2djCIUTXWg/hxuZVKYE2Im/z3G8zauc4R2RtCH6MJIZ15CfL88fqjaRSViaRDh+BKyVH6iARASrWTat80+hj4Tcc1dlBJ30C4gfD7Ol5iP6/FvFLiCSxb1SlGSYTO+Ps+YAuJNqmjZPk/+pKkZ+FXqjmula7LVLgcsPB1l2PPdxC+9pwV1JsDCLSBZICrxZEil7cEBZ43L9w0Yi+OcCaNOtHIqRQnEtaWsykZaGPutHGs854KRaTQLuNOEwh5ok4bCTv pejastojakovic@JONWSL3"
