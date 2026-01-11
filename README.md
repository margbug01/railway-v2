# Railway Xray 部署指南

## 快速部署

### 1. 推送到 GitHub

```bash
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/YOUR_USERNAME/railway-v2.git
git push -u origin main
```

### 2. Railway 部署

1. 登录 [Railway](https://railway.app/)
2. 点击 **New Project** → **Deploy from GitHub repo**
3. 选择你的仓库
4. 等待构建完成

### 3. 配置环境变量（重要）

在 Railway 项目的 **Variables** 中添加：

| 变量名 | 值 | 说明 |
|--------|-----|------|
| `UUID` | `你的UUID` | 自行生成，推荐使用 [UUID Generator](https://www.uuidgenerator.net/) |
| `WS_PATH` | `/your-secret-path` | WebSocket路径，建议使用随机字符串 |

### 4. 生成公网域名

1. 进入项目 **Settings** → **Networking**
2. 点击 **Generate Domain** 获取 `xxx.up.railway.app` 域名

---

## V2RayN 客户端配置

### 方式一：手动配置

1. 打开 V2RayN → 服务器 → 添加 VLESS 服务器
2. 填写以下信息：

| 项目 | 值 |
|------|-----|
| 地址 (address) | `你的Railway域名.up.railway.app` |
| 端口 (port) | `443` |
| 用户ID (id) | `你设置的UUID` |
| 流控 (flow) | 留空 |
| 加密 (encryption) | `none` |
| 传输协议 (network) | `ws` |
| 伪装域名 (host) | `你的Railway域名.up.railway.app` |
| 路径 (path) | `你设置的WS_PATH` |
| 传输层安全 (tls) | `tls` |

### 方式二：导入链接

复制以下链接格式，替换相应值后导入V2RayN：

```
vless://你的UUID@你的域名.up.railway.app:443?encryption=none&security=tls&type=ws&host=你的域名.up.railway.app&path=/你的路径#Railway-Xray
```

---

## 查看日志

部署成功后，在 Railway 的 **Deployments** → **View Logs** 中可以看到：
- 生成的 UUID（如果未手动设置）
- 完整的 VLESS 链接

---

## 常见问题

### Q: 连接失败？
- 检查 UUID 是否正确
- 确认 WS_PATH 与客户端一致
- 确保 TLS 已启用

### Q: 速度慢？
- Railway 免费版有带宽限制
- 建议升级付费计划

### Q: 如何更换 UUID？
- 在 Railway Variables 中修改 UUID 值
- 重新部署即可

---

## 安全建议

1. **UUID**: 使用强随机生成的 UUID
2. **WS_PATH**: 使用随机字符串，如 `/a8f3b2c1d4e5`
3. 定期更换 UUID 和路径
