FROM alpine:latest

WORKDIR /app

# 安装必要的包
RUN apk add --no-cache bash curl unzip

# 下载并安装Xray
RUN curl -L -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip /tmp/xray.zip -d /usr/local/bin && \
    chmod +x /usr/local/bin/xray && \
    rm /tmp/xray.zip

# 复制配置文件
COPY config.json /app/config.json
COPY entrypoint.sh /app/entrypoint.sh

RUN chmod +x /app/entrypoint.sh

EXPOSE ${PORT}

CMD ["/app/entrypoint.sh"]
