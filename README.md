⚠️ 严正声明 (License & Copyright)
本项目采用 CC BY-NC 4.0 协议进行分发。
无论你是直接 Fork、修改源码还是重新分发，都必须保留原作者的署名，且严禁用于任何商业牟利行为。一经发现侵权，作者保留追究责任的权利。（支持YouTube等视频平台分享，但必须提供原项目地址）

# Railway 平台部署 视频教程  [点击查看](https://youtu.be/ODVbTw0wfak?si=8fWoJUCGqWFw-lxS)

# 🚀 科学上网节点极速部署指南 (Sing-box + Cloudflare Tunnel)

本项目提供了一个基于 Docker 容器的轻量级、高隐匿性科学上网节点部署方案。通过集成 `sing-box` 和 `cloudflared`，你可以轻松地在各类云平台（如 Koyeb、Render 等）或个人 VPS 上一键构建安全隧道。

## ✨ 核心特性

* **轻量高效**：基于 Alpine Linux 和 Docker 构建，占用资源极低。
* **高隐匿性**：利用 Cloudflare Tunnel 穿透内网，隐藏真实服务器 IP，有效防封锁。
* **协议先进**：采用目前最强大的核心 `sing-box`，默认配置 VLESS 协议。
* **自动化构建**：已配置 GitHub Actions，修改代码后自动打包 Docker 镜像到 Github Packages (`ghcr.io`)。
* **灵活配置**：通过环境变量注入 UUID 和 Token，无需修改代码即可动态部署。

## 📦 项目结构

* `Dockerfile`: 自动拉取并构建所需组件的 Docker 镜像配置。
* `config.json`: `sing-box` 的核心路由与协议配置文件。
* `start.sh`: 容器启动脚本，负责替换环境变量并同时运行双进程。

---

## 🛠️ 部署教程

本项目支持在任何兼容 Docker 的环境中部署。以下以常见云 PaaS 平台为例。

### 准备工作

1.  **Cloudflare Tunnel**:
    * 登录 [Cloudflare Zero Trust](https://dash.teams.cloudflare.com/) 面板。
    * 导航至 **Networks** -> **Tunnels**，创建一个新的 Tunnel。
    * 保存生成的 **Tunnel Token** (即 `ARGO_TOKEN`)。
    * 为该 Tunnel 配置一个 Public Hostname（例如 `proxy.yourdomain.com`），并将服务指向 `http://localhost:8080`。

2.  **生成 UUID**:
    * 使用在线工具或命令行（如 `uuidgen`）生成一个符合标准格式的 UUID（例如：`123e4567-e89b-12d3-a456-426614174000`）。

### 开始部署

在部署平台（如 Koyeb）创建新应用时，请确保设置以下**环境变量 (Environment Variables)**：

| 变量名 | 说明 | 示例 |
| :--- | :--- | :--- |
| `UUID` | 你的节点连接密码 | `你的随机UUID` |
| `ARGO_TOKEN` | Cloudflare Tunnel 的 Token | `eyJh...` |

uuid生成器 [点击生成](https://99688988.xyz/uuid-generator/)

*(注：部署端口默认为 `8080`，无需修改)*

### 客户端连接

部署成功后，在你的代理客户端（如 v2rayN, Clash 等）中添加如下节点信息：

* **地址 (Address)**: 你在 Cloudflare 设置的 Public Hostname (例如 `proxy.yourdomain.com`)
* **端口 (Port)**: `443`
* **用户 ID (UUID)**: 你设置的 `$UUID`
* **传输协议 (Network)**: `ws` (WebSocket)
* **伪装域名 (SNI)**: 你的 Public Hostname
* **底层安全 (TLS)**: 开启 (`tls`)

快捷分享链接 (URI 格式) 示例

如果你熟悉直接拼接链接，它大概长这个样子（把中括号里的内容替换成你的真实信息）：
vless://你的UUID@你的Tunnel域名（或者优选域名）:443?encryption=none&security=tls&sni=你的Tunnel域名&insecure=0&allowInsecure=0&type=ws&host=你的Tunnel域名&path=%2Fvless#Railway-Singbox

如果速度太慢在 地址 (Address) 可换成优选域名 [点击获取优选域名](https://kjgx668.blogspot.com/2023/08/cloudflare-ip-cloudflare-cf.html)

---

## 进阶玩法：解锁流媒体与降低风控

如果你遇到节点 IP 风控过高或无法访问 ChatGPT/Netflix 的情况，可以通过修改 `config.json` 加入 Cloudflare WARP 出站。

具体方法：使用 WGCF 提取 WARP 的 `PrivateKey` 和 `Address` (IPv4)，将其填入 `config.json` 的 `outbounds` -> `warp` 标签下，系统即可自动将流媒体流量分流至纯净的 WARP 节点。详细教程可参考 [相关配置指南](#)。

---
> **Disclaimer**: 本项目仅供学习和交流网络协议之用，请在遵守当地法律法规的前提下使用。
>
> ⚠️ 严正声明 (License & Copyright)
本项目采用 CC BY-NC 4.0 协议进行分发。
无论你是直接 Fork、修改源码还是重新分发，都必须保留原作者的署名，且严禁用于任何商业牟利行为。一经发现侵权，作者保留追究责任的权利。
