# 1. Base image setting.
FROM nginx:alpine

# 2. 이미지에 대한 정보 기록
LABEL maintainer="cody"
LABEL description="Custom Nginx Web Server for Mission"

# 3. Host의 src폴더 안에 있는 index.html을 nginx컨테이너 웹 경로로 복사
COPY src/index.html /usr/share/nginx/html/index.html