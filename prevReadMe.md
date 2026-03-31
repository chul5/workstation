# 1st work
모든 수행 결과는 “기술 문서(README.md 등)”에서 확인 가능해야 한다.

# 프로젝트 개요(미션 목표 요약)
이 미션에서는 터미널로 작업 디렉토리와 권한을 정리한 뒤, Docker를 설치 및 점검하고 컨테이너를 실행/관리합니다.
이어서 간단한 웹 서버를 Dockerfile로 컨테이너화하고, 포트 매핑으로 접속을 확인하며, 바인드 마운트/볼륨으로 "변경 반영"과 "데이터 영속성"을 직접 검증합니다.

단순히 따라 치는 실습이 아니라, 실행 결과(로그/접속/데이터 유지)로 핵심 흐름을 확인합니다. 또한, 이미지와 컨테이너의 분리, 격리된 실행 환경, 포트·스토리지 연결 방식이라는 구조적 원칙을 적용해 "왜 이런 설계가 필요한지"를 설명 가능한 형태로 정리합니다.

같은 서비스를 여러 번 실행해도 재현되는 환경을 만드는 사고방식을 경험하는 것이 목표입니다.

## 실행 환경(OS/쉘/터미널, Docker 버전, Git 버전)

### docker version, git version
```
# 1. 도커 버전 확인
docker --version
Docker version 28.5.2, build ecc6942

# 2. 깃 버전 확인
git --version 
git version 2.53.0
```

## 수행 항목 체크리스트(터미널/권한/Docker/Dockerfile/포트/마운트/볼륨/Git/GitHub)
다음 과제들을 수행해야 한다.

### 터미널 조작 로그 기록
```
# 1. 현재 위치 확인
pwd

/Users/och54055405/study

# 2. 목록 확인(숨김 파일 포함)
ls -al

total 0
drwxr-xr-x  2 och54055405  och54055405  64 Mar 31 20:00 .
drwxr-xr-x  3 och54055405  och54055405  96 Mar 31 20:00 ..

# 3. 이동
cd ..

# 4. 생성
- 디렉터리
mkdir -p ~/study/workStation/practice

- 파일
touch mvTest
echo 'hello world' > hello

# 5. 복사
cp hello hello2

# 6. 이동/이름변경
mv mvTest mvTest1
mv mvTest1 workStation

# 7. 삭제
rm ~/study/workStation/mvTest1

# 8. 파일 내용 확인
cat hello

hello world

# 9. 빈 파일 생성
touch mvTest
```

### 권한 실습 및 증거 기록
```
# 1. 파일 변경 전 권한
$ ls -l hello1
-rw-r--r--  1 och54055405  och54055405  12 Mar 31 20:18 hello1

# 2. 파일 변경 후 권한
$ chmod 755 hello1
$ ls -l hello1
-rwxr-xr-x  1 och54055405  och54055405  12 Mar 31 20:18 hello1

# 3. 디렉터리 변경 전 권한
$ ls -l 
total 24
-rw-r--r--  1 och54055405  och54055405  2780 Mar 31 19:53 README.md
-rwxr-xr-x  1 och54055405  och54055405    12 Mar 31 20:18 hello
drwxr-xr-x  3 och54055405  och54055405    96 Mar 31 20:37 workStation

# 4. 디렉터리 변경 후 권한
$ chmod 777 workStation 
$ ls -l 
total 24
-rw-r--r--  1 och54055405  och54055405  2780 Mar 31 19:53 README.md
-rwxr-xr-x  1 och54055405  och54055405    12 Mar 31 20:18 hello
-rw-r--r--  1 och54055405  och54055405    12 Mar 31 20:28 hello2
drwxrwxrwx  3 och54055405  och54055405    96 Mar 31 20:37 workStation
```

### Docker 설치 및 기본 점검
### Docker 기본 운영 명령 수행
### 컨테이너 실행 실습
### 기존 Dockerfile 기반 커스텀 이미지 제작
### 포트 매핑 및 접속 증거
### Docker 볼륨 영속성 검증
### Git 설정 및 GitHub 연동
* Git 사용자 정보/기본 브랜치 설정을 완료하고 git config --list 결과를 기록한다.
```
git config --list

credential.helper=osxkeychain
user.name=cody
user.email=och5405@naver.com
init.defaultbranch=main
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
core.ignorecase=true
core.precomposeunicode=true
remote.origin.url=https://github.com/chul5/workstation.git
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
```

* GitHub 로그인 및 저장소 연동을 완료하고, 연동 증거(스크린샷 등)를 기술 문서에 첨부한다.
```
git remote -v

origin	https://github.com/chul5/workstation.git (fetch)
origin	https://github.com/chul5/workstation.git (push)
```

### 보안 및 개인정보 보호
* 기술 문서/로그/스크린샷에 토큰, 비밀번호, 개인키, 인증 코드 등이 포함되지 않도록 마스킹한다.
* 의심되는 민감정보가 노출된 경우, 즉시 히스토리/문서에서 제거하고 재발급 절차를 수행한다 (가능한 범위에서).
## 검증 방법(어떤 명령으로 무엇을 확인했는지) + 결과 위치/증거 링크


