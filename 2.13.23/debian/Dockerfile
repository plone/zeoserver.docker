FROM python:2.7-slim
MAINTAINER "Plone Community" http://community.plone.org

RUN useradd --system -U -u 500 plone \
 && mkdir -p /plone/zeoserver /data/filestorage /data/blobstorage

COPY buildout.cfg /plone/zeoserver/

ENV ZC_BUILDOUT 2.5.0
ENV SETUPTOOLS  18.5

RUN buildDeps="gcc libc6-dev" \
 && apt-get update \
 && apt-get install -y --no-install-recommends $buildDeps \
 && pip install zc.buildout==$ZC_BUILDOUT setuptools==$SETUPTOOLS \
 && cd /plone/zeoserver \
 && buildout -c buildout.cfg \
 && chown -R plone:plone /plone /data \
 && apt-get purge -y --auto-remove $buildDeps \
 && rm -rf /var/lib/apt/lists/* \
 && find /plone \( -type f -a -name '*.pyc' -o -name '*.pyo' \) -exec rm -rf '{}' +

VOLUME /data

COPY docker-entrypoint.sh /

EXPOSE 8100
USER plone
WORKDIR /plone/zeoserver

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["start"]
