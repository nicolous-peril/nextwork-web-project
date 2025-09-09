#!/usr/bin/env bash
set -euo pipefail

# Remove previous deployment so Install doesn't fail with "file already exists"
WAR=/usr/share/tomcat/webapps/nextwork-web-project.war
EXPLODED=/usr/share/tomcat/webapps/nextwork-web-project
rm -f "$WAR" || true
rm -rf "$EXPLODED" || true
#!/bin/bash
sudo yum install tomcat -y
sudo yum -y install httpd
sudo cat << EOF > /etc/httpd/conf.d/tomcat_manager.conf
<VirtualHost *:80>
  ServerAdmin root@localhost
  ServerName app.nextwork.com
  DefaultType text/html
  ProxyRequests off
  ProxyPreserveHost On
  ProxyPass / http://localhost:8080/nextwork-web-project/
  ProxyPassReverse / http://localhost:8080/nextwork-web-project/
</VirtualHost>
EOF

