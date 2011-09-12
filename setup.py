from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

cython_modules = [
    Extension("openssl.crypto.rsa", ["openssl/crypto/rsa.pyx"], libraries=["crypto"]),
    Extension("openssl.crypto.bn", ["openssl/crypto/bn.pyx"], libraries=["crypto"]),
]

setup(
    name = "OpenSSL-cython",
    description = "Cython bindings for OpenSSL",

    classifiers = [
        'Development Status :: 2 - Pre-Alpha',
        'Intended Audience :: Developers',
        'Programming Language :: Cython',
        'Topic :: Security :: Cryptography',
    ],

    packages=['openssl', 'openssl.crypto'],
    cmdclass = {'build_ext': build_ext},
    ext_modules = cython_modules,
)
