#!/usr/bin/expect
spawn scp -rp {{ pillar['MYSQL_MASTER_IP']}}:/tmp/master_mysql_config.sh {{ pillar['PACKAGE_DIR'] }} 
expect {
    "yes/no" { send "yes\n";exp_continue }
    "password: " { send "root\n" }
}
expect eof
