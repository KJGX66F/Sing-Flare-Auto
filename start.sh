#!/bin/sh

# 替换配置文件中的 UUID
sed -i "s/PASTE_YOUR_UUID_HERE/$UUID/g" config.json

# 后台运行 sing-box
sing-box run -c config.json &

# 运行 Cloudflare Tunnel
cloudflared tunnel --no-autoupdate run --token $ARGO_TOKEN
