# Step 1 Check kubernetes version
```bash
kubectl version
```
output
```
Client Version: v1.28.4
Kustomize Version: v5.0.4-0.20230601165947-6ce0bf390ce3
Server Version: v1.26.9
WARNING: version difference between client (1.28) and server (1.26) exceeds the supported minor version skew of +/-1
```
`version kubernetes` là 1.26.9
# Step 2 Install rancher docker
Với kubernetes v1.26.9 sẽ sử dụng [rancher:v2.8.0-rc3](https://github.com/rancher/rancher/releases/tag/v2.8.0-rc3)  
Run rancher đơn giản:  
```bash
docker run -d --restart=unless-stopped \
	-p 80:80 -p 443:443 rancher/rancher:latest
```
Run rancher với  certificate let’s encrypt:  
```bash
docker run --name rancher-server -d --restart=unless-stopped \
        -p 80:80 -p 443:443 --name=rancher-2.8.0 \
        -v /opt/rancher:/var/lib/rancher \
        --privileged rancher/rancher:v2.8.0-rc3 --acme-domain rancher.huydp.xyz
```
`--acme-domain`: domain phân giản ip rancher.  
# Step 3 Bootstrap Password Default Rancher
```bash
docker logs  container-id  2>&1 | grep "Bootstrap Password:"
```
![image](https://github.com/HuyPham01/docs/assets/96679595/1cd07267-211f-44b1-affe-5dfe387b6ea6)  
Tạo password cho rancher user default `admin`  
![image](https://github.com/HuyPham01/docs/assets/96679595/2f45cdab-071a-451c-a558-14d88ad4f2be)  

# Step 4 Add cluster 
Chọn `Manage`  
![image](https://github.com/HuyPham01/docs/assets/96679595/61b2278c-e1fb-4914-9c8a-d167008932ad)  
Chọn `Import...`  
![image](https://github.com/HuyPham01/docs/assets/96679595/c687a937-c628-4a37-913e-ba9c037a45a1)  
Tùy thuộc vào Cluster triển khai từ dịch vụ nào thì chọn mục tương ứng, ví dụ Amazon EC2, Azure, GKE ..., với Cluster đã triển khai trên, sẽ chọn `Generic`  
![image](https://github.com/HuyPham01/docs/assets/96679595/1b05db90-66ee-48f5-a21d-191897e2e12a)  
Đặt tên cho cụm  
![image](https://github.com/HuyPham01/docs/assets/96679595/e569482e-f398-4a0a-9a95-fae21aa4378f)  
Chạy `kubectl apply` trên `master node` để cài agent lên cụm k8s  
![image](https://github.com/HuyPham01/docs/assets/96679595/b250c996-970a-420d-b13d-c867f41644d9)  
Nếu https không certificate thì sử dụng dòng cli thứ 2 vì có `--insecure` bỏ qua certificate  
Quá trình sẽ mất 2-5 phút.
# Kết quả
![image](https://github.com/HuyPham01/docs/assets/96679595/43c932b6-cc48-4342-b147-bb45baea0818)  
