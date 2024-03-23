docker run -d \
  --name homeassistant \
  --privileged \
  --restart=unless-stopped \
  -e TZ=America/Vancouver \
  -v ~/homeassistant:/config \
  --network=host \
  ghcr.io/home-assistant/home-assistant:stable
