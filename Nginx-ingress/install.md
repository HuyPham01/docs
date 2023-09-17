![image](https://github.com/HuyPham01/docs/assets/96679595/d001eb30-ef8c-42f6-9c82-8683ea5cd486)  
NGINX Kubernetes Ingress Controller là một ingress hỗ trợ khả năng căn bằng tải, SSL, URI rewrite ...  
Ingress Controller được cung cấp bởi [Nginx](https://docs.nginx.com/nginx-ingress-controller/installation/installation-with-manifests/#uninstall-nginx-ingress-controller) là một proxy nổi tiếng, mã nguồn của Nginx Ingress Controller trên github tại: [Link](https://github.com/nginxinc/kubernetes-ingress/tree/main) v3.2.1  
## Cài đặt NGINX Ingress Controller
Clone the NGINX Ingress Controller repository  
```bash
git clone https://github.com/nginxinc/kubernetes-ingress.git --branch v3.2.1
cd kubernetes-ingress/deployments
```
Sau đó triển khai bằng các lệnh sau:  
```bash
kubectl apply -f common/ns-and-sa.yaml
kubectl apply -f rbac/rbac.yaml
kubectl apply -f ../examples/shared-examples/default-server-secret/default-server-secret.yaml
kubectl apply -f common/nginx-config.yaml
kubectl apply -f common/ingress-class.yaml
kubectl apply -f common/crds/k8s.nginx.org_virtualservers.yaml
kubectl apply -f common/crds/k8s.nginx.org_virtualserverroutes.yaml
kubectl apply -f common/crds/k8s.nginx.org_transportservers.yaml
kubectl apply -f common/crds/k8s.nginx.org_policies.yaml
kubectl apply -f daemon-set/nginx-ingress.yaml
```
Kiểm tra daemonset và các pod của Nginx Ingress Controller  
```bash
kubectl get ds -n nginx-ingress
kubectl get po -n nginx-ingress
```
<img width="899" alt="Screen Shot 2023-09-17 at 22 24 09" src="https://github.com/HuyPham01/docs/assets/96679595/30361838-c7a2-47fe-a67d-9b68efabc55b">

