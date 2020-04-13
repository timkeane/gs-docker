FROM tomcat:9-jre8

ENV VERSION=2.17
ENV PLUGINS="wps,vectortiles,monitor"
ENV COMMUNITY="backup-restore"
 
COPY get-gs.sh .

RUN ./get-gs.sh ${VERSION} ${PLUGINS} ${COMMUNITY} \
  && cp -r ./.geoserver /usr/local/tomcat/webapps/geoserver \
  && rm -rf ./.geoserver \
  && rm get-gs.sh
