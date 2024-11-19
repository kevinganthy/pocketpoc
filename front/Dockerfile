FROM node:20-alpine AS base

FROM base AS deps
WORKDIR /app
COPY ./package*.json ./
RUN npm install

FROM base AS dev
WORKDIR /app
COPY --from=deps /app/node_modules /app/node_modules
COPY . .
CMD npm run dev

FROM base AS build
WORKDIR /app
COPY --from=deps /app/node_modules /app/node_modules
COPY . .
RUN npm run build

FROM base AS prod
WORKDIR /app
COPY --from=build /app /app
CMD npm run start