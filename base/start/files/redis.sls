service-redis-start:
  service.running:
    - name: redis
    - reload: Ture
    - enable: True
