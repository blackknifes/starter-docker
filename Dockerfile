FROM alpine

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

ADD nginx.conf /nginx.conf

# 安装nginx
RUN apk add nginx

# 定义端口
EXPOSE 80

# 时区设置(默认为上海)
ENV TZ=Asia/Shanghai
# 最大包尺寸
ENV MAX_BODY_SIZE=4m
# 请求上下文路径
ENV CONTEXT_PATH=/api/
# java启动文件
ENV JAVA_FILE=admin.jar
# java参数
ENV JAVA_ARGS=
# jvm参数
ENV JVM_ARGS=

# java与vue目录
VOLUME /java
VOLUME /vue

# 安装时区数据
RUN apk add tzdata

# 添加dragonwell jre 11环境
ADD dragonwell.tar.gz /
RUN mv /dragonwell-11.0.20.17+8-GA /jre

# 清理本地缓存
RUN apk cache clean --purge

# 添加启动脚本
ADD bootstrap.sh /bootstrap.sh

# 启动命令
CMD /bin/sh -c /bootstrap.sh