# 使用 Playwright 官方 Docker 镜像（已预装 Chromium 和所有依赖）
FROM mcr.microsoft.com/playwright/python:v1.48.0-jammy

# 设置工作目录
WORKDIR /app

# 复制依赖文件
COPY requirements.txt .

# 安装 Python 依赖
RUN pip install --no-cache-dir -r requirements.txt

# 复制应用代码
COPY sign_server.py .

# 暴露端口（Render 会通过 PORT 环境变量传入）
EXPOSE 5005

# 启动应用
CMD ["python", "sign_server.py"]
