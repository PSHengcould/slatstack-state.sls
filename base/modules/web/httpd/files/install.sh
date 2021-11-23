#!/bin/bash
cd {{ pillar['PACKAGE_DIR'] }}/httpd-2.4.49
./configure --prefix="{{ pillar['INSTALL_DIR'] }}"/apache\
	--enable-so \
	--enable-ssl \
	--enable-cgi \
	--enable-rewrite \
	--with-zlib \
	--with-pcre \
	--enable-modules=most \
	--enable-mpms-shared=all \
	--with-mpm=prefork && make -j $(grep 'processor' /proc/cpuinfo | wc -l) && make install
echo 'export PATH={{ pillar['INSTALL_DIR'] }}/apache/bin:$PATH' > /etc/profile.d/httpd.sh
