#cloud-config
write_files:
 - path: /etc/logrotate.d/httpd
   content: |
/var/log/httpd/*log {
    daily
    missingok
    notifempty
    sharedscripts
    delaycompress
    postrotate
        /bin/systemctl reload httpd.service > /dev/null 2>/dev/null || true
    endscript
}

bootcmd:
  - mkfs -t ext4 -L /var/log /dev/sdv1
  - mkdir -p /var/log
mounts:
  - [ "/dev/sdv1", "/var/log", "ext4", "defaults,nofail", "0", "2" ]
runcmd:
  - adduser --disabled-password --gecos "" ${user_name}
  - usermod -aG sudo ${user_name}
packages:
  - httpd
  