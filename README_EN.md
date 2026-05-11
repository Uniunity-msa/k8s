# UniUnity

[한국어](./README.md) | English

UniUnity is a Kubernetes-based MSA project for a university district community platform.
It is designed for independent deployment and scalability of services,
providing RabbitMQ-based asynchronous communication and JWT-based authentication.

Read the full README in your preferred language.

---

# UniUnity

This is the **Kubernetes repository** for the **UniUnity** project.
The project is designed with a Microservices Architecture (MSA), allowing each service to be independently deployed and scaled.

## 🛠 Tech Stack

<img src="https://skillicons.dev/icons?i=nodejs,mysql,rabbitmq,docker,kubernetes,github,gcp" height="50">

---

## 📚 Table of Contents

1. [Project Overview](#-project-overview)
2. [Tech Stack](#-tech-stack)
3. [Team Members](#-team-members)
4. [Service Architecture](#-service-architecture)
5. [Repository Structure](#-repository-structure)
6. [Kubernetes Configuration](#-kubernetes-configuration)

   * Deployment
   * Pod Health Check
   * Ingress
   * DB(Service / PVC)
   * Secret
7. [Communication Methods](#-communication-methods)

   * Direct Communication
   * Indirect Communication
8. [CI/CD Pipeline](#-cicd-pipeline)
9. [Demo Video](#-demo-video)

---

## 📖 Project Overview

**UniUnity** is a project that applies Microservices Architecture (MSA) to build a university district community platform.
The backend system is designed to be stable and scalable through RabbitMQ-based asynchronous communication and JWT-based direct communication.

### Key Features

* Service-oriented MSA structure
* RabbitMQ RPC-based asynchronous messaging
* JWT-based authentication and direct communication (`/auth/me`)
* Deployment and scalability in Kubernetes environments
* Automated CI/CD using GitHub Actions

---

## 🛠 Tech Stack

| Category           | Technology                   |
| ------------------ | ---------------------------- |
| **Language**       | Javascript                   |
| **Framework**      | Node.js, Express             |
| **Database**       | MySQL                        |
| **Messaging**      | RabbitMQ                     |
| **Infrastructure** | Docker, Kubernetes(GKE), GCP |
| **CI/CD**          | GitHub Actions, Docker Hub   |
| **Authentication** | JWT                          |
| **Others**         | ConfigMap, Secret, Ingress   |

---

## 👤 Team Members

<div align="center">

|                             Team Leader                            |                            Team Member                           |                               Team Member                               |
| :----------------------------------------------------------------: | :--------------------------------------------------------------: | :---------------------------------------------------------------------: |
|     <img src="https://github.com/pjhyun0225.png" width="150" />    |   <img src="https://github.com/KimGeunHye21.png" width="150" />  |       <img src="https://github.com/youngseoOh.png" width="150" />       |
| [Jihyeon Park](https://github.com/pjhyun0225)<br />Partner-Service | [Geunhye Kim](https://github.com/KimGeunHye21)<br />User-Service | [Youngseo Oh](https://github.com/youngseoOh)<br />Post-Reaction-Service |

|                             Team Member                            |                        Team Member                        |                              Team Member                              |
| :----------------------------------------------------------------: | :-------------------------------------------------------: | :-------------------------------------------------------------------: |
|    <img src="https://github.com/chaehyeon02.png" width="150" />    |  <img src="https://github.com/5IHYUN.png" width="150" />  |      <img src="https://github.com/JiwonLee42.png" width="150" />      |
| [Chaehyeon Lee](https://github.com/chaehyeon02)<br />Start-Service | [Sihyun Kim](https://github.com/5IHYUN)<br />Post-Service | [Jiwon Lee](https://github.com/JiwonLee42)<br />Post-Reaction-Service |

</div>

---

## 📃 Team Responsibilities

### Team 1 (Sihyun Kim, Youngseo Oh, Jiwon Lee)

#### Post-Service / Post-Reaction-Service

* Implemented post creation features by category and member type
* Implemented image storage using Google Cloud

### Team 2 (Geunhye Kim, Jihyeon Park, Chaehyeon Lee)

#### Partner-Service

* Displayed partner stores and local businesses using Kakao Map API
* Stored and uploaded partner store information by university
* Displayed local business information using public data APIs

#### User-Service

* Implemented user features using JWT and Cookies
* Managed communication for user and university information

#### Start-Service

* Implemented the main service page
* Implemented navigation by university pages

---

## 🖥 Service Architecture

> Overall architecture of the UniUnity service.

<img width="644" height="321" alt="Image" src="https://github.com/user-attachments/assets/cc6efb72-e962-44c7-b5ab-1b8fe8cde7cd" />

---

## 🗂 Repository Structure

```plaintext
unimsa/
 ├── k8s/                  # Kubernetes resources
 │   ├── db/               # DB Deployment, PVC, Service
 │   ├── rabbitmq/         # RabbitMQ Deployment, Service
 │   ├── ingress/          # Ingress Controller configuration
 │   └── service/          # Service Deployment, Service
 │
 ├── service-repos/        # Individual service repositories
 │   ├── user-service/
 │   ├── partner-service/
 │   ├── start-service/
 │   └── post-service/
 │
 └── cicd/                 # GitHub Actions workflows
```

---

## ☸️ Kubernetes Configuration

### 1. Deployment

* Each service is deployed based on `Deployment.yaml`
* `initContainer` is used to check DB and RabbitMQ readiness before starting services

### 2. Pod Health Check

* `/ready` → Checks DB and RabbitMQ connection status
* `/health` → Checks pod health status
* Applied `readinessProbe` and `livenessProbe`

### 3. Ingress

* Uses **Nginx Ingress Controller**
* Domain-based routing (`uniunity.store`)
* Example: `/mainpage` → `start-service`

### 4. DB (Service / PVC)

* Configured MySQL DB pod and PVC (1Gi)
* Accessible only within the cluster using ClusterIP

### 5. Secret

* Manages sensitive DB and RabbitMQ account information
* Separated from ConfigMap for secure deployment support

---

## 🔗 Communication Methods

### 1. Direct Communication

* **JWT-based authentication (`/auth/me`)**
* Verifies tokens stored in browser cookies and returns user information
* Direct REST API communication between services

### 2. Indirect Communication

* **RabbitMQ RPC Pattern**
* Request → Queue Publish → Response Queue Receive
* Uses `correlationId` for request-response matching
* Implements synchronous request-response structure in asynchronous environments

---

## ⚙️ CI/CD Pipeline

### GitHub Actions

* Push code → Automatic build & Docker Hub push
* Tag format: `YYYYMMDDHHMM`

### Deployment Pipeline

1. Login to GKE
2. Apply ConfigMap and Secret
3. Deploy DB and RabbitMQ
4. Apply Service Deployments
5. Apply Ingress
6. Check logs

---

## 📺 Demo Video

[👉 Watch the UniUnity Demo Video](https://www.youtube.com/watch?v=r5Sv55nrUzY)
