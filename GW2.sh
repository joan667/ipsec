#!/usr/sbin/setkey -f

flush;      
spdflush;   

add 10.0.3.2 10.0.0.1 esp 0x1565786 -m tunnel \
    -E aes-cbc 0xfedcba9876543210fedcba9876543210 \
    -A hmac-sha1 0x10fedcba9876543210fedcba9876543210fedcba;

add 10.0.0.1 10.0.3.2 esp 0x1565785 -m tunnel \
    -E aes-cbc 0x0123456789abcdef0123456789abcdef \
    -A hmac-sha1 0xabcdef0123456789abcdef0123456789abcdef01;

spdadd 10.0.3.2 10.0.0.1 any -P out ipsec \
    esp/tunnel/10.0.3.2-10.0.0.1/require;

spdadd 10.0.0.1 10.0.3.2 any -P in  ipsec \
    esp/tunnel/10.0.0.1-10.0.3.2/require;
