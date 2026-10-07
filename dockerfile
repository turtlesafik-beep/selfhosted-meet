FROM golang:1.26-alpine AS builder

RUN addgroup -g 1000 appgroup && adduser -u 1000 -G appgroup -S appuser

WORKDIR /app

COPY go.mod go.sum* ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o /app/server .


FROM scratch

COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group

WORKDIR /app

COPY --from=builder /app/server /app/server
COPY --from=builder /app/static /app/static

ENV PORT=8080

USER appuser

EXPOSE 8080

ENTRYPOINT ["/app/server"]