
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


