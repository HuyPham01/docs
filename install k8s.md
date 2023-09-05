# Step1 install docker
```bash
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
sudo apt install docker-ce -y
sudo systemctl status docker
```
# Step2 disabe firewall swap
- Kubernetes khuyến nghị swap
```bash
ufw disable
swapoff -a
sed -i '/swap/ s/^\(.*\)$/#\1/g' /etc/fstab
```
# Step3 add public keys
```bash
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
```
# Step4 Add kubernetes repo
```bash
sudo bash -c 'echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list'
```
# Step5
```bash
sudo apt-get update && sudo apt-get install -y kubelet kubeadm kubectl
```
# Step6 Enable, start and status kubelet
```bash
sudo systemctl enable kubelet
sudo systemctl start kubelet
sudo systemctl status kubelet
```
# Step7 khởi tạo Kubernetes Cluster
```bash
IPADDR=$(hostname -I |awk '{ print $1 }')

kubeadm init --apiserver-advertise-address $IPADDR --pod-network-cidr=10.224.0.0/16
```
# Step8 cấu hình để sử dụng được tập lệnh kubectl tương tác với API server
```bash
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
# Step9 apply CNI(container network interface)
plugin network là calico. Dải địa chỉ IP có `CIDR là 10.224.0.0/16` sẽ được sử dụng để cấp phát địa chỉ IP cho các Pod. Pod là một thành phần bao bọc các container khi chạy container trong Kubernetes.
```bash
curl https://docs.tigera.io/archive/v3.25/manifests/calico.yaml -O
```
`vim calico.yaml +4601` Loại bỏ comment của 02 dòng này và thay đúng CIDR từ lệnh khởi tạo vào
```
 - name: CALICO_IPV4POOL_CIDR
   value: "10.224.0.0/16"
```
`kubectl apply -f calico.yaml` triển khai calico
# Step 10 get token
Vì token sử dụng để join các Worker node có thời gian sử dụng là 24h, chạy lệnh sau sẽ có token khi chạy `kubeadm join`
```bash
kubeadm token create --print-join-command
```
Run token trên các worker node
# Check node 
```bash
kubectl get nodes -o wide
```
