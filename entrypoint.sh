#!/bin/bash
set -e

CONFIG_PATH="/usr/local/etc/xray/config.json"
XRAY_BIN="/usr/local/bin/xray"

# 1. Скачиваем и устанавливаем XRay, если ещё не установлен
if [ ! -f "$XRAY_BIN" ]; then
    bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install
fi

# 2. Генерируем приватный ключ и UUID, если конфиг ещё не существует
if [ ! -f "$CONFIG_PATH" ] || [ ! -s "$CONFIG_PATH" ]; then
    echo "Генерируем ключи и UUID..."
    # Извлекаем приватный ключ
    PRIVATE_KEY=$(echo "$XRAY_KEYS" | awk -F': ' '/Private Key/{print $2}')

    # Извлекаем публичный ключ (Password)
    PASSWORD=$(echo "$XRAY_KEYS" | awk -F': ' '/Password/{print $2}')
    UUID=$($XRAY_BIN uuid)

    echo "Ваш публичный ключ: $PUBLIC_KEY"
    echo "Ваш UUID: $UUID"

    cat > "$CONFIG_PATH" <<EOF
{
  "log": { "loglevel": "warning" },
  "inbounds": [
    {
      "listen": "0.0.0.0",
      "port": 443,
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "$UUID",
            "flow": "xtls-rprx-vision"
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "tcp",
        "security": "reality",
        "realitySettings": {
          "show": false,
          "dest": "www.vk.com:443",
          "xver": 0,
          "serverNames": [
            "www.vk.com",
            "vk.com",
            "www.vk.ru",
            "vk.ru"
          ],
          "privateKey": "$PRIVATE_KEY",
          "minClientVer": "",
          "maxClientVer": "",
          "maxTimeDiff": 0,
          "shortIds": ["a1b2c3d4"]
        }
      },
      "sniffing": {
        "enabled": true,
        "destOverride": ["http","tls"]
      }
    }
  ],
  "outbounds": [
    { "protocol": "freedom", "tag": "direct" },
    { "protocol": "blackhole", "tag": "block" }
  ]
}
EOF
fi

# 3. Запуск XRay
exec $XRAY_BIN -config "$CONFIG_PATH"
