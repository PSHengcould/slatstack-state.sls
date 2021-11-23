#  安装软件
"Development Tools":
  pkg.group_installed
 
# epel-release 
httpd-dep-epel-release:
  pkg.installed:
    - name: epel-release
 
 
httpd-dep:
  pkg.installed:
    - pkgs:
      - gcc
      - gcc-c++
      - make
      - pcre
      - pcre-devel
      - expat-devel
      - openssl
      - openssl-devel
      - gd-devel
      - libtool
      - apr
      - apr-devel
      - apr-util-devel
      - perl
      - libtool
 
# 创建 用户
apache:
  user.present:
    - shell: /sbin/nologin
    - createhome: false
    - system: Ture
 
# 解压包
extract-httpd:
  archive.extracted:
    - name: {{ pillar['PACKAGE_DIR'] }}
    - source: salt://modules/web/httpd/files/httpd-2.4.49.tar.gz
 
#传输服务启动配置文件
/etc/systemd/system/httpd.service:
  file.managed:
    - source: salt://modules/web/httpd/files/httpd.service
    - mode: 644
    - user: root
    - group: root
    - template: jinja
 
#执行脚本
install-httpd:
  file.managed:
    - name: {{ pillar['PACKAGE_DIR'] }}/install-httpd.sh
    - source: salt://modules/web/httpd/files/install.sh
    - user: root
    - group: root
    - mode: 744
    - template: jinja
    - unless: test -d {{ pillar['INSTALL_DIR'] }}/apache
  cmd.run:
    - name: /bin/bash {{ pillar['PACKAGE_DIR'] }}/install-httpd.sh
    - unless: test -d {{ pillar['INSTALL_DIR'] }}/apache
 
systemctl-daemon-reload-httpd:
  cmd.run:
    - name: systemctl daemon-reload
    - require:
      - /etc/systemd/system/httpd.service
