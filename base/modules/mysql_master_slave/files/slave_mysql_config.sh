#/bin/bash
{{ pillar['INSTALL_DIR'] }}/mysql/bin/mysql -e " change master to 
	master_host={{ pillar['MYSQL_MASTER_IP'] }},
	master_port={{ pillar['MYSQL_MASTER_PORT'] }},
	master_user={{ pillar['MYSQL_EMPPOWER_USER'] }},
	master_password={{pillar['MYSQL_EMPPOWER_PASSWD'] }},
	master_log_file={{ grains['mysql']['results'][0]['File'] }},
	master_log_pos={{ grains['mysql']['results'][0]['Position'] }};"

{{ pillar['INSTALL_DIR'] }}/mysql/bin/mysql -e "flush privileges;"
{{ pillar['INSTALL_DIR'] }}/mysql/bin/mysql -e "start slave;"
{{ pillar['INSTALL_DIR'] }}/mysql/bin/mysql -e "flush privileges;"

