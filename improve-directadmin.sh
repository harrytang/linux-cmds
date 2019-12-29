#!/bin/sh
/usr/local/directadmin/directadmin set enable_ssl_sni 1
/usr/local/directadmin/directadmin set ssl_redirect_host $(hostname -f)
/usr/local/directadmin/directadmin set force_hostname $(hostname -f)
/usr/local/directadmin/directadmin set carootcert /usr/local/directadmin/conf/carootcert.pem
/usr/local/directadmin/directadmin set letsencrypt_renewal_notice_to_admins 0
/usr/local/directadmin/scripts/letsencrypt.sh $(hostname -f) 4096
/usr/local/directadmin/directadmin set ssl 1
