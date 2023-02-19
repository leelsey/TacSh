#!/usr/bin/env bash

echo "- Start AutoGen"
funcAutoGen() {
    ./tacsh.sh $@ >> /dev/null
    echo "+ Run cmd: ./tacsh.sh $@"
}

funcAutoGen 1
funcAutoGen 2 9 1
funcAutoGen 2 9 2
funcAutoGen 3
echo "- Finish AutoGen"
