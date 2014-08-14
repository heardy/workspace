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
#   echo "do something else"
fi


#stuff that will need happen when above is sorted
# cp ./.bashrc ~/.bashrc

# reload .bashrc
#source ~/.bashrc

#cp ./sublime/*.* /c/Program\ Files/Sublime\ Text\ 3/Packages/User