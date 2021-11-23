include:
  - modules.web.httpd.install
  - modules.database.mysql.install
  - modules.appcation.php8.install
 
/usr/local/apache/conf/httpd.conf:
  file.managed:
    - source: salt://modules/lamp/files/httpd.conf
    - user: root
    - group: root
    - mode: '0644'
 
 /usr/local/apache/conf/extra/httpd-vhosts.conf:
  file.managed:
    - source: salt://modules/lamp/files/httpd-vhosts.conf:
    - user: root
    - group: root
    - mode: '0644'
    - template: jinja
