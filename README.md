# DDG-Chat-go

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

## 参考项目
[DDG-Chat](https://github.com/leafmoes/DDG-Chat)
