把 n9.usr.tax.conf 软连接到 /etc/nginx/site

Nginx 设置访问密码

```
apt-get install -y apache2-utils
htpasswd -c /etc/nginx/passwd n9
```
