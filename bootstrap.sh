#!/bin/sh
export JAVA_HOME=/jre
export PATH=$PATH:/jre/bin

# 设置nginx
if [ -f "/nginx.conf" ]; then
    sed -i "s/%MAX_BODY_SIZE%/$MAX_BODY_SIZE/g" /nginx.conf
    sed -i "s@%CONTEXT_PATH%@$CONTEXT_PATH@g" /nginx.conf
    mv -f /nginx.conf /etc/nginx/nginx.conf
    rm -f /nginx.conf
fi

nohup nginx &
$JAVA_HOME/bin/java $JVM_ARGS -jar /java/$JAVA_FILE $JAVA_ARGS -server.port=8080