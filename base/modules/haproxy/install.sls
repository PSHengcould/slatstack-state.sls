install_dep:
  pkg.installed:
    - pkgs:
      - make
      - gcc
      - pcre-devel
      - bzip2-devel
      - openssl-devel
      - systemd-devel

haproxy:
  user.present:
    - shell: /sbin/nologin
    - createhome: false
    - system: true

extract-haproxy:
  archive.extracted:
    - name: {{ pillar['PACKAGE_DIR'] }}
    - source: salt://modules/haproxy/files/haproxy-2.4.0.tar.gz
    
install_haproxy:
  file.managed:
    - name: {{ pillar['PACKAGE_DIR'] }}/install_haproxy.sh
    - source: salt://modules/haproxy/files/install.sh
    - user: root
    - group: root
    - mode: 744
    - template: jinja
    - unless: test -d {{ pillar['INSTALL_DIR'] }}/haproxy
  cmd.run:
    - name: /bin/bash {{ pillar['PACKAGE_DIR'] }}/install_haproxy.sh
    - unless: test -d {{ pillar['INSTALL_DIR'] }}/haproxy

haproxy_server:
  file.managed:
    - name: /etc/systemd/system/haproxy.service
    - source: salt://modules/haproxy/files/haproxy.service
    - mode: 644
    - user: root
    - group: root
    - template: jinja


install_haproxy_config:
  file.managed:
    - names:
      - /etc/sysctl.conf:
        - source: salt://modules/haproxy/files/sysctl.conf
      - /etc/haproxy/haproxy.cfg:
        - source: salt://modules/haproxy/files/haproxy.cfg
        - makedirs: Ture
        - template: jinja
      - /etc/rsyslog.conf:
        - source: salt://modules/haproxy/files/rsyslog.conf


systemctl-daemon-reload-haproxy:
  cmd.run:
    - name: systemctl daemon-reload
    - require:
      - haproxy_server
