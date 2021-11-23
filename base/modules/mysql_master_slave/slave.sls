include:
    - modules.database.mysql.install

install_expect:
    pkg.install:
      - pkgs:
        - tcl
        - expect

expect_scp:
  file.managed:
    - name: {{ pillar['PACKAGE_DIR'] }}/scp.sh
    - source: salt://modules/mysql_master_slave/files/scp.sh
    - template: jinja
  
run_scp:
  cmd.run:
    - name: /usr/bin/expect {{ pillar['PACKAGE_DIR'] }}/scp.sh
    - unless: test -d {{ pillar['PACKAGE_DIR'] }}/slave_mysql_config.sh


mysql_slave_config:
  file.managed:
    - name: /etc/my.cnf
    - source: salt://modules/mysql_master_slave/files/slave_my.cnf
    - template: jinja

mysqld-start:
  service.running:
    - name: mysqld
    - reload: Ture
    - enable: True


mysql_slave_config_sh:
  file.managed:
    - name: {{ pillar['PACKAGE_DIR'] }}/slave_mysql_config.sh
    - source: salt://modules/mysql_master_slave/files/slave_mysql_config_new.sh
    
run_mysql_slave_config_sh:
  cmd.run:
    - name: /bin/bash {{ pillar['PACKAGE_DIR'] }}/slave_mysql_config.sh
    - watch:
      - mysql_slave_config_sh


