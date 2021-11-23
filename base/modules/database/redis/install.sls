#  安装软件
"Development Tools":
  pkg.group_installed


redis-dep:
  pkg.installed:
    - pkgs:
      - epel-release
      - gcc
      - gcc-c++
      - make
      - tcl

# 解压包
extract-redis:
  archive.extracted:
    - name: {{ pillar['PACKAGE_DIR'] }}
    - source: salt://modules/database/redis/files/redis-stable.tar.gz

redis:
  user.present:
    - shell: /sbin/nologin
    - createhome: false
    - system: true

install_redis:
  cmd.run:
    - name: cd {{ pillar['PACKAGE_DIR'] }}/redis-stable/ && make PREFIX={{ pillar['INSTALL_DIR'] }}/redis install
    - unless: test -d {{ pillar['INSTALL_DIR'] }}/redis

/usr/local/redis/redis.conf:
  file.managed:
    - source: salt://modules/database/redis/files/redis.conf

#传输服务启动配置文件

/etc/systemd/system/redis_server.service:
  file.managed:
    - source: salt://modules/database/redis/files/redis_server.service
    - mode: 644
    - user: root
    - group: root
    - template: jinja

export_redis:
  cmd.run:
    - name: echo 'export PATH=/usr/local/redis/bin:$PATH' > /etc/profile.d/redis.sh
    - require:
      - install_redis

systemctl-daemon-reload-redis:
  cmd.run:
    - name: systemctl daemon-reload
    - require:
      - /etc/systemd/system/redis_server.service


