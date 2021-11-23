#/bin/bash
{{ pillar['INSTALL_DIR'] }}/mysql/bin/mysql -e "use mysql; 
	update user  set host = '%' where user = 'root';"
{{ pillar['INSTALL_DIR'] }}/mysql/bin/mysql -e "FLUSH  PRIVILEGES;"
{{ pillar['INSTALL_DIR'] }}/mysql/bin/mysql -e "grant replication slave on *.* to '{{ pillar['MYSQL_EMPPOWER_USER'] }}'@'{{ pillar['MYSQL_EMPPOWER_IP'] }}' identified by '{{ pillar['MYSQL_EMPPOWER_PASSWD'] }}';"
{{ pillar['INSTALL_DIR'] }}/mysql/bin/mysql -e "FLUSH  PRIVILEGES;"
