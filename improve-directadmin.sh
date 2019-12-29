#!/bin/sh
/usr/local/directadmin/directadmin set enable_ssl_sni 1
/usr/local/directadmin/directadmin set ssl_redirect_host $(hostname -f)
/usr/local/directadmin/directadmin set force_hostname $(hostname -f)
/usr/local/directadmin/directadmin set carootcert /usr/local/directadmin/conf/carootcert.pem
/usr/local/directadmin/directadmin set letsencrypt_renewal_notice_to_admins 0
/usr/local/directadmin/scripts/letsencrypt.sh request $(hostname -f) 4096
/usr/local/directadmin/directadmin set ssl 1
/usr/local/directadmin/directadmin set hide_outlook 1
/usr/local/directadmin/directadmin set dkim 1
/usr/local/directadmin/scripts/dkim_create.sh $(hostname -f)
/usr/local/directadmin/directadmin set one_click_pma_login 1
service directadmin restart
/usr/local/directadmin/custombuild/build update
/usr/local/directadmin/custombuild/build phpmyadmin
/usr/local/directadmin/directadmin set hide_brute_force_notifications 1
service directadmin restart
# Enable IP Blocking
yum -y install iptables-services
systemctl enable iptables
cd /usr/libexec/iptables
mv iptables.init iptables.init.backup
wget -O iptables.init http://files.directadmin.com/services/all/block_ips/2.2/iptables
chmod 755 iptables.init
chattr +i iptables.init
systemctl start iptables
cd /usr/local/directadmin/scripts/custom
wget -O block_ip.sh http://files.directadmin.com/services/all/block_ips/2.2/block_ip.sh
wget -O show_blocked_ips.sh http://files.directadmin.com/services/all/block_ips/2.2/show_blocked_ips.sh
wget -O unblock_ip.sh http://files.directadmin.com/services/all/block_ips/2.2/unblock_ip.sh
chmod 700 block_ip.sh show_blocked_ips.sh unblock_ip.sh
touch /root/blocked_ips.txt
touch /root/exempt_ips.txt
cd /usr/local/directadmin/scripts/custom
wget -O brute_force_notice_ip.sh http://files.directadmin.com/services/all/block_ips/2.2/brute_force_notice_ip.sh
chmod 700 brute_force_notice_ip.sh
