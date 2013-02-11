#!/bin/sh

#    Kloxo-MR - Hosting Control Panel
#
#    Copyright (C) 2013 - MRatWork
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as
#    published by the Free Software Foundation, either version 3 of the
#    License, or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#
# MRatWork - Kloxo-MR dev Installer
#
# Version: 1.0 (2013-01-11 - by Mustafa Ramadhan <mustafa@bigraf.com>)
#

kloxo_fork=mustafaramadhan
kloxo_branch=dev
kloxo_path=${kloxo_fork}/kloxo/zipball/${kloxo_branch}

## A. Packer portion
### 1. download and unzip phase

echo "Download Kloxo-MR Dev git from "${kloxo_path}
rm -rf ${kloxo_branch}* > /dev/null 2>&1
wget https://github.com/${kloxo_path} --no-check-certificate
mv -f ${kloxo_branch} kloxo.zip > /dev/null 2>&1
unzip -oq kloxo-mr.zip > /dev/null 2>&1
rm -rf kloxo-mr.zip > /dev/null 2>&1

### 2. copy mr-installer.sh
cp -rf ./kloxo/install/installer.sh ./

### 3. create binary files
cd ./kloxo/src
yum -y install which cpp gcc gcc-c++ openssl-devel automake autoconf libtool make
make

cd ../../

### 4. zipped process
zip -r9y kloxo-mr-latest.zip "./kloxo/bin" "./kloxo/cexe/closeallinput" "./kloxo/file" \
	"./kloxo/httpdocs" "./kloxo/pscript" "./kloxo/sbin" \
	"./kloxo/RELEASEINFO" "./kloxo/src" "./kloxo/etc/list" "./kloxo/etc/process" \
	"./kloxo/etc/config.ini" \
	"./kloxo/install" \
	-x \
	"./kloxo/httpdocs/commands.php" \
	"./kloxo/httpdocs/newpass" \
	"./kloxo/httpdocs/.php.err" \
	"./kloxo/CVS/*" \
	"./kloxo/.svn/*" \
	"./kloxo/httpdocs/thirdparty/*" \
	"./kloxo/httpdocs/htmllib/extjs/*" \
	"./kloxo/httpdocs/htmllib/fckeditor/*" \
	"./kloxo/httpdocs/htmllib/yui-dragdrop/*" \
	"./kloxo/file/cache/*" \
	"./kloxo/serverfile/*" \
	"./kloxo/session/*" \
	"./kloxo/etc/.restart/*" \
	"./kloxo/etc/conf/*" \
	"./kloxo/etc/flag/*" \
	"./kloxo/etc/last_sisinfoc" \
	"./kloxo/etc/program.*" \
	"./kloxo/etc/slavedb/*" \
	"./kloxo/etc/watchdog.conf" \
	"./kloxo/install/kloxo_install.log"

### 5. remove old dirs
rm -rf ./kloxo > /dev/null 2>&1
rm -rf ./kloxo-install > /dev/null 2>&1
rm -rf ./install > /dev/null 2>&1

sh installer.sh

