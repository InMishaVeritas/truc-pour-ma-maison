# Infra stack

Cross-cutting services: monitoring, backups, photo management.

## Services

| Service | Purpose | Memory (approx) | Phase |
|---------|---------|-----------------|-------|
| Uptime Kuma | Service monitoring | ~150 MB | Month 1 (pilot) |
| Immich | Self-hosted photos (replaces Google Photos) | ~1.5-2 GB | Month 2 |
| Restic | Encrypted backups to off-site storage | ~50 MB | Month 3 |
| Dozzle | Web log viewer for Docker | ~30 MB | optional |

## Deployment order

The infra stack is intentionally split per-phase rather than as one monolithic compose:

- `uptime-kuma/docker-compose.yml` — deploy first, used to monitor everything else
- `immich/docker-compose.yml` — deploy in month 2
- `restic/docker-compose.yml` — deploy in month 3 once stack is stable

This avoids deploying everything at once and makes it easier to roll back individual services.
