Using this image
================

1. Simple usage
---------------
::

  $ docker run -p 8100:8100 plone/zeoserver

Connect to ZEO server::

  $ telnet localhost 8100

2. Adding ZEO clients
---------------------

Start ZEO server::

  $ docker run --name zeo plone/zeoserver

Start ZEO client::

  $ docker run --link=zeo -e ZEO_ADDRESS=zeo:8100 -p 8080:8080 plone/plone

Test it works at http://localhost:8080

3. See also
-----------

* `More examples <https://github.com/plone/plone.docker/blob/master/docs/usage.rst>`_
