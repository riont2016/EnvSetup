#!/bin/bash
mkdir -p /tmp/log/nginx/
mkdir -p /tmp/var/nginx/


sed -i "s/code/code\/thinkphp-demo/g"  /etc/nginx/nginx.conf

if [ ! -e '/code' ]; then
  ps aux | grep nginx | grep -v grep|awk -F ' ' '{print }' | xargs kill -9 >/dev/null 2>&1
  ps aux | grep php-fpm | grep -v grep|awk -F ' ' '{print }' | xargs kill -9 >/dev/null 2>&1
fi

echo "start php-fpm"
php-fpm -c /usr/local/etc/php/php.ini-production -y /usr/local/etc/php-fpm.conf
echo "start nginx"
nginx -c /etc/nginx/nginx.conf

# 查看日志
tail -f /tmp/var/nginx/access.log /tmp/var/nginx/error.log
