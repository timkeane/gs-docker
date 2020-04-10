FROM tomcat:9-jre8

ENV VERSION=2.17
ENV PLUGINS="wps,vectortiles,monitor"

RUN pwd

COPY get-gs.sh .

RUN ./get-gs.sh ${VERSION} ${PLUGINS} \
  && cp -r ./.geoserver /usr/local/tomcat/webapps/geoserver \
  && rm -rf ./.geoserver \
  && rm get-gs.sh
