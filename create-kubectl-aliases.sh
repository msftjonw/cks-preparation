echo "alias k='kubectl'" >> ~/.bashrc
echo "alias ka='kubectl apply -f'" >> ~/.bashrc
echo "alias kg='kubectl get'" >> ~/.bashrc
echo "alias kgn='kubectl get nodes'" >> ~/.bashrc
echo "alias kgnw='kubectl get nodes -o wide'" >> ~/.bashrc
echo "alias kgnl='kubectl get nodes --show-labels'" >> ~/.bashrc
echo "alias kgp='kubectl get pods'" >> ~/.bashrc
echo "alias kgpw='kubectl get pods -o wide'" >> ~/.bashrc
echo "alias kgpl='kubectl get pods --show-labels'" >> ~/.bashrc
echo "alias kgs='kubectl get svc'" >> ~/.bashrc
echo "alias kgsl='kubectl get svc --show-labels'" >> ~/.bashrc
echo "alias kgd='kubectl get deployments'" >> ~/.bashrc
echo "alias kgdl='kubectl get deployments --show-labels'" >> ~/.bashrc
echo "alias kcf='kubectl create -f'" >> ~/.bashrc
echo "alias kd='kubectl delete'" >> ~/.bashrc
echo "alias kdf='kubectl delete -f'" >> ~/.bashrc
echo "alias kaf='kubectl apply -f'" >> ~/.bashrc
echo "alias kgpa='kubectl get pods --all-namespaces'" >> ~/.bashrc
echo "alias ksys='kubectl -n kube-system'" >> ~/.bashrc
echo "alias kl='kubectl logs'" >> ~/.bashrc
echo "alias kpf='kubectl port-forward'" >> ~/.bashrc
