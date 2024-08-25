## Alert via telegram when user logon via SSH

Work on all popular linux system (Debian, Ubuntu, Arch Linux etc..)

### Requirement
- curl
- git (much easy to install)

### Install
1) Clone or download to /opt/ folder
```cd /opt/ && git clone ...```

2) Edit two configuration variables by editing credentials.config:
```vim credentials.config```

3) Add this script when user connect with the deploy script:
```bash deploy.sh```

4) Confirm that the script is working by logging you to ssh again.
