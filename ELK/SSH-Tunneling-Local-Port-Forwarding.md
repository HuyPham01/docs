# syntax
```bash
ssh -4 -fNT -L <ip-server-local>:<port-local>:<ip-camera>:<port-rtsp> <user-box>@<ip-vpn-box>
```
Example:  
```bash
ssh -4 -fNT -L 192.168.100.178:5558:10.10.8.60:554 {user}@{ip remote}
```
