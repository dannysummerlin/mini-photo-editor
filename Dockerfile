FROM node:21-alpine3.20 AS builder
WORKDIR /app
RUN apk add git
# will replace with variable
RUN git clone https://github.com/xdadda/mini-photo-editor .
RUN npm install
RUN npm run build

FROM busybox:1.30 AS runner
WORKDIR /app
COPY --from=builder /app/dist .
CMD ["busybox", "httpd", "-f", "-v", "-p", "8080"]
