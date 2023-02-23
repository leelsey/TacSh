#!/usr/bin/env bash

source ./package.sh
funcTitle() { echo -e "$1 ______         ______ \n$1/_  __/__ _____/ __/ / \n$1 / / / _ \`/ __/\\ \\/ _ \\ \n$1/_/  \\_,_/\\__/___/_//_/ ver $version \n$1                        by $author \n" ; }
funcAB() { ./tacsh.sh $@ >> /dev/null ; echo "+ Run: ./tacsh.sh $@" ; }
funcTitle ""
echo "- Start $name AutoBuild"
funcAB 1 0 0
funcAB 2 1 1
funcAB 2 1 2
funcAB 2 2 1
funcAB 2 2 2
funcAB 2 3 1
funcAB 2 3 2
funcAB 2 4 1
funcAB 2 4 2
funcAB 2 5 1
funcAB 2 5 2
funcAB 2 6 1
funcAB 2 6 2
funcAB 2 7 1
funcAB 2 7 2
funcAB 2 8 1
funcAB 2 8 2
funcAB 2 9 1
funcAB 2 9 2
funcAB 3 0 0
echo "- Finish $name AutoBuild"
