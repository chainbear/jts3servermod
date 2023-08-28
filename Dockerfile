FROM alpine:3

ENV JTS3_SERVER_MOD_VERSION=6.5.7
RUN echo "## Downloading ${JTS3_SERVER_MOD_VERSION} ##" && \
  apk add --no-cache libarchive-tools && \
  wget -qO- "https://www.stefan1200.de/downloads/JTS3ServerMod_${JTS3_SERVER_MOD_VERSION}.zip" | bsdtar -xf- && \
  rm -R /JTS3ServerMod/JTS3ServerMod-Windows* /JTS3ServerMod/documents/ /JTS3ServerMod/tools/


FROM cgr.dev/chainguard/jre:latest
ENV JTS3_SERVER_MOD_VERSION=6.5.7

WORKDIR /JTS3ServerMod
COPY --from=0 /JTS3ServerMod .
VOLUME /JTS3ServerMod/config /JTS3ServerMod/plugins /JTS3ServerMod/log

CMD ["java", "-jar", "JTS3ServerMod.jar", "-log", "log/JTS3ServerMod_InstanceManager.log", "-mx30M"]

ARG VCS_REF
ARG BUILD_DATE
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.name="JTS3ServerMod" \
      org.label-schema.version="${JTS3_SERVER_MOD_VERSION}" \
      org.label-schema.description="JTS3ServerMod is a Teamspeak 3 server bot written in Java language" \
      org.label-schema.url="https://www.stefan1200.de/forum/index.php?topic=2.0" \
      org.label-schema.usage="https://www.stefan1200.de/documentation/jts3servermod/readme.html" \
      org.label-schema.vcs-url="https://gitlab.com/linus9000/jts3servermod" \
      org.label-schema.vcs-ref=${VCS_REF}
