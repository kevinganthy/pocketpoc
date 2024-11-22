FROM node:lts-alpine AS deps-front
WORKDIR /app
COPY front .
RUN npm i

FROM deps-front AS build-front
ARG VITE_APP_NAME="Pocketpoc"
ARG VITE_APP_DESCRIPTION="A simple POC for Pocketbase with SolidJS."
ARG VITE_API_URL="http://0.0.0.0:8090"
WORKDIR /app
COPY --from=deps-front /app .
RUN npm run build

FROM golang:alpine AS back
WORKDIR /pb
COPY pocketbase .
RUN go mod tidy
RUN CGO_ENABLED=0 go build

FROM alpine:latest
ENV POCKET_PORT=8090
ENV POCKET_URL=0.0.0.0
ENV HELLO_WORLD_RESPONSE="Hello, World!"
WORKDIR /app
COPY --from=back /pb/pocketbase .
COPY --from=build-front /app/dist ./pb_public
COPY init.sql ./init.sql
EXPOSE ${POCKET_PORT}
CMD ./pocketbase serve --http=${POCKET_URL}:${POCKET_PORT}