install_dep:
  pkg.installed:
    - pkgs:
      - epel-release
      - gcc
      - gcc-c++
      - keepalived

install_keepalived_config:
  file.managed:
    - name: /etc/keepalived/keepalived.conf:
    - source: salt://modules/keepalived/files/slave_keepalived.conf
    - template: jinja

