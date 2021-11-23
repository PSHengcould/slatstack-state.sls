#!/bin/bash
{{ pillar['INSTALL_DIR'] }}/mysql/bin/mysql -e "set password=password( {{ pillar['MYSQL_PASSWORD'] }} );" &> /dev/null
