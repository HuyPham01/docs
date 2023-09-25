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
