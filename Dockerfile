FROM ubuntu:22.04

# Установка зависимостей
RUN apt-get update && \
    apt-get install -y curl unzip sudo jq && \
    rm -rf /var/lib/apt/lists/*

# Создание папки для XRay
RUN mkdir -p /usr/local/etc/xray

# Копируем скрипт entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Порт, который будет слушать XRay
EXPOSE 443

# Стартовый скрипт
ENTRYPOINT ["/entrypoint.sh"]
