cimport bn as BN
cimport obj as OBJ

cdef get_bn(BN.BIGNUM *bn):
    if bn == NULL:
        return None
    else:
        return BN.pylong_from_bn(bn)

cdef set_bn(BN.BIGNUM ** bn, object value):
    if value is None:
        BN.BN_clear_free(bn[0])
        bn[0] = NULL
    else:
        BN.pylong_as_bn(value, bn)

cdef class RSA:
    cdef _RSA * rsa

    _types = {
        'sha1': OBJ.NID_sha1,
        'sha256': OBJ.NID_sha256,
        'sha384': OBJ.NID_sha384,
        'sha512': OBJ.NID_sha512,
    }

    def __cinit__(self):
        self.rsa = RSA_new()
        if self.rsa == NULL:
            raise MemoryError

    def __dealloc__(self):
        RSA_free(self.rsa)

    def __init__(self, n=None, e=None, d=None,
                       p=None, q=None,
                       dmp1=None, dmq1=None, iqmp=None):
        if n is not None: self.n = n
        if e is not None: self.e = e
        if d is not None: self.d = d
        if p is not None: self.p = p
        if q is not None: self.q = q
        if dmp1 is not None: self.dmp1 = dmp1
        if dmq1 is not None: self.dmq1 = dmq1
        if iqmp is not None: self.iqmp = iqmp

    def sign(self, bytes msg, str alg):
        cdef int nid = self._types[alg]
        cdef bytes sig = b'\x00' * RSA_size(self.rsa)
        cdef unsigned int siglen = 0
        if RSA_sign(nid, msg, len(msg), sig, &siglen, self.rsa) == 0:
            raise RuntimeError
        sig = sig[:siglen]
        return sig

    def verify(self, bytes msg, bytes sig, str alg):
        cdef int nid = self._types[alg]
        return bool(RSA_verify(nid, msg, len(msg), sig, len(sig), self.rsa))

    # repetitive property definitions
    property n:
        def __get__(self):
            return get_bn(self.rsa.n)
        def __set__(self, value):
            set_bn(&self.rsa.n, value)

    property e:
        def __get__(self):
            return get_bn(self.rsa.e)
        def __set__(self, value):
            set_bn(&self.rsa.e, value)

    property d:
        def __get__(self):
            return get_bn(self.rsa.d)
        def __set__(self, value):
            set_bn(&self.rsa.d, value)

    property p:
        def __get__(self):
            return get_bn(self.rsa.p)
        def __set__(self, value):
            set_bn(&self.rsa.p, value)

    property q:
        def __get__(self):
            return get_bn(self.rsa.q)
        def __set__(self, value):
            set_bn(&self.rsa.q, value)

    property dmp1:
        def __get__(self):
            return get_bn(self.rsa.dmp1)
        def __set__(self, value):
            set_bn(&self.rsa.dmp1, value)

    property dmq1:
        def __get__(self):
            return get_bn(self.rsa.dmq1)
        def __set__(self, value):
            set_bn(&self.rsa.dmq1, value)

    property iqmp:
        def __get__(self):
            return get_bn(self.rsa.iqmp)
        def __set__(self, value):
            set_bn(&self.rsa.iqmp, value)
