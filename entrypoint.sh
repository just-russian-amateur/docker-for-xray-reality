#!/bin/bash
CONFIG="/usr/local/etc/xray/config.json"

if [ ! -f "$CONFIG" ]; then
    echo ">>> Generation UUID and keys..."
    UUID=$(xray uuid)
    /usr/local/bin/xray x25519 > /tmp/xray_keys.txt
    PRIVATE_KEY=$(awk -F': ' '/PrivateKey/{print $2}' /tmp/xray_keys.txt)
    PUBLIC_KEY=$(awk -F': ' '/Password/{print $2}' /tmp/xray_keys.txt)

    cat > "$CONFIG" <<EOF
{
  "log": { "loglevel": "warning" },
  "inbounds": [{
    "listen": "0.0.0.0",
    "port": 443,
    "protocol": "vless",
    "settings": {
      "clients": [{ "id": "$UUID", "flow": "xtls-rprx-vision" }],
      "decryption": "none"
    },
    "streamSettings": {
      "network": "tcp",
      "security": "reality",
      "realitySettings": {
        "dest": "www.vk.com:443",
        "serverNames": [
          "www.vk.com",
          "vk.com",
          "www.vk.ru",
          "vk.ru"
        ],
        "privateKey": "$PRIVATE_KEY",
        "shortIds": ["a1b2c3d4"]
      }
    }
  }],
  "outbounds": [
    { "protocol": "freedom", "tag": "direct" },
    { "protocol": "blackhole", "tag": "block" }
  ]
}
EOF

    echo ">>> Generated:"
    echo "UUID: $UUID"
    echo "Public Key: $PUBLIC_KEY"
    echo "Short ID: a1b2c3d4"
fi

exec /usr/local/bin/xray run -c "$CONFIG"
