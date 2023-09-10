Vậy namespace là gì? Kkhái niệm namespace xuất hiện ở khá nhiều nơi, nhưng có cùng chung một mục đích: Một vùng không gian riêng.  
Kubernetes có thể hiểu về mặt logic thì namespace như một folder. Nhưng folder này trong Kubernetes nó trải dài trên tất cả các node. Không thể tạo resource có trùng tên trong 1 namespace.     

Resource: Được hiểu là một loại tài nguyên được kubernetes quản lý như pods, volume, service, serviceaccount, configMap, secret,… Các resource. Bản thân namespace cũng được coi là một resource.  
![image](https://github.com/HuyPham01/docs/assets/96679595/90c20400-f33d-42d1-8ac0-2fd8cf73ae64)  
### Theo như hình trên, nhìn tổng quát từ bên ngoài Kubernetes vào thì sẽ thấy:

- Một Kubernetes Cluster sẽ bao gồm rất nhiều node (master, worker).
- Một namespace trong Kubernetes Cluster sẽ nằm trên tất cả các node.
- Mọi ứng dụng khi triển khai trong Kubernetes phải thuộc vào một namespace nào đó
Namespace là một thành phần logic mà tất cả mọi người đều phải hiểu và tương tác nếu làm việc với Kubernetes.  
Mặc định khi cài đặt xong một cụm Kubernetes ta sẽ có 03 namespace: kube-system, default, public.
## CLI
Tạo 1 namespace:
```bash
kubectl create namespace test
```
Kiểm tra các namespace đang có trong hạ tầng Kubernetes:
```bash
kubectl get ns
```
Khi muốn tương tác với các resource trong namespace thì các bạn thêm tham số `-n` [NAMESPACE] vào câu lệnh:
```bash
kubeclt -n kube-system get all
```
Để xem những resource nào thuộc Kubernetes nằm trong phạm vi của namespace thì ta dùng lệnh:
```bash
kubectl api-resources --namespaced=true
```
