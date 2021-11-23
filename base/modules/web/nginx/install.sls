#  安装软件
"Development Tools":
  pkg.group_installed

# epel-release 应该单独下载
httpd-dep-epel-release:
  pkg.installed:
    - name: epel-release


httpd-dep:
  pkg.installed:
    - pkgs:
      - gcc
      - gcc-c++
      - make
      - pcre-devel
      - openssl
      - openssl-devel
      - gd-devel

# 创建 用户
nginx:
  user.present:
    - shell: /sbin/nologin
    - createhome: false
    - system: Ture

# 解压包
extract-nginx:
  archive.extracted:
    - name: {{ pillar['PACKAGE_DIR'] }}
    - source: salt://modules/web/nginx/files/nginx-1.20.1.tar.gz

#传输服务启动配置文件
/etc/systemd/system/nginx.service:
  file.managed:
    - source: salt://modules/web/nginx/files/nginx.service
    - mode: 644
    - user: root
    - group: root
    - template: jinja
#    
#执行脚本
install_nginx:
  file.managed:
    - name: {{ pillar['PACKAGE_DIR'] }}/install_nginx.sh
    - source: salt://modules/web/nginx/files/install.sh
    - user: root
    - group: root
    - mode: 744
    - template: jinja
    - unless: test -d {{ pillar['INSTALL_DIR'] }}/nginx
  cmd.run:
    - name: /bin/bash {{ pillar['PACKAGE_DIR'] }}/install_nginx.sh
    - unless: test -d {{ pillar['INSTALL_DIR'] }}/nginx

export_nginx:
  cmd.run:
    - name: echo 'export PATH=/usr/local/nginx/sbin:$PATH' > /etc/profile.d/nginx.sh
    - require:
      - install_nginx

systemctl-daemon-reload-httpd:
  cmd.run:
    - name: systemctl daemon-reload
    - require:
      - /etc/systemd/system/nginx.service

#salt://modules/web/httpd/files/install.sh:
#  cmd.script
#  echo 'export PATH=/usr/local/nginx/sbin:$PATH' > /etc/profile.d/nginx.sh
