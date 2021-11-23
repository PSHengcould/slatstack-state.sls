include:
    - modules.database.redis.install
  
file.managed:
    - name: {{ pillar['INSTALL_DIR'] }}/redis.conf
    - source: salt://modules/redis_master_slave/files/redis.conf
    - template: jinja

redis-restart:
  service.running:
    - name: mysqld
    - reload: Ture
    - enable: True


