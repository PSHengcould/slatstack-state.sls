KEEPALIVED_SLAVE_PRIORITY: 90
# 优先级会决定主备角色，优先级越大越优先
KEEPALIVED_MASTER_PRIORITY: 100
# 优先级
KEPAVLIVED_AUTH_TYPE: PASS
# 认证方式
KEPAVLIVED_AUTH_PASS: 123123
# 认证密码
KEEPALIVED_VIP: 192.168.48.250 
# 虚拟服务器 
KEEPALIVED_MASTER_IP: 192.168.48.141 80
# 主服务器IP
KEEPALIVED_SLAVE_IP: 192.168.48.142 80
# 备服务器IP
