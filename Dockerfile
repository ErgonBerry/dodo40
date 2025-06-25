FROM golang:1.21-alpine AS builder

WORKDIR /app
COPY . .

# Inicializa o módulo Go (se não existir) e baixa as dependências
RUN test -f go.mod || go mod init github.com/ErgonBerry/dodo40
RUN go mod tidy

# Compila o aplicativo
RUN go build -o festa-app .

FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/festa-app .
COPY ./templates /app/templates
COPY ./static /app/static

EXPOSE 3000
CMD ["./festa-app"]