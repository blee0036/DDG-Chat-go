# Use the official Golang image as the builder
FROM golang:1.21 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the go.mod and go.sum files to the working directory
COPY go.mod go.sum ./

# Download all dependencies (this will be cached if there are no changes to go.mod)
RUN go mod download

# Copy the source code to the working directory
COPY . .

# Build the Go application and name the binary 'ddg-chat-go'
RUN go build -o ddg-chat-go .

# Use a smaller base image to reduce the final image size
FROM alpine:latest

# Set the working directory inside the container
WORKDIR /root/

# Copy the binary from the builder stage
COPY --from=builder /app/ddg-chat-go .

# Copy the .env file if you are using one
COPY .env .

# Expose the port that your app runs on
EXPOSE 8787

# Command to run the executable
CMD ["./ddg-chat-go"]