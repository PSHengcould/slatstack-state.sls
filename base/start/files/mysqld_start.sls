service-mysqld-start:
  service.running:
    - name: mysqld
    - reload: Ture
    - enable: True

