# Qbittorrent mod

This repository defines a docker image based on qbittorrent-nox with some additions:
- Jackett
- ClamAV

### Required environment variables

When running the container the following environment variables must be provided:
- `DEST_EMAIL_ADDRESS`: Email to send the infected files notifications to.
- `ORIGIN_EMAIL_AUTHUSER`: Email that will send the notifications if ClamAV detects an infected file.
- `ORIGIN_EMAIL_AUTHPASS`: The application password for the email sending the notifications.
- `WEB_UI_PASSWORD`: qBittorrent web UI password to access the app.
- `QUARANTINE_DIR`: Directory path to move the detected infected files to.

### Run the container

```shell
sudo nerdctl run -d --name qbittorrent -p 8080:8080 \
    -e DEST_EMAIL_ADDRESS="[REDACTED]" \
    -e ORIGIN_EMAIL_AUTHUSER="[REDACTED]" \
    -e ORIGIN_EMAIL_AUTHPASS="[REDACTED]" \
    -e QUARANTINE_DIR="/quarantine" \
    -v /dev/net/tun:/dev/net/tun \
    --cap-add=NET_ADMIN \
    msd117/qbittorrent:latest
```
