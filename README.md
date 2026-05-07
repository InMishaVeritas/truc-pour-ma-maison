# Repo du Homelab
Conf de mon nas maison

## Decisions d'architecture
1. Portainer pour la surcouche UI aux docker composes qu'on run
2. Plex > jellyfin ( dû a ma tele Hisense exotique) : netflix du pirate
3. Immmich : index photo et galerie photos maison: ça a l'air bien
4. adguard : pour bloquer les publicités et les trackers, mais surtout pour jouer avec le réseau à la maison
5. DHCP on adguard du à la box Bouygues : 
6. Ip fixe du nas 192.168.1.12
7. tailscale 

## Comment on déploie:
1. push sur main
2. tag commit en release
3. scp via tailscale sur le nas
4. docker compose up -d

## Les secrets

| Secret | utilisé par        | Description |
|---|--------------------|---|
| `TS_OAUTH_CLIENT_ID` | tout les workflows | Tailscale OAuth client ID for `tag:ci` |
| `TS_OAUTH_SECRET` | tout les workflows | Tailscale OAuth client secret |
| `NAS_SSH_PRIVATE_KEY` | tout les workflows      | SSH private key to scp files to the NAS |
| `PORTAINER_TOKEN` | tout les workflows      | Portainer access token for `ci-bot` user |
| `ADGUARD_ADMIN_PASSWORD_HASH` | adguard            | bcrypt hash of AdGuard admin password |

## Required GitHub Variables (non-secret)

| Variable | Value | Description |
|---|---|---|
| `NAS_TAILSCALE_HOSTNAME` | `nas-maison` | Tailscale hostname of the NAS |
| `NAS_SSH_USER` | `mishanh` | SSH user on the NAS |
| `PORTAINER_URL` | `http://nas-maison:9000` | Portainer base URL via Tailscale |
| `PORTAINER_ENDPOINT_ID` | `3` | Portainer endpoint (environment) ID |

## Si on casse un truck

???
