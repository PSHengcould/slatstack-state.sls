#/bin/bash
/usr/local//mysql/bin/mysql -e " change master to 
	master_host=192.168.219.141,
	master_port=3306,
	master_user=heng,
	master_password=heng,
	master_log_file=mysql_bin.000005,
	master_log_pos=1311;"

/usr/local//mysql/bin/mysql -e "flush privileges;"
/usr/local//mysql/bin/mysql -e "start slave;"
/usr/local//mysql/bin/mysql -e "flush privileges;"

