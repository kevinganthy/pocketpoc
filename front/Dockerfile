FROM node:20-alpine AS base

FROM base AS deps
WORKDIR /usr/src/app
COPY ./package*.json ./
RUN npm i

FROM base AS dev
WORKDIR /usr/src/app
COPY --from=deps /usr/src/app/node_modules /usr/src/app/node_modules
CMD npm run dev

FROM base
WORKDIR /usr/src/app
COPY --from=deps /usr/src/app/node_modules /usr/src/app/node_modules
ADD . .
RUN npm run build
CMD npm run start
