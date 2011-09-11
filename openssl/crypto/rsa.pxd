from bn cimport BIGNUM

cdef extern from "openssl/rsa.h":
    ctypedef struct _RSA "RSA":
        BIGNUM *n
        BIGNUM *e
        BIGNUM *d
        BIGNUM *p
        BIGNUM *q
        BIGNUM *dmp1
        BIGNUM *dmq1
        BIGNUM *iqmp

    _RSA * RSA_new()
    void RSA_free(_RSA *rsa)

    int RSA_size(_RSA *rsa)

    int RSA_sign(int type, unsigned char *m, unsigned int m_len,
             unsigned char *sigret, unsigned int *siglen, _RSA *rsa)
    int RSA_verify(int type, unsigned char *m, unsigned int m_len,
               unsigned char *sigbuf, unsigned int siglen, _RSA *rsa)
