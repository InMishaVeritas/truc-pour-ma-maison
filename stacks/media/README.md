# Media stack

Media management and streaming.

## Services

| Service | Purpose | Status |
|---------|---------|--------|
| Plex | Media streaming | existing (manual deploy) |
| (future) Sonarr/Radarr/Prowlarr | Media library automation | planned |
| (future) Bazarr | Subtitle automation | planned |

## Migration plan for Plex

The current Plex container was deployed manually via Portainer. To bring it into this repo:

1. Run `docker inspect plex` and capture image, env, volumes, ports
2. Generate a draft compose: `docker run --rm -v /var/run/docker.sock:/var/run/docker.sock ghcr.io/red5d/docker-autocompose plex`
3. Clean up: secrets to `.env`, named volumes, proper network
4. Test redeploy in Portainer Stacks → Repository
5. Once validated, remove the original manual container

Existing Plex data must remain intact during the migration: bind-mount the same paths.
