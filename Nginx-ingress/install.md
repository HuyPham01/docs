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
## default-server-secret
Tạo secret đúng với domain, đối với `Secret` chỉ nhận dữ liệu kiểu base64
##  Tạo service vs Ingress
service.yaml
```bash
apiVersion: v1
kind: Service
metadata:
  name: http-test-svc
  namespace: nginx-ingress
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
  selector:
    run: http-test-app
  sessionAffinity: None
  type: ClusterIP
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    run: http-test-svc
  name: http-test-svc
  namespace: nginx-ingress
spec:
  replicas: 2
  selector:
    matchLabels:
      run: http-test-app
  template:
    metadata:
      labels:
        run: http-test-app
    spec:
      containers:
      - image: httpd
        imagePullPolicy: IfNotPresent
        name: http
        ports:
        - containerPort: 80
          protocol: TCP
        resources: {}
```
ingress-not-ssl.yaml
```bash
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: app
  namespace: nginx-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    kubernetes.io/ingress.class: nginx
spec:
  rules:
    # Tên miền truy cập
  - host: huypd.test
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          # dịch vụ phục vụ tương ứng với tên miền và path
          service:
            name: http-test-svc
            port:
              number: 80
```
Hãy truy cập và kiểm tra từ trình duyệt đến địa chỉ http://huypd.test  

Triển khai SSL truy cập bằng https, ở đây sử dụng chính các xác thực lưu trong Secret có tên default-server-secret, đi kèm Nginx Ingress Controller.  
ingress-ssl.yaml
```bash
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: app
  namespace: nginx-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    kubernetes.io/ingress.class: nginx
spec:
  tls:
    - hosts:
      - huypd.test
      secretName: default-server-secret
  rules:
    # Tên miền truy cập
  - host: huypd.test
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          # dịch vụ phục vụ tương ứng với tên miền và path
          service:
            name: http-test-svc
            port:
              number: 80
```
