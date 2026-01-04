# minecraft
minecraft-on-codespace minecraft-on-cnb
Minecraft 1.21.11
## steps
Start Game Server
```
java -Xmx4096M -Xms4096M -jar server.jar nogui
```
Install ngrok

https://dashboard.ngrok.com/get-started/your-authtoken

```
./ngrok config add-authtoken $YOUR_AUTHTOKEN
```

```
./ngrok tcp 25565
```
Save & Stop Server
```
/save-all /stop
```
Change Level Type to FLAT
```
# server.properties
level-type=minecraft:normal → level-type=minecraft:flat
level-name=world → level-name=world_flat
gamemode=survival → gamemode=creative
# On Server Console
/op Pleasure1234
# On Game Console
/gamerule keep_inventory true
/gamerule doFireTick false
```
Give yourself Resistance Effect
```
/effect give Pleasure1234 minecraft:resistance 1000000 255 true
```
Sync changes to GitHub
```
git status
git add .
git commit -m "play 25/10/06"
git push origin main
```