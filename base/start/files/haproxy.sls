service-haproxy-start:
  service.running:
    - name: haproxy
    - reload: Ture
    - enable: True
