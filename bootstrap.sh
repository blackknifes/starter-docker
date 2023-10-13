#!/bin/sh
export JAVA_HOME=/jre
export PATH=$PATH:/jre/bin

# 设置nginx
echo "set nginx config"
sed -i "s/%MAX_BODY_SIZE%/$MAX_BODY_SIZE/g" /etc/nginx/nginx.conf
sed -i "s@%CONTEXT_PATH%@$CONTEXT_PATH@g" /etc/nginx/nginx.conf
sed -i "s@%PROXY_PATH%@$PROXY_PATH@g" /etc/nginx/nginx.conf
echo "set nginx config finished"

#设置时区
if [ -n TZ ]; then
    echo "set tzdata to $TZ"
    ln -sf /usr/share/zoneinfo/$TZ /etc/localtime
    echo "$TZ" > /etc/timezone
    echo "set tzdata to $TZ finished"
fi

nohup nginx &
$JAVA_HOME/bin/java $JVM_ARGS -jar /java/$JAVA_FILE $JAVA_ARGS -server.port=8080