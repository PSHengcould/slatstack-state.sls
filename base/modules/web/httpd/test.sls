#执行脚本
test-sh:
  cmd.script:
    - source: salt://modules/web/httpd/files/test.sh
    - unless: test -d {{ pillar['INSTALL_DIR'] }}/apache

install:
  file.managed:
    - name: {{pillar['PACKAGE_DIR'] }}/test.sh
    - source: salt://modules/web/httpd/files/test.sh
    - user: root
    - group: root
    - mode: 744
    - template: jinja
    - unless: test -d {{ pillar['INSTALL_DIR'] }}/apache
  cmd.run:
    - name: /bin/bash {{pillar['PACKAGE_DIR'] }}/test.sh }}    
    - unless: test -d {{ pillar['INSTALL_DIR'] }}/apache
