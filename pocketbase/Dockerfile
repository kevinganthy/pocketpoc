FROM golang:alpine
ENV POCKET_URL=0.0.0.0
ENV POCKET_PORT=8090

WORKDIR /pb

# Add sqlite3 to execute dump on demand
RUN apk update && apk upgrade
RUN apk add --no-cache sqlite

RUN touch init.sql

EXPOSE ${POCKET_PORT}

CMD go mod tidy; go run main.go serve --http=${POCKET_URL}:${POCKET_PORT}
