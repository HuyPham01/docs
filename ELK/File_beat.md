File beat logs namespace k8s  
```bash
    filebeat.autodiscover:
      providers:
        - type: kubernetes
          node: ${NODE_NAME}
          templates:
            - condition:
                equals:
                  kubernetes.namespace: default
              config:
                - type: container
                  paths:
                    - /var/log/containers/*-${data.kubernetes.container.id}.log
                  processors:
                  - add_fields:
                      target: 'fields'
                      fields:
                        log_type: nginx
                  - drop_fields:
                      fields: ["host", "container", "log", "stream", "kubernetes.node.labels.beta_kubernetes_io/arch", "kubernetes.node.labels.beta_kubernetes_io/os", "kubernetes.node.labels.kubernetes_io/arch", "kubernetes.node.labels.kubernetes_io/hostname", "kubernetes.node.labels.kubernetes_io/os", "kubernetes.namespace_labels","kubernetes.labels.pod-template-generation", "kubernetes.labels.controller-revision-hash", "orchestrator"]
```
Cấu hình này khởi chạy đầu vào logs cho tất cả các container được chạy trong namespace default  

Được thêm vào `fields.logs_type: nginx`  

Sử dụng `drop_fields`: để xóa bớt trường field  

Với config có thể chỉ đỉnh đúng `container` trong `namespace` cần thu thập logs  
Thay đổi:  
```bash
 - /var/log/containers/{namecontainer}-*-${data.kubernetes.container.id}.log
```
`{namecontainer}` == Thay đổi theo name container cần thu thập logs  
# Nhiều namespace
```bash
        - type: kubernetes
          node: ${NODE_NAME}
          templates:
            - condition:
                or:
                  - equals:
                      kubernetes.namespace: aaa
                  - equals:
                      kubernetes.namespace: kube-system
                  - equals:
                      kubernetes.namespace: teleport-agent
                  
              config:
                - type: container
                  paths:
                    - /var/log/containers/*-${data.kubernetes.container.id}.log
                  processors:
                  - add_fields:
                      target: 'fields'
                      fields:
                        log_type: kube
```
