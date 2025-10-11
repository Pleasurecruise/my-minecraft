# minecraft
minecraft-on-codespace
Minecraft 1.21.3
## steps
启动游戏
```
java -Xmx4096M -Xms4096M -jar server.jar nogui
```
内网穿透

https://dashboard.ngrok.com/get-started/your-authtoken

```
./ngrok config add-authtoken $YOUR_AUTHTOKEN
```

```
./ngrok tcp 25565
```
保存进度
```
/save-all /stop
```
开启无敌
```
/effect give Pleasure1234 minecraft:resistance 1000000 255 true
```
开启死亡不掉落
```
/gamerule keepInventory true
```
提交同步至仓库
```
git status
git add .
git commit -m "play 25/10/06"
git push origin main
```