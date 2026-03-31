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
- [ ] Docker 설치 및 기본 환경 점검 (`docker info`)
- [ ] Docker 기본 운영 명령 수행
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
$ ls -R ~/study/workStation  # 디렉토리 생성 확인
practice

# 2. 이동
$ cd ./study/workStation
$ pwd
/Users/och54055405/study/workStation

# 2. 파일 생성 및 내용 확인
$ touch mvTest
$ echo 'hello world' > hello
$ ls -al
결과
$ cat hello 
hello world

# 3. 복사 및 이름 변경(이동) 검증
$ cp hello hello2
$ ls -al
결과
$ mv hello hello1
$ ls -al
결과
$ mv hello2 practice/
$ ls -al practice/            # 파일 이동 확인
결과

# 4. 삭제 검증
$ rm ~/study/practice/hello2
$ ls -al practice/
결과
```
### 4.2 권한실습 및 증거기록
```bash
# 1. 파일 변경 전 권한
$ ls -al hello1
결과

# 2. 파일 변경 후 권한
$ chmod 755 hello1
$ ls -al hello1
결과

# 3. 디렉터리 변경 전 권한
$ ls -al 
결과

# 4. 디렉터리 변경 후 권한
$ chmod 777 practice
$ ls -al 
결과

```
### 4.3 Docker 설치 및 기본 점검
```bash
# 1. docker version
$ docker --version
결과

# 2. docker 데몬 동작 여부 확인 결과
$
결과
```
### 4.4 Docker 기본 운영 명령 수행
```bash

```

### 4.5 컨테이너 실행 실습
### 4.6 기존 Dockerfile 기반 커스텀 이미지 제작
### 4.7 포트 매핑 및 접속 증거
### Docker 볼륨 영속성 검증
### Git 설정 및 GitHub 연동

## 5. 트러블슈팅 (Troubleshooting)
1) GitHub Push 인증 오류 (Password Auth)

문제: git push 시 비밀번호 인증 실패 (support for password authentication was removed).

원인: GitHub 보안 정책으로 비밀번호 대신 PAT(Token) 사용이 필수임.

해결: Settings > Developer settings에서 PAT(classic)를 생성하여 비밀번호 대신 입력함.