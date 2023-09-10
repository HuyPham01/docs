***Resource:*** Được hiểu là một loại tài nguyên được kubernetes quản lý như namespace, pods, volume, service, serviceaccount, configMap, secret,…  

Resource có loại có sẵn (còn gọi là native), tức là cài đặt Kubernetes là nó có luôn rồi. Có loại resource tạo mới bằng kỹ thuật CRD (CustomResourceDefinition)  

Nếu phân chia các resource thành nhóm chức năng thì chúng ta có thể chia thành các nhóm sau:  

![image](https://github.com/HuyPham01/docs/assets/96679595/a047621a-fcd3-4f8b-bd10-f2162ad316fb)  

![image](https://github.com/HuyPham01/docs/assets/96679595/60a87f2b-764d-4c58-a1b7-302537935204)  
Hình trên chỉ là trích dẫn những resource tiêu biểu trong phạm vi namespace , còn muốn biết chính xác các resource đang có trong Kubernetes thì bạn có thể sử dụng lệnh:  
```bash
kubectl api-resources --namespaced=true
```
Pod là trung tâm kết nối của mọi resources khác. 
Pod là ứng dụng được chạy trong một vùng không gian riêng. Thực tế Kubernetes không làm việc trực tiếp với container, mà thay vào đó Kubernetes bọc (wrap) một hoặc vài container vào trong một cấu trúc gọi là Pod.  

