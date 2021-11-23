#!/bin/bash
{{ pillar['INSTALL_DIR'] }}/mysql/bin/mysql -e "create database zabbix character set utf8 collate utf8_bin;"
{{ pillar['INSTALL_DIR'] }}/mysql/bin/mysql -e "create user 'zabbix'@'localhost' identified by 'zabbix123!';"
{{ pillar['INSTALL_DIR'] }}/mysql/bin/mysql -e "grant all privileges on zabbix.* to 'zabbix'@'localhost';"
cd {{ pillar['PACKAGE_DIR'] }}/zabbix-5.4.4/database/mysql/
mysql -uzabbix -zabbix123! zabbix < schema.sql 
mysql -uzabbix -zabbix123! zabbix < images.sql
mysql -uzabbix -zabbix123! zabbix < data.sql


