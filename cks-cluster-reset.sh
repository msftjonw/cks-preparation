#reset with kubeadm
kubeadm reset

#reset iptables
iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X

#dekete all files created in certain directory
find . -type f -name "*.yaml" -delete
