# 1.Cài đặt Google Cloud SDK và kubectl
```bash
brew install --cask google-cloud-sdk
brew install kubectl
```
Check
```bash
gcloud version
kubectl version --short --client
```
# 2.Configure Google Cloud SDK
Sau khi cài đặt xong, cần phải configure Cloud SDK bằng command gcloud init:
```bash
gcloud init
```
Sau khi configure Cloud SDK thành công, thử kiểm tra bằng command gcloud auth list
```bash
gcloud auth list
```
![image](https://github.com/HuyPham01/docs/assets/96679595/e57dcf37-fc1c-468c-a16b-56dad21a0bec)  
# 3. Get-credentials
install plugin
```bash
gcloud components install gke-gcloud-auth-plugin
echo 'export USE_GKE_GCLOUD_AUTH_PLUGIN=True' >> ~/.zshenv
```
gcloud container clusters get-credentials [cluster-name]
```bash
gcloud container clusters get-credentials huy-demo-k8s
```
# 4.Deploy NGINX Web Server Demo
Deploy NGINX vào GKE Cluster vừa tạo. Deployment Object bằng command:
```bash
kubectl create deployment nginx --image=nginx --replicas=3
```
Deployment này sẽ chạy 3 replicas của NGINX Container. Chạy command kubectl get pods để kiểm tra
 ```bash
 kubectl get pods
```
Tiếp theo, tạo một Service object để có thể truy cập Pod từ bên ngoài Cluster. Sử dụng Typle `LoadBalancer` Service. Để tạo LoadBalancer Service sẽ bằng dùng command:
```bash
kubectl expose deployment nginx --name=nginx --type=LoadBalancer --port=80 --target-port=80
```
Để xem thông tin về LoadBalancer trên, sẽ chạy command sau:
```bash
kubectl get svc nginx
```
Nếu bạn chạy command này sớm quá, sẽ thấy cột EXTERNAL-IP hiện là `<pending>`. Thì sẽ phải chờ một vài phút. Sau đó sẽ thấy một IP ở External IP
Okay, bạn sẽ mở browser và truy cập thử vào IP đó:  
![image](https://github.com/HuyPham01/docs/assets/96679595/73431fa0-31e0-4c6e-b3e7-1b58a6a02096)  
# 5. Dọn dẹp Resources
Xoá các resources sẽ xoá LoadBalancer Service, bằng command sau:
```bash
kubectl delete service nginx
```
Sau khi command chạy xong, mở lại giao diện Google Cloud Console --> Service và kiểm tra giao diện Load Balancing thì sẽ thấy Load Balancer đã được xóa.  
Tiếp theo, xóa GKE Cluster bằng command:  
```bash
gcloud container clusters delete huy-demo-k8s
```






