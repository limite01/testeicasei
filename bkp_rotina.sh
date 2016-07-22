#/bin/bash

#DATA DO ARQUIVO

DATA=`date +%F`

#DIRETORIOS

ROOT_DIR=/backup
TMP_ROOT_DIR=/backup/tmp
BKP_CONF_APACHE=/etc/apache2
BKP_CONF_MUNIN=/etc/munin
BKP_CONF_FAIL2BAN=/etc/fail2ban
BKP_WORDPRESS=/sites/wordpress
BKP_CONF_FIREWALL=/etc/init.d/start_firewall.sh
BKP_SCRIPTS=/root/scripts


#COMANDOS 

MYSQLDUMP=/usr/bin/mysqldump
TAR=/bin/tar
RM=/bin/rm
FIND=/usr/bin/find
CHMOD=/bin/chmod

#DUMP BASE DE DADOS

$MYSQLDUMP -u userwp -p123456 dbwordpress > $TMP_ROOT_DIR/bkp_dbwordpress.sql

#COMPACTAR ARQUIVOS

$TAR -czf $ROOT_DIR/bkp_confs-$DATA.tar.gz $TMP_ROOT_DIR/bkp_dbwordpress.sql $BKP_CONF_APACHE $BKP_CONF_MUNIN $BKP_CONF_FAIL2BAN $BKP_WORDPRESS $BKP_CONF_FIREWALL $BKP_SCRIPTS

$RM $TMP_ROOT_DIR/bkp_dbwordpress.sql

$CHMOD 600 $ROOT_DIR/bkp_confs-$DATA.tar.gz

#APAGA ARQUIVOS COM MAIS DE 5 DIAS

$FIND $ROOT_DIR -ctime +5 -exec rm -rf {} \;
