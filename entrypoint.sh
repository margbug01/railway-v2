#!/bin/bash

# 生成UUID（如果未设置环境变量）
if [ -z "$UUID" ]; then
    UUID=$(cat /proc/sys/kernel/random/uuid)
    echo "Generated UUID: $UUID"
fi

# 设置默认路径
if [ -z "$WS_PATH" ]; then
    WS_PATH="/ws"
fi

# 替换配置文件中的占位符
sed -i "s/PORT_PLACEHOLDER/$PORT/g" /app/config.json
sed -i "s/UUID_PLACEHOLDER/$UUID/g" /app/config.json
sed -i "s|/PATH_PLACEHOLDER|$WS_PATH|g" /app/config.json

echo "========================================"
echo "Xray VLESS 配置信息"
echo "========================================"
echo "UUID: $UUID"
echo "端口: $PORT"
echo "WebSocket路径: $WS_PATH"
echo "========================================"
echo "V2RayN配置 (VLESS链接):"
echo "vless://$UUID@\$RAILWAY_PUBLIC_DOMAIN:443?encryption=none&security=tls&type=ws&path=$WS_PATH#Railway-Xray"
echo "========================================"

# 启动伪装网站 (后台运行)
cd /app/www && python3 -m http.server 8080 &
echo "伪装网站已启动在端口 8080"

# 启动Xray
exec /usr/local/bin/xray run -c /app/config.json
