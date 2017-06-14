FROM python:2.7-alpine
MAINTAINER "Plone Community" http://community.plone.org

RUN addgroup -g 500 plone \
 && adduser -S -D -G plone -u 500 plone \
 && mkdir -p /plone/zeoserver /data/filestorage /data/blobstorage

COPY buildout.cfg /plone/zeoserver/

ENV ZC_BUILDOUT 2.5.0
ENV SETUPTOOLS  18.5

RUN apk add --no-cache --virtual .build-deps \
    gcc \
    libc-dev \
 && pip install zc.buildout==$ZC_BUILDOUT setuptools==$SETUPTOOLS \
 && cd /plone/zeoserver \
 && buildout -c buildout.cfg \
 && chown -R plone:plone /plone /data \
 && apk del .build-deps \
 && apk add --no-cache --virtual .run-deps bash tzdata \
 && find /plone \( -type f -a -name '*.pyc' -o -name '*.pyo' \) -exec rm -rf '{}' +

VOLUME /data

COPY docker-entrypoint.sh /

EXPOSE 8100
USER plone
WORKDIR /plone/zeoserver

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["start"]
