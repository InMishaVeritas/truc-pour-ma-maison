# Famille stack

Services for the household: password management, ad blocking, document archive.

## Services

| Service | Purpose | Port (host) | Memory (approx) |
|---------|---------|-------------|-----------------|
| Vaultwarden | Password manager (Bitwarden-compatible) | 8080 | ~100 MB |
| AdGuard Home | DNS-level ad/tracker blocking | 53, 3000 | ~80 MB |
| Paperless-ngx | Document archive with OCR | 8000 | ~500 MB |

Compose file to be added in a follow-up commit.

## Deployment (once compose is added)

Add as a stack in Portainer:
- Repository: this repo
- Compose path: `stacks/famille/docker-compose.yml`
- Env: copy from `.env.example`, fill in real values

## Post-deploy checklist

### Vaultwarden
- [ ] Access `http://nas:8080`, create master account
- [ ] Disable open registration in admin panel after first user
- [ ] Install Bitwarden apps (mobile, browser) pointing at the Vaultwarden URL
- [ ] Invite family via organization

### AdGuard Home
- [ ] Initial setup wizard at `http://nas:3000`
- [ ] Configure upstream DNS (e.g. 1.1.1.1, 9.9.9.9)
- [ ] Add blocklists (defaults are fine to start)
- [ ] Configure router (Bbox) to use NAS IP as primary DNS
- [ ] Test: `dig doubleclick.net @<nas-ip>` should return `0.0.0.0`

### Paperless-ngx
- [ ] Login with `PAPERLESS_ADMIN_USER`
- [ ] Configure consume folder watching
- [ ] Add tags, correspondents, document types
- [ ] Scan first batch of admin documents
- [ ] Set up mobile app via Tailscale
