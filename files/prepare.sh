#!/bin/bash
# prepare.sh文件为云开发平台构建用户自定义镜像的前置操作，处理环境变量以及启动命令等操作

## 此处不要改动 ------
echo "#!/bin/bash" > start.sh
# 设置环境变量
index=0
for item in $*
do
  let index+=1
  if [ $index -ge 2 ]; then
    echo " ${item}"
    echo "export ${item}" >> start.sh
  fi
done
## ------ 此处不要改动

## 自定义启动命令 ------
cat >> start.sh <<EOF
mkdir -p /tmp/log/nginx/
mkdir -p /tmp/var/nginx/

if [ ! -e '/code' ]; then
  ps aux | grep nginx | grep -v grep|awk -F ' ' '{print $2}' | xargs kill -9 >/dev/null 2>&1
  ps aux | grep php-fpm | grep -v grep|awk -F ' ' '{print $2}' | xargs kill -9 >/dev/null 2>&1
fi


echo "start php-fpm"
php-fpm -c /usr/local/etc/php/php.ini-production -y /usr/local/etc/php-fpm.conf
echo "start nginx"
nginx -c /etc/nginx/nginx.conf

# 查看日志
tail -f /tmp/var/nginx/access.log /tmp/var/nginx/error.log
EOF
## ------自定义命令