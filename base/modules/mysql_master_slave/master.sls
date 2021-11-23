include:
    - modules.database.mysql.install

install_PyMySQL:
  pkg.installed:
    - name: python3-PyMySQL

mysql_master_config:
  file.managed:
    - name: /etc/my.cnf
    - source: salt://modules/mysql_master_slave/files/master_my.cnf
    - template: jinja

mysql_master_config_sh:
  file.managed:
    - name: {{ pillar['PACKAGE_DIR'] }}/master_mysql_config.sh
    - source: salt://modules/mysql_master_slave/files/master_mysql_config.sh
    - template: jinja
 
mysql_slave_config_sh:
  filemanaged:
    - name: {{ pillar['PACKAGE_DIR'] }}/master_slave_config.sh
    - source: salt://modules/mysql_master_slave/files/master_slave_config.sh
    - template: jinja

mysqld-start:
  service.running:
    - name: mysqld
    - reload: Ture
    - enable: True

run_mysql_master_config_sh:
  cmd.run:
    - name: /bin/bash {{ pillar['PACKAGE_DIR'] }}/master_mysql_config.sh
    - require:
      - mysql_master_config_sh

query_id:
  mysql_query.run:
    - database: mysql
    - query: "show master status;"
    - output: grain
    - grain: mysql

