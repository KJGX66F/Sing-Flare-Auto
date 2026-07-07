FROM alpine:latest

# 设置版本变量，方便以后维护
# sing-box 版本: https://github.com/SagerNet/sing-box/releases
# cloudflared 版本: https://github.com/cloudflare/cloudflared/releases
ARG SING_BOX_VERSION=1.10.1
ARG CLOUDFLARED_VERSION=latest

# 安装必要的下载工具和基础库
RUN apk add --no-cache ca-certificates bash wget tar

WORKDIR /app

# 1. 下载并安装 sing-box (对应你的 web-app)
# 根据 Alpine 架构下载对应的 amd64 版本
RUN wget https://github.com/SagerNet/sing-box/releases/download/v${SING_BOX_VERSION}/sing-box-${SING_BOX_VERSION}-linux-amd64.tar.gz && \
    tar -zxvf sing-box-${SING_BOX_VERSION}-linux-amd64.tar.gz && \
    mv sing-box-${SING_BOX_VERSION}-linux-amd64/sing-box /usr/local/bin/sing-box && \
    rm -rf sing-box-${SING_BOX_VERSION}-linux-amd64*

# 2. 下载并安装 cloudflared (对应你的 sys-service)
RUN wget -O /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/${CLOUDFLARED_VERSION}/download/cloudflared-linux-amd64

# 3. 复制你仓库里现有的配置文件 (config.json, start.sh 等)
COPY . .

# 4. 赋予执行权限
RUN chmod +x /usr/local/bin/sing-box && \
    chmod +x /usr/local/bin/cloudflared && \
    chmod +x start.sh

# 声明端口
EXPOSE 8080

# 启动脚本
CMD ["./start.sh"]
