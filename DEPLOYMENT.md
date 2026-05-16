# Deployment

This repository is production-ready for a single VPS deployment using Docker Compose, Caddy, Postgres, and AWS S3 only for check-in photo storage.

## What this setup does

- Serves the Angular app through `fitness-coach-ui`
- Routes all backend traffic through `gateway-service`
- Keeps internal Spring services and Postgres private inside Docker
- Terminates HTTPS at Caddy
- Uses AWS S3 only for `checkin-service` photo upload and retrieval

## Files

- `docker-compose.yml`: local development stack
- `docker-compose.prod.yml`: production VPS stack
- `.env.prod.example`: production environment template
- `Caddyfile`: reverse proxy and HTTPS

## Server recommendation

- Ubuntu 24.04 LTS VPS
- 2 vCPU minimum
- 8 GB RAM recommended for the current microservice layout
- 40 GB SSD or higher

## First-time server setup

Install Docker and Compose plugin on the VPS, clone the repository, then create a production env file:

```bash
cp .env.prod.example .env.prod
```

Edit `.env.prod` and set:

- `APP_DOMAIN`
- `POSTGRES_PASSWORD`
- `JWT_SECRET`
- `CORS_ALLOWED_ORIGINS`
- `RAZORPAY_*` if billing is enabled
- `OPENAI_*` if diet review is enabled
- `AWS_*` and `S3_BUCKET` for check-in photos

Point your domain DNS `A` record to the VPS public IP before starting Caddy.

## Start the stack

```bash
docker compose --env-file .env.prod -f docker-compose.prod.yml up -d --build
```

## Update the app

```bash
git pull
docker compose --env-file .env.prod -f docker-compose.prod.yml up -d --build
```

## Useful commands

View container status:

```bash
docker compose --env-file .env.prod -f docker-compose.prod.yml ps
```

View logs:

```bash
docker compose --env-file .env.prod -f docker-compose.prod.yml logs -f
```

Restart after env changes:

```bash
docker compose --env-file .env.prod -f docker-compose.prod.yml up -d
```

## Production notes

- Only Caddy exposes public ports `80` and `443`
- The frontend uses same-origin API calls in production, so one domain is enough
- Postgres is intentionally not published to the internet
- `checkin-service` keeps filesystem storage support, but production is expected to use `STORAGE_PROVIDER=s3`
- Rotate any previously exposed AWS or OpenAI credentials before first deploy
