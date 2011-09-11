This project aims to provide a complete set of [Python][] bindings for [OpenSSL][] using [Cython][], because all the existing bindings are either [incomplete][pyOpenSSL] or [awful][M2Crypto].

**Current status**: not even close.

[Python]: http://python.org/
[Cython]: http://cython.org/
[OpenSSL]: http://openssl.org/
[pyOpenSSL]: http://pypi.python.org/pypi/pyOpenSSL
[M2Crypto]: http://pypi.python.org/pypi/M2Crypto

Building
--------

First make sure you have [Cython][] and [OpenSSL][] installed. Then run:

    python2 setup.py build

Or, to put the compiled modules alongside the source code instead of in the `build` directory:

    python2 setup.py build_ext --inplace
