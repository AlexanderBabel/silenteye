FROM ubuntu:precise

ENV QT_PREFIX=/usr/local/Qt-4.8.7-release/

WORKDIR /build

RUN apt update && apt-get install -y wget \
    build-essential \
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
    libssl-dev && \

    # Download qt
    wget -nv -t 1 https://download.qt.io/archive/qt/4.8/4.8.7/qt-everywhere-opensource-src-4.8.7.tar.gz \
    tar -zxf qt-everywhere-opensource-src-4.8.7.tar.gz \
    cd qt-everywhere-opensource-src-4.8.7 \
    echo "yes" | ./configure -release -nomake examples -nomake demos -no-qt3support -no-scripttools -no-opengl -no-webkit -no-phonon -no-sql-sqlite -gtkstyle -opensource -prefix $QT_PREFIX \
    make && make install
