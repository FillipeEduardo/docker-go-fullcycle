FROM golang:1.21.1 AS builder
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY ./ ./
RUN CGO_ENABLED=0 GOOS=linux go build -o /server

FROM scratch AS release
WORKDIR /
COPY --from=builder /server /server
ENTRYPOINT ["/server"]
