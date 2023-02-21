#!/usr/bin/env bash

funcAB() { ./tacsh.sh $@ >> /dev/null ; echo "+ Run CMD: ./tacsh.sh $@" ; }
echo "- Start AutoBuild"
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
echo "- Finish AutoBuild"
