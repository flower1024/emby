# emby
emby mediaserver

# docker-compose
```
    emby:
        image: flower1024/emby
        restart: unless-stopped
        read_only: true
        ports:
            - 8096:8086/tcp
        volumes:
            - /srv/volumes/emby/config:/config
            - /srv/volumes/emby/music:/data/music
            - /srv/volumes/emby/movies:/data/movies
            - /srv/volumes/emby/transcode:/transcode
            - /srv/volumes/emby/vc:/opt/vc/lib
            - /srv/volumes/emby/tmp:/tmp
        devices:
            - /dev/dri:/dev/dri
```
v1
