#!/bin/bash
if [ $(id -u) != "0" ]
then
    echo "############################################################################"
    echo "## "
    echo "## Executing setup for OgreVim on Ubuntu LTS 12.04"
    echo "## "
    echo "## This script builds out a function environment from scratch. You should"
    echo "## be able to follow all the Orgre3D tutorials from scratch after executing"
    echo "## this script from within your normal user environment"
    echo "## "
    echo "## Go to the following web address for address for a discussion about this"
    echo "## script:"
    echo "## "
    echo "## http://www.pyscape.com/ogre3d_vim_ubuntu-12_04_lts"
    echo "## "
    echo "## You must have sudo privileges to run this script!"
    echo "## "
    echo "## You cannot run this script as root!"
    echo "## "
    echo "############################################################################"

    echo "############################################################################"
    echo "## "
    echo "## Installing dependencies"
    echo "## "
    echo "############################################################################"

    sudo apt-get install \
        build-essential \
        automake \
        libtool \
        libfreetype6-dev \
        libfreGeimage-dev \
        libzzip-dev \
        libxrandr-dev \
        libxaw7-dev \
        freeglut3-dev \
        libgl1-mesa-dev \
        libglu1-mesa-dev \
        nvidia-cg-toolkit \
        libois-dev \
        libboost-thread-dev \
        doxygen \
        graphviz \
        libcppunit-dev cmake 

    echo "############################################################################"
    echo "## "
    echo "## Setting up Ogre3D"
    echo "## "
    echo "############################################################################"

    mkdir -p ~/Source/Ogre3D
    cd ~/Source/Ogre3D
    wget -O ogre_src_v1-8-1.tar.bz2 http://downloads.sourceforge.net/project/ogre/ogre/1.8/1.8.1/ogre_src_v1-8-1.tar.bz2?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fogre%2F&ts=1381180944&use_mirror=softlayer-dal
    tar -xvjf ogre_src_v1-8-1.tar.bz2
    mkdir ogre_src_v1-8-1/build
    cd ogre_src_v1-8-1/build
    cmake ../
    make -j2
    sudo make install

    echo "############################################################################"
    echo "## "
    echo "## Setting up an Ogre3D tutorial framework"
    echo "## "
    echo "############################################################################"

    mkdir -p ~/Coding/Ogre3D
    cd ~/Coding/Ogre3D
    wget -O TutorialFramework.tar.bz2 http://www.ogre3d.org/tikiwiki/tiki-download_wiki_attachment.php?attId=174&download=y
    tar -xjf TutorialFramework.tar.bz2
    wget -O dist.tar.bz2 http://www.ogre3d.org/tikiwiki/tiki-download_wiki_attachment.php?attId=135&download=y
    tar -xjf dist.tar.bz2
    cp ~/Source/ogre_src_v1-8-1/build/bin/plugins.cfg ~/Coding/Ogre3D/dist/bin/plugins.cfg

    echo "############################################################################"
    echo "## "
    echo "## Setting up an Ogre3D tutorial framework"
    echo "## "
    echo "############################################################################"

    cat >~/Coding/Ogre3D/bootstrap << EOL
#!/bin/sh
rm -rf autom4te.cache
libtoolize --force --copy && aclocal && autoheader && automake --add-missing --force-missing --copy --foreign && autoconf
EOL
    cat >~/Coding/Ogre3D/configure.ac << EOL
AC_INIT(configure.ac)
AM_INIT_AUTOMAKE(SampleApp, 0.1)
AM_CONFIG_HEADER(config.h)

AC_LANG_CPLUSPLUS
AC_PROG_CXX
AM_PROG_LIBTOOL

PKG_CHECK_MODULES(OGRE, [OGRE >= 1.2])
AC_SUBST(OGRE_CFLAGS)
AC_SUBST(OGRE_LIBS)

PKG_CHECK_MODULES(OIS, [OIS >= 1.0])
AC_SUBST(OIS_CFLAGS)
AC_SUBST(OIS_LIBS)

AC_CONFIG_FILES(Makefile)
AC_OUTPUT
EOL
    cat >~/Coding/Ogre3D/Makefile.am << EOL
noinst_HEADERS= BaseApplication.h TutorialApplication.h

bin_PROGRAMS= OgreApp
OgreApp_CPPFLAGS= -I\$(top_srcdir)
OgreApp_SOURCES= BaseApplication.cpp TutorialApplication.cpp
OgreApp_CXXFLAGS= \$(OGRE_CFLAGS) \$(OIS_CFLAGS)
OgreApp_LDADD= \$(OGRE_LIBS) \$(OIS_LIBS)

EXTRA_DIST = bootstrap
AUTOMAKE_OPTIONS = foreigno
EOL

    cd ~/Coding/Ogre3D
    chmod +x bootstrap
    ./bootstrap && ./configure

    make && cp ./OgreApp ./dist/bin/OgreApp
    cd ~/Coding/Ogre3D/dist/bin
    ./OgreApp



else
    echo "############################################################################"
    echo "##"
    echo "## You cannot run this script with root."
    echo "##"
    echo "############################################################################"
fi
