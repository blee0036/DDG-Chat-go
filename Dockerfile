FROM golang:1.23-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o ddg-chat-api .

FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/ddg-chat-api .
EXPOSE 8787

RUN chmod +x ddg-chat-api

CMD ["./ddg-chat-api"]
