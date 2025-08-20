# UniUnity

**UniUnity** 프로젝트의 **k8s 레포지토리**입니다.  
마이크로서비스 아키텍처(MSA)를 기반으로 서비스가 독립적으로 배포 및 확장 가능하도록 설계되었습니다.  

## 🛠 Tech Stack
<img src="https://skillicons.dev/icons?i=nodejs,mysql,rabbitmq,docker,kubernetes,github,gcp" height="50">

---

## 📚 목차

1. [프로젝트 소개](#-프로젝트-소개)  
2. [기술 스택](#-기술-스택)  
3. [팀원 소개](#-팀원-소개)  
4. [서비스 아키텍처](#-서비스-아키텍처)  
5. [레포지토리 구성](#-레포지토리-구성)  
6. [쿠버네티스 설정](#-쿠버네티스-설정)  
   - Deployment  
   - Pod Health Check  
   - Ingress  
   - DB(Service / PVC)  
   - Secret  
7. [통신 방법](#-통신-방법)  
   - 직접 통신  
   - 간접 통신  
8. [CI/CD 파이프라인](#-cicd-파이프라인)  
9. [데모 영상](#-데모-영상)  

---

## 📖 프로젝트 소개

**UniUnity**는 대학 상권 커뮤니티 서비스를 구축하기 위해 MSA(Microservices Architecture)를 적용한 프로젝트입니다.  
RabbitMQ를 이용한 간접 통신과 JWT 기반 직접 통신을 통해 안정적이고 확장성 있는 백엔드 시스템을 설계했습니다.  

**주요 특징**
- 서비스 단위로 분리된 MSA 구조  
- RabbitMQ 기반 RPC 방식 비동기 메시징  
- JWT 기반 인증 및 직접 통신(/auth/me)  
- Kubernetes 환경에서의 배포 및 확장  
- GitHub Actions를 이용한 CI/CD 자동화  

---

## 🛠 기술 스택

| 구분 | 기술 |
|------|------|
| **Language** | Javascript |
| **Framework** | Node.js, Express |
| **Database** | MySQL|
| **Messaging** | RabbitMQ |
| **Infra** | Docker, Kubernetes(GKE), GCP |
| **CI/CD** | GitHub Actions, Docker Hub |
| **Auth** | JWT |
| **기타** | ConfigMap, Secret, Ingress |

---
## 👤 팀원 소개

<div align="center">

| Team Member | Team Member | Team Member |
|:---------------------------------------------------------------------:|:-------------------------------------------------------------------:|:----------------------------------------------------------------------:|
| <img src="https://github.com/pjhyun0225.png" width="150" /> | <img src="https://github.com/KimGeunHye21.png" width="150" /> | <img src="https://github.com/youngseoOh.png" width="150" /> |
| [박지현](https://github.com/pjhyun0225)<br />Partner-Service 담당 | [김근혜](https://github.com/KimGeunHye21)<br />User-Service 담당 | [오영서](https://github.com/youngseoOh)<br />Post-Reaction-Service 담당 |

| Team Member | Team Member | Team Member |
|:---------------------------------------------------------------------:|:-------------------------------------------------------------------:|:----------------------------------------------------------------------:|
| <img src="https://github.com/chaehyeon02.png" width="150" /> | <img src="https://github.com/5IHYUN.png" width="150" /> | <img src="https://github.com/JiwonLee42.png" width="150" /> |
| [이채현](https://github.com/chaehyeon02)<br />Start-Service 담당 | [김시현](https://github.com/5IHYUN)<br />Post-Service 담당 | [이지원](https://github.com/JiwonLee42)<br />Post-Reaction-Service 담당 |

</div>

---

## 🖥 서비스 아키텍처

> UniUnity 서비스 전체 구성도입니다.  

<img width="644" height="321" alt="Image" src="https://github.com/user-attachments/assets/cc6efb72-e962-44c7-b5ab-1b8fe8cde7cd" />

---

## 🗂 레포지토리 구성

```plaintext
unimsa/
 ├── k8s/                  # Kubernetes 관련 리소스
 │   ├── db/               # DB Deployment, PVC, Service
 │   ├── rabbitmq/         # RabbitMQ Deployment, Service
 │   ├── ingress/          # Ingress Controller 설정
 │   └── service/          # 각 서비스 Deployment, Service
 │
 ├── service-repos/        # 개별 서비스 레포지토리
 │   ├── user-service/
 │   ├── partner-service/
 │   ├── start-service/
 │   └── post-service/
 │
 └── cicd/                 # GitHub Actions 워크플로우
```
---
## ☸️ 쿠버네티스 설정

### 1. Deployment
- 각 서비스는 `Deployment.yaml` 기반으로 배포  
- `initContainer`를 활용하여 DB와 RabbitMQ 준비 여부 확인 후 서비스 실행  

### 2. Pod Health Check
- `/ready` → DB, RabbitMQ 연결 상태 확인  
- `/health` → 파드 정상 동작 여부 확인  
- `readinessProbe`, `livenessProbe` 적용  

### 3. Ingress
- **Nginx Ingress Controller** 사용  
- 도메인 기반 라우팅 (`uniunity.store`)  
- 예시: `/mainpage` → `start-service`  

### 4. DB (Service / PVC)
- MySQL DB 파드 및 PVC 구성 (1Gi)  
- ClusterIP 타입으로 내부 서비스에서만 접근 가능  

### 5. Secret
- 민감한 DB 접속 정보 및 RabbitMQ 계정 정보 관리  
- ConfigMap과 분리하여 안전한 배포 지원  

---

## 🔗 통신 방법

### 1. 직접 통신
- **JWT 기반 인증 (/auth/me)**  
- 브라우저 쿠키의 토큰을 검증 후 유저 정보 반환  
- 서비스 간 직접 REST API 통신  

### 2. 간접 통신
- **RabbitMQ RPC 패턴**  
- 요청 → 큐 발행 → 응답 큐 수신  
- `correlationId`를 활용해 요청-응답 매칭  
- 비동기 환경에서도 동기적 요청-응답 구조 구현  

---

## ⚙️ CI/CD 파이프라인

### GitHub Actions
- 코드 푸시 → 자동 빌드 & Docker Hub 푸시  
- 태그 형식: `YYYYMMDDHHMM`  

### 배포 파이프라인
1. GKE 로그인  
2. ConfigMap, Secret 적용  
3. DB, RabbitMQ 배포  
4. 서비스 Deployment 반영  
5. Ingress 적용  
6. 로그 확인  

---

## 📺 데모 영상

[👉 UniUnity 프로젝트 데모 영상 보러가기]([https://example.com/demo-link](https://www.youtube.com/watch?v=r5Sv55nrUzY)
