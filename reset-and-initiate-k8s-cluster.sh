#reset with kubeadm
kubeadm reset -f

#remove kubeconfig
#switch to the normal user
rm -rf ~/.kube

#reset iptables
iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X

#delete all files created in certain directory with something.yaml
find /home/jonw -type f -name "*.yaml" -delete

#delete all files created in certain directory not with something.yaml
find /home/jonw -type f \! -name "*.yaml" -delete

#initiate a new kubeadm K8s cluster
kubeadm init

## Switch to general user (not root)
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Initiate Pod network
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

# Show the command to add worker node to the cluster
echo "### COMMAND TO ADD A WORKER NODE ###"
kubeadm token create --print-join-command --ttl 0
