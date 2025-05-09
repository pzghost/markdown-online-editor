# 第一阶段：构建环境
FROM node:16 AS builder

WORKDIR /app
COPY . ./
RUN yarn \
&& yarn global add pm2 \
&& yarn build

# 第二阶段：运行环境

FROM nginx:alpine

COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
