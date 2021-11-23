install-env-mysql:
  pkg.installed:
    - pkgs:
      - epel-release
      - ncurses-devel
      - openssl-devel
      - openssl
      - cmake
      - mariadb-devel
      - libncurses*
# 创建用户
mysql:
  user.present:
    - shell: /sbin/nologin
    - createhome: false
    - system: true
 
# 解压
extract-mysql:
  archive.extracted:
    - name: {{ pillar['INSTALL_DIR'] }}/
    - source: salt://modules/database/mysql/files/mysql-5.7.35-linux-glibc2.12-x86_64.tar.gz
    - user: mysql
    - group: mysql
    - unless: test -d {{ pillar['INSTALL_DIR'] }}/mysql/bin
 
#判断文件是否存在，-d 为判断目录文件,-e 为判断文件，真则不执行，假则执行，相反的是onlyif
move-mysql:
  cmd.run:
    - name: mv {{ pillar['INSTALL_DIR'] }}/mysql-5.7.35-linux-glibc2.12-x86_64 {{ pillar['INSTALL_DIR'] }}/mysql
    - unless: test -d {{ pillar['INSTALL_DIR'] }}/mysql/bin
 
# 环境变量
export-mysql:
  cmd.run:
    - name: echo 'export PATH={{ pillar['INSTALL_DIR'] }}/mysql/bin:$PATH' > /etc/profile.d/mysql.sh
    - require:
      - extract-mysql
 
 
# 初始化，默认密码以隐藏文件的方式存放于/root/
mysql-install_db:
  cmd.run:
# 以下注释内容是用于初始化数据库后自动生成随机密码，随机密码以隐藏文件的形式存放于管理员路径下
#    - name: {{ pillar['INSTALL_DIR'] }}/mysql/bin/mysql_install_db --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data --user=mysql
#    - unless: test -e /root/.mysql_secret
# 初始化数据，无密码
    - name: {{ pillar['INSTALL_DIR'] }}/mysql/bin/mysqld --initialize-insecure --user=mysql --datadir={{ pillar['MYSQL_DATA'] }}/mysql/data
    - unless: test -d {{ pillar['MYSQL_DATA'] }}/mysql/data
# 传输MySQL配置文件与MySQL服务启动文件
files-mysql-config:
  file.managed:
    - names:
      - /etc/systemd/system/mysqld.service:
        - source: salt://modules/database/mysql/files/mysqld.service
        - template: jinja
      - /etc/my.cnf:
        - source: salt://modules/database/mysql/files/my.cnf
        - template: jinja
 
systemctl-daemon-reload-mysql:
  cmd.run:
    - name: systemctl daemon-reload
 
{{ pillar['INSTALL_DIR'] }}/mysql:
  file.directory:
    - user: mysql
    - group: mysql
    - mode: '0755'
    - recurse:
      - user
      - group
    - require:
      - move-mysql
 

