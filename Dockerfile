FROM node:14-alpine AS builder

WORKDIR /app

# install and cache app dependencies
COPY package.json .
RUN yarn

COPY . .
RUN yarn run build

FROM nginx:alpine

COPY --from=builder /app/build /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]