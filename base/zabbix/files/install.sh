#!/bin/bash
cd {{ pillar['PACKAGE_DIR'] }}/zabbix-5.4.4 && \

./configure --enable-server --enable-agent --with-mysql --enable-ipv6 --with-net-snmp --with-libcurl --with-libxml2 && \
make install

