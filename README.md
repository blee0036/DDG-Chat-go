# DDG-Chat-go

## Docker部署
```
docker run --name ddg-chat-go -p 8787:8787 \
  --env-file .env \
  lmyself/ddg-chat-go:latest

## 或者
docker run --name ddg-chat-go -p 8787:8787 \
  -e API_PREFIX="/" \
  -e MAX_RETRY_COUNT=3 \
  lmyself/ddg-chat-go:latest

```

## 参考项目
[DDG-Chat](https://github.com/leafmoes/DDG-Chat)
