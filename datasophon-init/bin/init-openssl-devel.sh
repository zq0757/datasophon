#!/bin/bash

if [ $UID -ne 0 ]; then
  echo Non root user. Please run as root.
  exit 1
fi
if [ -L $0 ]; then
  BASE_DIR=$(dirname $(readlink $0))
else
  BASE_DIR=$(dirname $0)
fi
BASE_PATH=$(
  cd ${BASE_DIR}
  pwd
)
INIT_PATH=$(dirname "${BASE_PATH}")
echo "INIT_PATH: ${INIT_PATH}"

rpm -qa | grep openssl-devel
if [ "$?" == "0" ]; then
  echo "rpm -qa | grep openssl-devel exists"
else
  yum -y install openssl-devel
  rpm -qa | grep openssl-devel
  if [ "$?" == "0" ]; then
    echo "openssl-devel install successfully"
  fi
fi
