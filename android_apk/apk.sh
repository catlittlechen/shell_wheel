#!/bin/bash

if [ ! -e "$1"  ]
then
  echo "File $1 not found."
  exit;
fi

str=$1
if [ ${str:0-4} != ".apk" ]
then
  echo "File $1 is not a apk"
  exit;
fi

if which apktool >/dev/null; then
  echo apktool does exist
else
  echo apktool does not exist, will install
  chmod u+x `pwd`/src/apktool1.5.2/apktool.jar
  ln -s `pwd`/src/apktool1.5.2/apktool.jar /usr/local/bin/apktool
fi

if which dex2jar >/dev/null; then
  echo dex2jar does exist
else
  echo dex2jar does not exist, will install
  chmod u+x `pwd`/src/dex2jar-0.0.9.15/dex2jar.sh
  ln -s `pwd`/src/dex2jar-0.0.9.15/d2j-dex2jar.sh /usr/local/bin/dex2jar
fi

str=${str%".apk"} 

cp `pwd`/"$str".apk `pwd`/"$str".zip
unzip `pwd`/"$str".zip -d `pwd`/"$str"
dex2jar `pwd`/"$str"/classes.dex
mv `pwd`/classes-dex2jar.jar `pwd`/"$str".jar
rm `pwd`/"$str".zip
