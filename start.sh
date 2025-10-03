#!/bin/bash

# 启动 ngrok 进行内网穿透（后台运行）
echo "Starting ngrok tunnel..."
./ngrok tcp 25565 --log=stdout > ngrok.log 2>&1 &
NGROK_PID=$!

# 等待 ngrok 启动
sleep 3

# 获取并显示 ngrok 公网地址
NGROK_URL=$(curl -s http://localhost:4040/api/tunnels | grep -o '"public_url":"[^"]*' | grep -o 'tcp://[^"]*' | head -1)
if [ ! -z "$NGROK_URL" ]; then
    echo "=========================================="
    echo "Minecraft Server Public Address:"
    echo "$NGROK_URL"
    echo "=========================================="
    # 将地址保存到文件
    echo "$NGROK_URL" > /minecraft/server_address.txt
fi

# 设置退出时的清理函数
cleanup() {
    echo "Shutting down server..."
    # 向 Minecraft 服务器发送 stop 命令
    echo "stop" > /proc/$(pgrep -f server.jar)/fd/0 || true
    sleep 5

    # 运行保存脚本
    if [ -f /minecraft/save.sh ]; then
        /minecraft/save.sh
    fi

    # 停止 ngrok
    kill $NGROK_PID 2>/dev/null || true

    exit 0
}

# 捕获退出信号
trap cleanup SIGTERM SIGINT

# 启动 Minecraft 服务器
echo "Starting Minecraft server..."
java $JAVA_OPTS -jar server.jar nogui &
SERVER_PID=$!

# 等待服务器进程
wait $SERVER_PID