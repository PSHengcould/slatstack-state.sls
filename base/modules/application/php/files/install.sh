#!/bin/bash
cd {{ pillar['PACKAGE_DIR'] }}/oniguruma-6.9.4/ &&\
	./autogen.sh &&\
	./configure --prefix=/usr --libdir=/lib64 &&\
	make && make install
cd {{ pillar['PACKAGE_DIR'] }}/{{ pillar['PHP'] }}/ &&\
	./configure  \
	--prefix="{{ pillar['INSTALL_DIR'] }}"/php  \
	--with-config-file-path=/etc \
	--enable-fpm \
	--disable-debug \
	--disable-rpath \
	--enable-shared \
	--enable-soap \
	--with-openssl \
	--enable-bcmath \
	--with-iconv \
	--with-bz2 \
	--enable-calendar \
	--with-curl \
	--enable-exif  \
	--enable-ftp \
	--with-gd \
	--enable-gd \
	--with-jpeg \
	--with-zlib-dir \
	--with-freetype \
	--with-gettext \
	--enable-mbstring \
	--enable-pdo \
	--with-mysqli=mysqlnd \
	--with-pdo-mysql=mysqlnd \
	--with-readline \
	--enable-shmop \
	--enable-simplexml \
	--enable-sockets \
	--with-zip \
	--enable-mysqlnd-compression-support \
	--with-pear \
	--enable-pcntl \
	--enable-posix && make -j $(grep 'processor' /proc/cpuinfo | wc -l) && make install 
echo 'export PATH={{ pillar['INSTALL_DIR'] }}/php/bin:$PATH' > /etc/profile.d/php.sh
