`vim policy.hcl`  
```
path "kv/message" {
   capabilities = ["read"]
}
```
Load file `policy.hcl`  vào trong Vault và tạo một policy tên là `message-readonly`:   
`vault policy write message-readonly policy.hcl`  
tạo token `read-only`  
`vault token create -policy="message-readonly"`  
