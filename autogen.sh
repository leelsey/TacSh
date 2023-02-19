#!/usr/bin/env bash

funcAutoGen() { ./tacsh.sh $@ >> /dev/null ; echo "+ Run cmd: ./tacsh.sh $@" ; }
echo "- Start AutoGen"
funcAutoGen 1 0 0
funcAutoGen 2 1 1
funcAutoGen 2 1 2
funcAutoGen 2 2 1
funcAutoGen 2 2 2
funcAutoGen 2 3 1
funcAutoGen 2 3 2
funcAutoGen 2 4 1
funcAutoGen 2 4 2
funcAutoGen 2 5 1
funcAutoGen 2 5 2
funcAutoGen 2 6 1
funcAutoGen 2 6 2
funcAutoGen 2 7 1
funcAutoGen 2 7 2
funcAutoGen 2 8 1
funcAutoGen 2 8 2
funcAutoGen 2 9 1
funcAutoGen 2 9 2
funcAutoGen 3 0 0
echo "- Finish AutoGen"
