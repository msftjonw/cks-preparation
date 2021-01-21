#reset with kubeadm
kubeadm reset

#remove kubeconfig
#switch to the normal user
rm -rf ~/.kube

#reset iptables
iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X

#dekete all files created in certain directory
find . -type f -name "*.yaml" -delete
