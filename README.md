# DDG-Chat-go

一个用于 DuckDuckGo Chat 服务的 OpenAI 兼容 API 代理。此项目允许您使用类似 OpenAI API 的格式访问 DuckDuckGo 的 AI 聊天服务。

## 特性

- 实现 OpenAI 兼容的 API 接口
- 支持 DuckDuckGo 的所有聊天模型
- 支持流式（stream）和非流式响应
- 自动处理 token 和认证
- 可配置的重试机制
- 支持 CORS，便于从任何前端使用
- 可选的 API 密钥保护

## 支持的模型

当前支持以下模型：

| API 模型名称 | DuckDuckGo 内部模型 |
|------------|-------------------|
| gpt-4o-mini | gpt-4o-mini |
| claude-3-haiku | claude-3-haiku-20240307 |
| llama-3.3-70b | meta-llama/Llama-3.3-70B-Instruct-Turbo |
| mistral-small | mistralai/Mistral-Small-24B-Instruct-2501 |
| o3-mini | o3-mini |

## 快速开始

### 前置要求

- Go 1.16 或更高版本
- 对 DuckDuckGo 服务的网络访问

### 安装

1. 克隆仓库：

```bash
git clone https://github.com/Shadownc/DDG-Chat-go.git
cd DDG-Chat-go
```

2. 安装依赖：

```bash
go mod download
```

3. 创建 `.env` 文件并配置（可选）：

```bash
# API 前缀，默认为 /
API_PREFIX=/

# 最大重试次数，默认为 3
MAX_RETRY_COUNT=3

# 重试延迟（毫秒），默认为 5000
RETRY_DELAY=5000

# 代理 URL（如需），默认为空
PROXY_URL=

# API KEY（如需保护 API），默认为空
APIKEY=your_api_key_here

# 端口，默认为 8787
PORT=8787
```

4. 运行服务：

```bash
go run main.go
```

或者构建并运行可执行文件：

```bash
go build -o ddg-chat-api
./ddg-chat-api
```

## Docker部署
```
docker run -d --name ddg-chat-go -p 8787:8787 \
  --env-file .env \
  lmyself/ddg-chat-go:latest

## 或者
docker run -d --name ddg-chat-go -p 8787:8787 \
  -e API_PREFIX="/" \
  -e MAX_RETRY_COUNT=3 \
  lmyself/ddg-chat-go:latest

```
## 部署完测试
```
curl -X POST 'https://example.com/v1/chat/completions' \
  --header 'Content-Type: application/json' \
  --data-raw $'{
    "messages": [
      {
        "role": "user",
        "content": "你好啊"
      }
    ],
    "model": "gpt-4o-mini",
    "stream": true
  }'
```
## 如果配置了APIKEY
```
curl -X POST 'http://localhost:8787/v1/chat/completions' \
  --header 'Content-Type: application/json' \
  --header 'Authorization: Bearer skxxxxxx' \
  --data-raw $'{
    "messages": [
      {
        "role": "user",
        "content": "你好啊"
      }
    ],
    "model": "gpt-4o-mini",
    "stream": true
  }'
```

## Serv00部署参考
[博客](https://blog.lmyself.top/article/6a1de94b-6aee-4556-87f8-0793ca98fe71)

## API 使用

### 端点

- `GET /` - 服务状态检查
- `GET /ping` - 健康检查
- `GET /v1/models` - 获取可用模型列表
- `POST /v1/chat/completions` - 发送聊天请求

### 认证

如果您配置了 `APIKEY` 环境变量，所有 API 请求需要在 header 中携带认证信息：

```
Authorization: Bearer your_api_key_here
```

### 聊天完成示例

**使用 curl:**

```bash
curl http://localhost:8787/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer your_api_key_here" \
  -d '{
    "model": "gpt-4o-mini",
    "messages": [
      {
        "role": "user",
        "content": "Hello, what can you do?"
      }
    ]
  }'
```

**流式响应:**

```bash
curl http://localhost:8787/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer your_api_key_here" \
  -d '{
    "model": "gpt-4o-mini",
    "messages": [
      {
        "role": "user",
        "content": "Hello, what can you do?"
      }
    ],
    "stream": true
  }'
```

### Node.js/TypeScript 示例

```typescript
import { Configuration, OpenAIApi } from 'openai';

const configuration = new Configuration({
  apiKey: 'your_api_key_here',
  basePath: 'http://localhost:8787/v1',
});

const openai = new OpenAIApi(configuration);

async function main() {
  const response = await openai.createChatCompletion({
    model: 'gpt-4o-mini',
    messages: [
      { role: 'user', content: 'Hello, what can you do?' }
    ],
  });
  
  console.log(response.data.choices[0].message.content);
}

main();
```

### Python 示例

```python
import openai

openai.api_key = "your_api_key_here"
openai.api_base = "http://localhost:8787/v1"

response = openai.ChatCompletion.create(
    model="gpt-4o-mini",
    messages=[
        {"role": "user", "content": "Hello, what can you do?"}
    ]
)

print(response.choices[0].message.content)
```

## 配置说明

### 环境变量

| 变量名 | 描述 | 默认值 |
|-------|------|-------|
| API_PREFIX | API 的前缀路径 | / |
| MAX_RETRY_COUNT | 请求失败时的最大重试次数 | 3 |
| RETRY_DELAY | 重试间隔时间（毫秒） | 5000 |
| PROXY_URL | HTTP 代理 URL（如需） | 空 |
| APIKEY | 用于保护 API 的密钥 | 空 |
| PORT | 服务监听端口 | 8787 |

## 注意事项

- 此项目仅供学习和研究使用
- 不要滥用 DuckDuckGo 的服务
- API 格式和功能可能会随 DuckDuckGo 的更新而变化

## 许可证

[MIT License](./LICENSE)

## 维护与贡献

欢迎提交 Pull Requests 或 Issues 来改进此项目。
