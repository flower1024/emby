FROM flower1024/ghost as buildstage

ENV DEBIAN_FRONTEND="noninteractive" 

#https://github.com/MediaBrowser/Emby.Releases/releases/download/4.5.2.0/emby-server-rpm_4.5.2.0_x86_64.rpm

RUN apt-get install -y -q cpio jq rpm2cpio && \
    mkdir -p /app/emby && \
	EMBY_RELEASE=$(curl -s https://api.github.com/repos/MediaBrowser/Emby.Releases/releases/latest | jq -r '. | .tag_name') && \
    echo "Downloading https://github.com/MediaBrowser/Emby.Releases/releases/download/${EMBY_RELEASE}/emby-server-rpm_${EMBY_RELEASE}_x86_64.rpm" && \
    curl -o /tmp/emby.rpm -L "https://github.com/MediaBrowser/Emby.Releases/releases/download/${EMBY_RELEASE}/emby-server-rpm_${EMBY_RELEASE}_x86_64.rpm" && \
    cd /tmp && \
    rpm2cpio emby.rpm | cpio -i --make-directories && \
    mv -t /app/emby/ /tmp/opt/emby-server/system/* /tmp/opt/emby-server/lib/samba/* /tmp/opt/emby-server/lib/* /tmp/opt/emby-server/bin/ff* /tmp/opt/emby-server/etc

FROM flower1024/ghost

ARG UID=82
ARG GID=82

COPY /app /app/
COPY --from=buildstage /app/emby /app/emby

RUN apt-get install -y -q mesa-va-drivers && \
    chmod ugo+x -R /app/init && \
    chmod ugo+x -R /app/start && \
    USER emby ${UID} emby ${GID} && \
    mkdir /data && \
    mkdir /config && \
    mkdir /transcode && \
    chown emby:emby /data /config /transcode

EXPOSE 8096

VOLUME [ "/config", "/transcode" ]