# Stage 1: Build the Go binary
FROM golang:1.22-alpine AS builder
WORKDIR /src
COPY main.go .
# Compile the binary, disable CGO for a statically linked, smaller binary
RUN CGO_ENABLED=0 GOOS=linux go build -o server main.go

# Stage 2: Create the tiny production image
FROM alpine:latest
WORKDIR /app
# Copy ONLY the compiled binary from the builder stage
COPY --from=builder /src/server .

# Expose the port our app uses
EXPOSE 5678

# Run the binary when the container starts
ENTRYPOINT ["./server"]
