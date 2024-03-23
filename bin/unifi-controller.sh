echo 'Starting unifi controller docker container'
docker run --restart always \
 --privileged \
 --net=host \
 --ulimit nofile=122880:122880 \
 -p 8080:8080 \
 -p 8443:8443 \
 -p 6789:6789 \
 -p 27117:27117 \
 -p 3478:3478/udp \
 -p 10001:10001/udp \
 -e TZ='America/Vancouver' \
 -v ~/unifi:/unifi \
 -d \
 --name unifi jacobalberty/unifi:latest
