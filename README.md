# 🚀 개발 워크스테이션 구축 결과 보고서

## 1. 프로젝트 개요
본 미션은 터미널, Docker, Git/GitHub을 활용하여 '내 컴퓨터에서만 돌아가는' 환경 문제를 방지하고, 팀원 누구나 동일한 방식으로 실행, 배포, 디버깅할 수 있는 **재현 가능한 개발 워크스테이션 구축**을 목표로 합니다. 리눅스 CLI 조작, 컨테이너 격리 원칙, 포트 매핑 및 데이터 영속성(Volume)의 핵심 흐름을 직접 검증하고 기록하였습니다.

## 2. 실행 환경
- **OS**: macOS (Apple Silicon)
- **Shell**: zsh
- **Terminal**: VSCode Terminal / iTerm2
- **Docker**: 28.5.2 (OrbStack 환경)
- **Git**: 2.53.0

## 3. 수행 항목 체크리스트
- [x] 터미널 조작 로그 기록
- [x] 파일 및 디렉토리 권한 변경 실습 (644/755/777)
- [x] Docker 설치 및 기본 환경 점검 (`docker info`)
- [x] Docker 기본 운영 명령 수행
- [ ] Docker 컨테이너 실행 실습 (hello-world / ubuntu)
- [ ] Dockerfile 기반 커스텀 웹 서버 이미지 제작
- [ ] 포트 매핑 및 브라우저 접속 확인
- [ ] Docker 볼륨을 이용한 데이터 영속성 검증
- [x] Git 사용자 설정 및 GitHub 원격 저장소 연동

---

## 4. 수행 로그 및 검증

### 4.1 터미널 조작 로그 기록
명령어 실행 후 `ls` 및 `pwd`를 통해 상태 변화를 검증하였습니다.

```bash
# 1. 현재 위치 확인 및 실습 디렉토리 생성
$ pwd
/Users/och54055405

$ mkdir -p ~/study/workStation/practice
$ ls -al ~/study  # 디렉토리 생성 확인
total 0
drwxr-xr-x   3 och54055405  och54055405   96 Apr  1 20:20 .
drwxr-x---+ 21 och54055405  och54055405  672 Apr  1 20:20 ..
drwxr-xr-x   3 och54055405  och54055405   96 Apr  1 20:20 workStation

# 2. 이동
$ cd ./study/workStation
$ pwd
/Users/och54055405/study/workStation

# 2. 파일 생성 및 내용 확인
$ touch mvTest
$ echo 'hello world' > hello
$ ls -al
total 8
drwxr-xr-x  5 och54055405  och54055405  160 Apr  1 20:22 .
drwxr-xr-x  3 och54055405  och54055405   96 Apr  1 20:20 ..
-rw-r--r--  1 och54055405  och54055405   12 Apr  1 20:22 hello
-rw-r--r--  1 och54055405  och54055405    0 Apr  1 20:22 mvTest
drwxr-xr-x  2 och54055405  och54055405   64 Apr  1 20:20 practice

$ cat hello 
hello world

# 3. 복사 및 이름 변경(이동) 검증
$ cp hello hello2
$ ls -al
total 16
drwxr-xr-x  6 och54055405  och54055405  192 Apr  1 20:23 .
drwxr-xr-x  3 och54055405  och54055405   96 Apr  1 20:20 ..
-rw-r--r--  1 och54055405  och54055405   12 Apr  1 20:22 hello
-rw-r--r--  1 och54055405  och54055405   12 Apr  1 20:23 hello2
-rw-r--r--  1 och54055405  och54055405    0 Apr  1 20:22 mvTest
drwxr-xr-x  2 och54055405  och54055405   64 Apr  1 20:20 practice

$ mv hello hello1
$ ls -al
total 16
drwxr-xr-x  6 och54055405  och54055405  192 Apr  1 20:23 .
drwxr-xr-x  3 och54055405  och54055405   96 Apr  1 20:20 ..
-rw-r--r--  1 och54055405  och54055405   12 Apr  1 20:22 hello1
-rw-r--r--  1 och54055405  och54055405   12 Apr  1 20:23 hello2
-rw-r--r--  1 och54055405  och54055405    0 Apr  1 20:22 mvTest
drwxr-xr-x  2 och54055405  och54055405   64 Apr  1 20:20 practice

$ mv hello2 practice/
$ ls -al practice/            # 파일 이동 확인
total 8
drwxr-xr-x  3 och54055405  och54055405   96 Apr  1 20:23 .
drwxr-xr-x  5 och54055405  och54055405  160 Apr  1 20:23 ..
-rw-r--r--  1 och54055405  och54055405   12 Apr  1 20:23 hello2

# 4. 삭제 검증
$ rm ./practice/hello2
$ ls -al practice/
total 0
drwxr-xr-x  2 och54055405  och54055405   64 Apr  1 20:24 .
drwxr-xr-x  5 och54055405  och54055405  160 Apr  1 20:23 ..

```
### 4.2 권한실습 및 증거기록
```bash
# 1. 파일 변경 전 권한
$ ls -al hello1
-rw-r--r--  1 och54055405  och54055405  12 Apr  1 20:22 hello1

# 2. 파일 변경 후 권한
$ chmod 755 hello1 # 소유자는 풀권한, 그룹과 다른 사용자는 읽고 실행할 수 있는 권한만
$ ls -al hello1
-rwxr-xr-x  1 och54055405  och54055405  12 Apr  1 20:22 hello1

# 3. 디렉터리 변경 전 권한
$ ls -al 
total 8
drwxr-xr-x  5 och54055405  och54055405  160 Apr  1 20:23 .
drwxr-xr-x  3 och54055405  och54055405   96 Apr  1 20:20 ..
-rwxr-xr-x  1 och54055405  och54055405   12 Apr  1 20:22 hello1
-rw-r--r--  1 och54055405  och54055405    0 Apr  1 20:22 mvTest
drwxr-xr-x  2 och54055405  och54055405   64 Apr  1 20:24 practice

# 4. 디렉터리 변경 후 권한
$ chmod 777 practice # 공용 디렉터리로서 모든 사용자의 쓰기 권한이 필요한 경우
$ ls -al 
drwxr-xr-x  5 och54055405  och54055405  160 Apr  1 20:23 .
drwxr-xr-x  3 och54055405  och54055405   96 Apr  1 20:20 ..
-rwxr-xr-x  1 och54055405  och54055405   12 Apr  1 20:22 hello1
-rw-r--r--  1 och54055405  och54055405    0 Apr  1 20:22 mvTest
drwxrwxrwx  2 och54055405  och54055405   64 Apr  1 20:24 practice

```
### 4.3 Docker 설치 및 기본 점검
```bash
# 1. docker version
$ docker --version
Docker version 28.5.2, build ecc6942

# 2. docker 데몬 동작 여부 확인 결과
$ docker info
Client:
 Version:    28.5.2
 Context:    orbstack
 Debug Mode: false
 Plugins:
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.29.1
    Path:     /Users/och54055405/.docker/cli-plugins/docker-buildx
  compose: Docker Compose (Docker Inc.)
    Version:  v2.40.3
    Path:     /Users/och54055405/.docker/cli-plugins/docker-compose

Server:
 Containers: 0 # 현재 내 피씨에 있는 컨테이너 갯수
  Running: 0
  Paused: 0
  Stopped: 0
 Images: 0 # 내려받은 이미지 갯수
 Server Version: 28.5.2
 Storage Driver: overlay2
  Backing Filesystem: btrfs
  Supports d_type: true
  Using metacopy: false
  Native Overlay Diff: true
  userxattr: false
 Logging Driver: json-file
 Cgroup Driver: cgroupfs
 Cgroup Version: 2
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local splunk syslog
 CDI spec directories:
  /etc/cdi
  /var/run/cdi
 Swarm: inactive
 Runtimes: io.containerd.runc.v2 runc
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: 1c4457e00facac03ce1d75f7b6777a7a851e5c41
 runc version: d842d7719497cc3b774fd71620278ac9e17710e0
 init version: de40ad0
 Security Options:
  seccomp
   Profile: builtin
  cgroupns
 Kernel Version: 6.17.8-orbstack-00308-g8f9c941121b1
 Operating System: OrbStack # 컨테이너를 실행하고 관리할 수 있도록 지원하는 주체
 OSType: linux
 Architecture: x86_64
 CPUs: 6
 Total Memory: 15.67GiB
 Name: orbstack
 ID: 7b7c0e86-79c4-4f60-b427-e9ec47343774
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Experimental: false
 Insecure Registries:
  ::1/128
  127.0.0.0/8
 Live Restore Enabled: false
 Product License: Community Engine
 Default Address Pools:
   Base: 192.168.97.0/24, Size: 24
   Base: 192.168.107.0/24, Size: 24
   Base: 192.168.117.0/24, Size: 24
   Base: 192.168.147.0/24, Size: 24
   Base: 192.168.148.0/24, Size: 24
   Base: 192.168.155.0/24, Size: 24
   Base: 192.168.156.0/24, Size: 24
   Base: 192.168.158.0/24, Size: 24
   Base: 192.168.163.0/24, Size: 24
   Base: 192.168.164.0/24, Size: 24
   Base: 192.168.165.0/24, Size: 24
   Base: 192.168.166.0/24, Size: 24
   Base: 192.168.167.0/24, Size: 24
   Base: 192.168.171.0/24, Size: 24
   Base: 192.168.172.0/24, Size: 24
   Base: 192.168.181.0/24, Size: 24
   Base: 192.168.183.0/24, Size: 24
   Base: 192.168.186.0/24, Size: 24
   Base: 192.168.207.0/24, Size: 24
   Base: 192.168.214.0/24, Size: 24
   Base: 192.168.215.0/24, Size: 24
   Base: 192.168.216.0/24, Size: 24
   Base: 192.168.223.0/24, Size: 24
   Base: 192.168.227.0/24, Size: 24
   Base: 192.168.228.0/24, Size: 24
   Base: 192.168.229.0/24, Size: 24
   Base: 192.168.237.0/24, Size: 24
   Base: 192.168.239.0/24, Size: 24
   Base: 192.168.242.0/24, Size: 24
   Base: 192.168.247.0/24, Size: 24
   Base: fd07:b51a:cc66:d000::/56, Size: 64

WARNING: DOCKER_INSECURE_NO_IPTABLES_RAW is set
```
### 4.4 Docker 기본 운영 명령 수행
```bash
# 1. docker pull
$ docker pull nginx
Using default tag: latest
latest: Pulling from library/nginx
ec781dee3f47: Pull complete 
bb3d0aa29654: Pull complete 
510ddf6557d6: Pull complete 
cde7a05ae428: Pull complete 
587e3d84dbb5: Pull complete 
3189680c601f: Pull complete 
5e815e07e569: Pull complete 
Digest: sha256:7150b3a39203cb5bee612ff4a9d18774f8c7caf6399d6e8985e97e28eb751c18
Status: Downloaded newer image for nginx:latest
docker.io/library/nginx:latest

# 2. docker images
$ docker images
REPOSITORY   TAG       IMAGE ID       CREATED      SIZE
nginx        latest    0cf1d6af5ca7   7 days ago   161MB

# 3. docker run (이미지를 실행시켜 격리된 공간을 만듦)
$ docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
4f55086f7dd0: Pull complete 
Digest: sha256:452a468a4bf985040037cb6d5392410206e47db9bf5b7278d281f94d1c2d0931
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/

# 4. docker ps
$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
$ docker ps -a
CONTAINER ID   IMAGE         COMMAND    CREATED          STATUS                      PORTS     NAMES
aa299f003f00   hello-world   "/hello"   10 minutes ago   Exited (0) 10 minutes ago             keen_black

# 5. docker logs 
$ docker run -d --name my-web nginx
0c269420e2e59087f0984a1043060f8d855497e1fe275a5d191564d5d48bf085

$ docker logs my-web
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2026/04/01 12:14:29 [notice] 1#1: using the "epoll" event method
2026/04/01 12:14:29 [notice] 1#1: nginx/1.29.7
2026/04/01 12:14:29 [notice] 1#1: built by gcc 14.2.0 (Debian 14.2.0-19) 
2026/04/01 12:14:29 [notice] 1#1: OS: Linux 6.17.8-orbstack-00308-g8f9c941121b1
2026/04/01 12:14:29 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 20480:1048576
2026/04/01 12:14:29 [notice] 1#1: start worker processes
2026/04/01 12:14:29 [notice] 1#1: start worker process 29
2026/04/01 12:14:29 [notice] 1#1: start worker process 30
2026/04/01 12:14:29 [notice] 1#1: start worker process 31
2026/04/01 12:14:29 [notice] 1#1: start worker process 32
2026/04/01 12:14:29 [notice] 1#1: start worker process 33
2026/04/01 12:14:29 [notice] 1#1: start worker process 34

# 6. docker stats
$ docker stats --no-stream my-web
CONTAINER ID   NAME      CPU %     MEM USAGE / LIMIT     MEM %     NET I/O         BLOCK I/O         PIDS
0c269420e2e5   my-web    0.00%     6.199MiB / 15.67GiB   0.04%     1.13kB / 126B   16.9MB / 8.19kB   7

```

### 4.5 컨테이너 실행 실습
```bash

```
### 4.6 기존 Dockerfile 기반 커스텀 이미지 제작
### 4.7 포트 매핑 및 접속 증거
### Docker 볼륨 영속성 검증
### Git 설정 및 GitHub 연동

## 5. 트러블슈팅 (Troubleshooting)
1) GitHub Push 인증 오류 (Password Auth)

문제: git push 시 비밀번호 인증 실패 (support for password authentication was removed).

원인: GitHub 보안 정책으로 비밀번호 대신 PAT(Token) 사용이 필수임.

해결: Settings > Developer settings에서 PAT(classic)를 생성하여 비밀번호 대신 입력함.