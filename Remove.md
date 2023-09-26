## Xả nút bạn muốn xóa:  
```bash
kubectl drain <node_name> --ignore-daemonsets
```
Lệnh kubectl drain được sử dụng để đảm bảo rằng một node Kubernetes không còn hoạt động nữa, thường được sử dụng khi muốn loại bỏ node khỏi cụm (cluster) hoặc khi cần thực hiện bảo trì hoặc cập nhật cho node đó.  

Tuy nhiên, trước khi bạn sử dụng kubectl drain, có một số điều cần lưu ý:  

- `--ignore-daemonsets:` Khi sử dụng tùy chọn này, Kubernetes sẽ bỏ qua các DaemonSet. DaemonSet đảm bảo rằng mỗi node trong cụm (cluster) luôn chạy một bản sao của một Pod cụ thể. Thông qua `--ignore-daemonsets`, có thể yêu cầu Kubernetes tạm thời bỏ qua DaemonSet khi drain node, cho phép dừng node mà không cần lo lắng về DaemonSet.
`kubectl uncordon <node_name>` để khôi phục node và cho phép các Pod khởi động lại trên node đó.

## Xóa nút khỏi cụm:
```bash
kubectl delete node <node_name>
```

## Trên nút loại bỏ nút:
```bash
sudo kubeadm reset
```
Lệnh này sẽ thực hiện các bước để đặt lại cài đặt của node. Điều này bao gồm việc xóa các tệp cấu hình và các thành phần của Kubernetes khỏi node.  
Nếu muốn xóa cả dữ liệu của ứng dụng (ví dụ: dữ liệu của các PersistentVolumes), có thể sử dụng tùy chọn `--force:`  

```bash
sudo kubeadm reset --force
```
Sau khi lệnh đã thực hiện xong, node sẽ ở trạng thái trống rỗng và sẵn sàng để được sử dụng lại hoặc loại bỏ khỏi cụm (cluster).  
Lưu ý rằng việc sử dụng `kubeadm reset` là một tác vụ quan trọng và nó sẽ đặt lại node mà không thể phục hồi. 
