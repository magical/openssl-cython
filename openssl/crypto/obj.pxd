cdef extern from "openssl/obj_mac.h":
    enum:
        NID_sha1
        NID_sha256
        NID_sha384
        NID_sha512
