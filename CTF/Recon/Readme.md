# Wappalyzer Tools
link install
```
https://chromewebstore.google.com/detail/gppongmhjkpfnbhagpmjfkannfbllamg?utm_source=item-share-cb
```
# Nuclei
Vừa sử dụng để recon và scans

Directories scan
```
https://github.com/projectdiscovery/nuclei
```

# searchsploit
# ffuf
Directories scan.  
ex:
```
ffuf -w wordlists/fuzz-Bo0oM.txt -u https://xxx/FUZZ
```
# gobuster
Directories scan.  
ex:
```
gobuster dir  --url http://xxx -w wordlists/fuzz-Bo0oM.txt -t 70
```
# arjun
HTTP parameter discovery suite.
```
arjun -u http://xxx
```
# amass
scan domain
```
amass enum -d
```