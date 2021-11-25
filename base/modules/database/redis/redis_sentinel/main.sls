include:
    - modules.database.redis.install
  
file.managed:
    - name: {{ pillar['INSTALL_DIR'] }}/redis/conf/sentinel.conf
    - source: salt://modules/database/redis/redis_sentinel/files/sentinel.conf
    - template: jinja
    - makedirs: Ture
#redis-restart:
#  service.running:
#    - name: 
#    - reload: Ture
#    - enable: True


