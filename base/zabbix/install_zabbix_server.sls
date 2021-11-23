install-dep-zabbix:
  pkg.installed:
    - pkgs:
      - net-snmp-devel
      - libevent-devel

extract-zabbix:
  archive.extracted:
    - name: {{ pillar['PACKAGE_DIR'] }}
    - source: salt://zabbix/files/zabbix-5.4.4.tar.gz
    - user: root
    - group: root


#执行脚本
install-zabbix:
  file.managed:
    - name: {{ pillar['PACKAGE_DIR'] }}/install_zabbix.sh
    - source: salt://zabbix/files/install.sh
    - user: root
    - group: root
    - mode: 744
    - template: jinja
    - unless: test -d /usr/local/etc/zabbix
  cmd.run:
    - name: /bin/bash {{ pillar['PACKAGE_DIR'] }}/install_zabbix.sh
    - unless: test -d /usr/local/etc/zabbix


file_zabbix_ui_config:
  file.recurse:
    - name: {{ pillar['INSTALL_DIR'] }}/apache/htdocs/ui
    - source: salt://zabbix/files/ui
    - user: apache
    - group: apache
    - template: jinja
    - include_empty: Ture
    

file-zabbix-config:
  file.managed:
    - names:
      - /etc/init.d/php-fpm:
        - source: salt://zabbix/files/php-fpm
        - user: root
        - group: root
        - mode: 775   
      - /etc/php.ini:
        - source: salt://zabbix/files/php.ini  
      - {{ pillar['INSTALL_DIR'] }}/apache/conf/extra/httpd-vhosts.conf:
        - source: salt://zabbix/files/httpd-vhosts.conf
      - /usr/local/etc/zabbix_server.conf:
        - source: salt://zabbix/files/zabbix_server.conf
 
# 执行脚本
Configure-zabbix:
  file.managed:
    - name: {{ pillar['PACKAGE_DIR'] }}/Configure_zabbix_server.sh
    - source: salt://zabbix/files/Configure_zabbix_server.sh
    - user: root
    - group: root
    - mode: 744
    - template: jinja
    - unless: test -d {{ pillar['INSTALL_DIR'] }}/apache/htdocs/ui
  cmd.run:
    - name: /bin/bash {{ pillar['PACKAGE_DIR'] }}/Configure_zabbix_server.sh
    - unless: test -d {{ pillar['INSTALL_DIR'] }}/apache/htdocs/ui


