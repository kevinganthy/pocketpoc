FROM node:lts-alpine AS deps-front
WORKDIR /app
COPY front .
RUN npm i

FROM deps-front AS build-front
ARG VITE_APP_NAME="Pocketpoc"
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
WORKDIR /app
COPY --from=back /pb/pocketbase .
COPY --from=build-front /app/dist ./pb_public
COPY init.sql ./init.sql
EXPOSE ${POCKET_PORT}
CMD ./pocketbase serve --http=${POCKET_URL}:${POCKET_PORT}