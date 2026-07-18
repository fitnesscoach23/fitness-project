# Fitness Project

Full-stack fitness coaching platform with an Angular frontend, Spring Boot microservices, PostgreSQL, and Docker Compose.

## Documentation

- Local setup on a new laptop: [SETUP.md](SETUP.md)
- Production deployment: [DEPLOYMENT.md](DEPLOYMENT.md)

## Database Backup And Restore

Database backups are kept in `db-backups/`.

Create a full PostgreSQL backup from the local Docker container:

```bash
docker exec fitness-postgres pg_dumpall -U postgres > db-backups/fitness_db_backup-YYYY-MM-DD.sql
```

Restore the July 18, 2026 backup:

```bash
docker exec -i fitness-postgres psql -U postgres < db-backups/fitness_db_backup-2026-07-18.sql
```

Make sure the `fitness-postgres` container is running before creating or restoring a backup.
