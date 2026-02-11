# 小红书签名服务器

基于 Playwright 的小红书 API 签名服务。

## 🚀 部署到 Render.com

### 一键部署

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com)

1. 点击上方按钮
2. 连接 GitHub 仓库
3. Render 会自动检测 `render.yaml` 并部署
4. 等待 5-10 分钟完成部署

### 手动部署

1. 推送到 GitHub：
```bash
git add .
git commit -m "Deploy sign server"
git push
```

2. 在 Render Dashboard 创建 Web Service
3. 配置：
   - **Build Command**: `pip install -r requirements.txt && playwright install chromium && playwright install-deps`
   - **Start Command**: `python sign_server.py`
   - **Region**: Singapore
   - **Health Check**: `/health`

## 🧪 测试

### 健康检查

```bash
curl https://your-app.onrender.com/health
```

### 测试签名

```bash
curl -X POST https://your-app.onrender.com/sign \
  -H "Content-Type: application/json" \
  -d '{
    "uri": "/api/sns/web/v1/user/me",
    "data": null,
    "a1": "test",
    "web_session": "test"
  }'
```

## 📝 API 文档

### POST /sign

生成小红书 API 签名。

**请求体：**
```json
{
  "uri": "/api/sns/web/v2/note",
  "data": {...},
  "a1": "cookie_a1_value",
  "web_session": "cookie_web_session_value",
  "web_id": "cookie_webId_value"
}
```

**响应：**
```json
{
  "x-s": "签名值",
  "x-t": "时间戳"
}
```

### GET /health

健康检查接口。

**响应：**
```json
{
  "status": "healthy",
  "browser_ready": true,
  "a1": "188b...",
  "timestamp": 1706774400
}
```

## 📦 文件说明

- `sign_server.py` - 签名服务器主文件
- `requirements.txt` - Python 依赖
- `render.yaml` - Render 配置
- `README.md` - 本文档

## ⚙️ 本地运行

```bash
# 安装依赖
pip install -r requirements.txt
playwright install chromium

# 启动服务器
python sign_server.py
```

## 🔧 配置

服务器会自动从以下环境变量读取：

- `PORT` - 端口号（Render 自动设置）
- `PYTHON_VERSION` - Python 版本

## ⚠️ 注意事项

1. **stealth.min.js 自动下载**：启动时会自动从 CDN 下载，无需手动上传
2. **Free Plan 限制**：15分钟无请求后休眠，唤醒需要 30-60 秒
3. **重试机制**：签名失败会自动重试 10 次
4. **首次部署**：需要 5-10 分钟安装 Playwright 浏览器

## 📞 问题反馈

遇到问题请查看 Render 日志或提交 Issue。
