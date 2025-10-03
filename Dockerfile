FROM eclipse-temurin:21-jre

WORKDIR /minecraft

# 复制服务器文件
COPY server.jar /minecraft/
COPY server.properties /minecraft/
COPY eula.txt /minecraft/
COPY banned-ips.json banned-players.json ops.json whitelist.json usercache.json /minecraft/

# 复制库文件和世界数据
COPY libraries /minecraft/libraries/
COPY world /minecraft/world/

# 复制 ngrok
COPY ngrok /minecraft/
RUN chmod +x /minecraft/ngrok

# 创建日志目录
RUN mkdir -p /minecraft/logs

# 安装 git（用于自动提交）
RUN apt-get update && \
    apt-get install -y git curl && \
    rm -rf /var/lib/apt/lists/*

# 复制启动脚本
COPY start.sh /minecraft/
COPY save.sh /minecraft/
RUN chmod +x /minecraft/start.sh /minecraft/save.sh

# 暴露 Minecraft 端口
EXPOSE 25565

# 设置环境变量
ENV JAVA_OPTS="-Xmx4096M -Xms4096M"

# 启动服务器
CMD ["/minecraft/start.sh"]