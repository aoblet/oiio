#!/usr/bin/env bash

# Utility script to download and build cmake
#
# Copyright Contributors to the OpenImageIO project.
# SPDX-License-Identifier: Apache-2.0
# https://github.com/AcademySoftwareFoundation/OpenImageIO

# Exit the whole script if any command fails.
set -ex

echo "Building cmake"
uname

CMAKE_VERSION=${CMAKE_VERSION:=3.31.3}
LOCAL_DEPS_DIR=${LOCAL_DEPS_DIR:=${PWD}/ext}
CMAKE_INSTALL_DIR=${CMAKE_INSTALL_DIR:=${LOCAL_DEPS_DIR}/cmake}

if [[ `uname` == "Linux" && `uname -m` == "x86_64" ]] ; then
    mkdir -p ${CMAKE_INSTALL_DIR} || true
    curl --location "https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-Linux-x86_64.sh" -o "cmake.sh"
    sh cmake.sh --skip-license --prefix=${CMAKE_INSTALL_DIR}
    export PATH=${CMAKE_INSTALL_DIR}/bin:$PATH
fi

if [[ `uname` == "Linux" && `uname -m` == "aarch64" ]] ; then
    mkdir -p ${CMAKE_INSTALL_DIR} || true
    curl --location "https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-Linux-aarch64.sh" -o "cmake.sh"
    sh cmake.sh --skip-license --prefix=${CMAKE_INSTALL_DIR}
    export PATH=${CMAKE_INSTALL_DIR}/bin:$PATH

    # In case we ever need to build from scratch:
    # curl --location "https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}.tar.gz" -o cmake.tar.gz
    # tar xzf cmake.tar.gz
    # pushd cmake-${CMAKE_VERSION}
    # CXX="ccache $CXX" ./bootstrap --parallel=${PARALLEL:=4} --enable-ccache
    # CXX="ccache $CXX" timeout 2100 time make ${PAR_MAKEFAGS} || true
    # export PATH=${CMAKE_INSTALL_DIR}/bin:$PWD/bin:$PATH
    # popd
fi
