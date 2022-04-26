# halt on error
set -e

. /etc/environment

apt-get install -y g++ \
    libfontconfig1-dev \
    libfreetype6-dev \
    libx11-dev \
    libxcursor-dev \
    libxext-dev \
    libxfixes-dev \
    libxft-dev \
    libxi-dev \
    libxrandr-dev \
    libxrender-dev \
    libssl-dev

QT_PREFIX=/usr/local/Qt-4.8.7-release/

# Download and Compile Qt
cd ~
wget -nv -t 1 http://download.qt.io/official_releases/qt/4.8/4.8.7/qt-everywhere-opensource-src-4.8.7.tar.gz
tar -zxf qt-everywhere-opensource-src-4.8.7.tar.gz
cd qt-everywhere-opensource-src-4.8.7
echo "yes" | ./configure -release -nomake examples -nomake demos -no-qt3support -no-scripttools -no-opengl -no-webkit -no-phonon -no-sql-sqlite -gtkstyle -opensource -prefix $QT_PREFIX
make && make install


# Download and Compile QCA2
cd ~
wget -nv -t 1 http://ftp.osuosl.org/pub/blfs/conglomeration/qca/qca-2.0.3.tar.bz2
bunzip2 qca-2.0.3.tar.bz2
tar -xf qca-2.0.3.tar
cd qca-2.0.3
patch src/botantools/botan/botan/secmem.h /vagrant_data/fix_build_gcc4.7.diff
./configure --qtdir=$QT_PREFIX
make && make install

# Download and Compile QCA-OSSL
cd ~
wget -nv -t 1 http://ftp.riken.jp/Linux/slackware/slackware-13.37/source/l/qca-ossl/qca-ossl-2.0.0-beta3.tar.bz2
bunzip2 qca-ossl-2.0.0-beta3.tar.bz2
tar -xf qca-ossl-2.0.0-beta3.tar
cd qca-ossl-2.0.0-beta3
patch qca-ossl.cpp < /vagrant_data/detect_ssl2_available.diff
patch qca-ossl.cpp < /vagrant_data/detect_md2_available.diff
./configure --qtdir=$QT_PREFIX
make && make install
