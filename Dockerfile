FROM tomcat:9-jre8

ARG VERSION=2.17
ARG PLUGINS="vectortiles,monitor"
ARG COMMUNITY="backup-restore"
ARG CONSOLE_DISABLED=true

RUN echo VERSION=${VERSION} \
  && echo PLUGINS=${PLUGINS} \
  && echo COMMUNITY=${COMMUNITY} \
  && echo CONSOLE_DISABLED=${CONSOLE_DISABLED}

ENV GEOSERVER_DATA_DIR=/data_dir
ENV CATALINA_OPTS="-DGEOSERVER_CONSOLE_DISABLED=${CONSOLE_DISABLED} ${CATALINA_OPTS}"

COPY ./.data_dir /data_dir
COPY get-gs.sh .

RUN ./get-gs.sh ${VERSION} ${PLUGINS} ${COMMUNITY} \
  && cp -r ./.geoserver /usr/local/tomcat/webapps/geoserver \
  && rm -rf ./.geoserver \
  && rm get-gs.sh
