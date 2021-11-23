php-deo-epel-release:
  pkg.installed:
    - name: epel-release

php-dep:
  pkg.installed:
    - pkgs:
      - gcc
      - gcc-c++
      - make
      - pcre
      - pcre-devel
      - expat-devel
      - perl
      - openssl-devel
      - libtool
      - autoconf
      - freetype
      - gd
      - libpng
      - libpng-devel 
      - libjpeg
      - libxml2
      - libxml2-devel
      - zlib
      - curl
      - curl-devel
      - net-snmp-devel
      - libjpeg-devel
      - php-ldap
      - openldap-devel
      - openldap-clients
      - freetype-devel
      - gmp-devel
      - libzip
      - libzip-devel
      - sqlite-devel
      - libicu-devel
      - libmcrypt
      - libmcrypt-devel
      - libxslt-devel
      - mhash
      - mhash-devel
      - readline-devel
      - libgcrypt
      - libxslt
      - php-mysqlnd

extract-php:
  archive.extracted:
    - name: {{ pillar['PACKAGE_DIR'] }}
    - source: salt://modules/application/php/files/{{ pillar['PHP'] }}.tar.gz
    - user: root
    - group: root

extract-oniguruma:
  archive.extracted:
    - name: {{ pillar['PACKAGE_DIR'] }}
    - source: salt://modules/application/php/files/oniguruma-6.9.4.tar.gz
    - user: root
    - group: root

#执行脚本
install-oniguruma-and-php:
  file.managed:
    - name: {{ pillar['PACKAGE_DIR'] }}/install-php.sh
    - source: salt://modules/application/php/files/install.sh
    - user: root
    - group: root
    - mode: 744
    - template: jinja
    - unless: test -d {{ pillar['INSTALL_DIR'] }}/php
  cmd.run:
    - name: /bin/bash {{ pillar['PACKAGE_DIR'] }}/install-php.sh
    - unless: test -d {{ pillar['INSTALL_DIR'] }}/php

#salt://modules/application/php/files/install.sh:
#  cmd.script

file-php-config:
  file.managed:
    - names:
      - /etc/systemd/system/php-fpm.service:
        - source: salt://modules/application/php/files/php-fpm.service
        - watch_in: systemctl-daemon-reload-php
      - /etc/php.ini:
        - source: salt://modules/application/php/files/php.ini-production
      - /etc/init.d/php-fpm:
        - source: salt://modules/application/php/files/init.d.php-fpm.in
        - user: root
        - group: root
        - mode: 775
      - {{ pillar['INSTALL_DIR'] }}/php/etc/php-fpm.conf:
        - source: salt://modules/application/php/files/php-fpm.conf.default
      - {{ pillar['INSTALL_DIR'] }}/php/etc/php-fpm.d/www.conf:
        - source: salt://modules/application/php/files/www.conf.default

systemctl-daemon-reload-php:
  cmd.run:
    - name: systemctl daemon-reload
