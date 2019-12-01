# docker-bind-webmin
Dockerized BIND DNS Server with Webmin for DNS Administration

## How to Run

```
docker-compose up
```

OR

```
docker run -d --restart=always --name bindwebmin \
-p 53:53 -p 53:53/udp -p 10000:10000 \
-v /home/bindwebmin:/data \
-e ROOT_PASSWORD=password \
-e WEBMIN_ENABLED=true \
fffaraz/bindwebmin
```
