include:
  - modules.web.nginx.install
  - modules.database.mysql.install
  - modules.application.php.install

{{ pillar['INSTALL_DIR'] }}/nginx/conf/nginx.conf:
  file.managed:
    - source: salt://modules/lnmp/files/nginx.conf
    - user: nginx
    - group: nginx
    - mode: 644
    - template: jinja

{{ pillar['INSTALL_DIR'] }}/nginx/html/index.php:
  file.managed:
    - source: salt://modules/lnmp/files/index.php
    - user: nginx
    - group: nginx
    - mode: 644
