#reset with kubeadm
sudo su
kubeadm reset -f

#remove kubeconfig
#switch to the normal user
rm -rf /home/jonw/.kube
find /home/jonw -type f -name "*.yaml" -delete
find /home/jonw -type f \! -name "*.yaml" -delete

#reset iptables
iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X

#initiate a new kubeadm K8s cluster
kubeadm init

# switch to general user (not root)
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# switch to root
# Initiate Pod network
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

# show the command to add worker node to the cluster
echo "### COMMAND TO ADD A WORKER NODE ###"
kubeadm token create --print-join-command --ttl 0
