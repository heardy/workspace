#!/bin/bash
OSX="OSX"
WIN="WIN"
case $OSTYPE in
  solaris*) OS="SOLARIS" ;;
  darwin*)  OS="OSX" ;; 
  linux*)   OS="LINUX" ;;
  bsd*)     OS="BSD" ;;
  win*)     OS=$WIN ;;
  cygwin*)  OS=$WIN ;;
  msys*)    OS=$WIN ;;
  *)        OS="unknown: $OSTYPE" ;;
esac

echo "This is $OS"

if [ $OS == $OSX ]
then
  echo "do OSX shiz"
elif [ $OS == $WIN ]
then
  echo "do win shiz"
# else
#   echo "Count is less than 100"
fi
