# Local Setup Guide

This guide explains how to set up and run the full Fitness Project on a new laptop.

## Project Overview

The project contains:

- Angular frontend: `fitness-coach-ui`
- Spring Boot backend services:
  - `gateway-service` on port `8080`
  - `auth-service` on port `8081`
  - `member-service` on port `8082`
  - `workout-service` on port `8083`
  - `diet-service` on port `8084`
  - `checkin-service` on port `8085`
  - `billing-service` on port `8086`
  - `notification-service` on port `8087`
  - `diet-review` on port `8088`
- PostgreSQL 15 database
- Flyway migrations inside each Spring Boot service
- Docker Compose for the local backend and database stack

## Prerequisites

Install these on the new machine:

- Git
- Docker Desktop, including Docker Compose
- Node.js 20 LTS or newer
- npm, installed with Node.js
- Java 21 JDK, only needed when running backend services outside Docker
- A terminal:
  - Windows: PowerShell
  - macOS/Linux: Terminal

Optional tools:

- Postman or Insomnia for API testing
- pgAdmin, DBeaver, or another PostgreSQL client
- Angular CLI globally, if you prefer `ng` commands directly:

```bash
npm install -g @angular/cli
```

## Clone The Project

```bash
git clone <repository-url>
cd Fitness_Project
```

## Environment File

Create a local `.env` file from the example:

```bash
cp .env.example .env
```

On Windows PowerShell:

```powershell
Copy-Item .env.example .env
```

For normal local development, the defaults are enough. Fill these only when you need the related feature:

- `RAZORPAY_KEY_ID`, `RAZORPAY_KEY_SECRET`, `WEBHOOK_SECRET`: billing/payment integration
- `OPENAI_API_KEY`: diet review AI integration
- `STORAGE_PROVIDER`, `AWS_REGION`, `S3_BUCKET`, `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`: S3 check-in photo storage

Keep `.env` private. It is ignored by Git.

## Recommended Local Run

Use Docker for the database and backend services, then run the Angular frontend locally.

### 1. Start Backend And Database

From the repository root:

```bash
docker compose up -d --build
```

This starts:

- PostgreSQL on `localhost:5432`
- Gateway API on `http://localhost:8080`
- All backend microservices on ports `8081` to `8088`

PostgreSQL databases are created by `postgres-init/init.sql`:

- `coach_auth`
- `coach_member`
- `coach_diet`
- `coach_workout`
- `coach_billing`
- `coach_checkin`
- `coach_notification`

Each service runs its own Flyway migrations during startup.

### 2. Check Container Status

```bash
docker compose ps
```

View logs if a service does not start:

```bash
docker compose logs -f
```

For one service:

```bash
docker compose logs -f auth-service
```

### 3. Install Frontend Dependencies

```bash
cd fitness-coach-ui
npm install
```

### 4. Start The Frontend

```bash
npm start
```

Open:

```text
http://localhost:4200
```

The frontend local environment points all API calls to the gateway:

```text
http://localhost:8080
```

## Useful Local URLs

- Frontend: `http://localhost:4200`
- Gateway: `http://localhost:8080`
- Gateway health: `http://localhost:8080/actuator/health`
- PostgreSQL: `localhost:5432`

Swagger UI, where enabled:

- Auth service: `http://localhost:8081/swagger-ui.html`
- Member service: `http://localhost:8082/swagger-ui.html`
- Workout service: `http://localhost:8083/swagger-ui.html`
- Diet service: `http://localhost:8084/swagger-ui.html`
- Check-in service: `http://localhost:8085/swagger-ui.html`
- Billing service: `http://localhost:8086/swagger-ui.html`
- Notification service: `http://localhost:8087/swagger-ui.html`
- Diet review service: `http://localhost:8088/swagger-ui.html`

## Database Login

Default local PostgreSQL credentials from `docker-compose.yml`:

```text
Host: localhost
Port: 5432
User: postgres
Password: admin
```

## Stop The Project

Stop containers but keep database data:

```bash
docker compose down
```

Stop containers and delete local database volume:

```bash
docker compose down -v
```

Use `-v` only when you want a fresh database. The next startup will recreate the databases and rerun migrations.

## Manual Backend Development

Docker is easier for a new laptop, but services can also run directly from the IDE or terminal.

### 1. Start Only PostgreSQL

```bash
docker compose up -d postgres
```

### 2. Run Services Locally

When running a backend service outside Docker, use `localhost` for the database host instead of `postgres`.

Example for `auth-service`:

```bash
cd auth-service
./mvnw spring-boot:run -Dspring-boot.run.arguments="--DB_URL=jdbc:postgresql://localhost:5432/coach_auth"
```

On Windows PowerShell:

```powershell
cd auth-service
.\mvnw.cmd spring-boot:run -Dspring-boot.run.arguments="--DB_URL=jdbc:postgresql://localhost:5432/coach_auth"
```

Repeat for other services, changing the database and port as needed:

| Service | Port | Database |
| --- | ---: | --- |
| `auth-service` | 8081 | `coach_auth` |
| `member-service` | 8082 | `coach_member` |
| `workout-service` | 8083 | `coach_workout` |
| `diet-service` | 8084 | `coach_diet` |
| `checkin-service` | 8085 | `coach_checkin` |
| `billing-service` | 8086 | `coach_billing` |
| `notification-service` | 8087 | `coach_notification` |
| `diet-review` | 8088 | none |

The gateway should run after the services it routes to.

## Run Tests

Backend service tests:

```bash
cd auth-service
./mvnw test
```

On Windows PowerShell:

```powershell
cd auth-service
.\mvnw.cmd test
```

Frontend tests:

```bash
cd fitness-coach-ui
npm test
```

## Build Checks

Frontend production build:

```bash
cd fitness-coach-ui
npm run build
```

Backend package example:

```bash
cd member-service
./mvnw clean package
```

On Windows PowerShell:

```powershell
cd member-service
.\mvnw.cmd clean package
```

## Common Issues

### Port Already In Use

Make sure these ports are free:

```text
4200, 5432, 8080, 8081, 8082, 8083, 8084, 8085, 8086, 8087, 8088
```

Stop the conflicting app or change the port in the related service configuration.

### Frontend Cannot Reach Backend

Check that:

- `gateway-service` is running
- `http://localhost:8080/actuator/health` responds
- `fitness-coach-ui/src/environments/environment.ts` points APIs to `http://localhost:8080`
- `CORS_ALLOWED_ORIGINS` includes `http://localhost:4200`

### Database Migration Failure

Check service logs:

```bash
docker compose logs -f <service-name>
```

If this is a local throwaway database and you want to start fresh:

```bash
docker compose down -v
docker compose up -d --build
```

### Docker Build Is Slow On First Run

The first build downloads Java, Maven, Node, and npm dependencies. Later builds should be faster because Docker caches layers.

## Production Deployment

For VPS or production setup, use:

- `DEPLOYMENT.md`
- `.env.prod.example`
- `docker-compose.prod.yml`
- `Caddyfile`
