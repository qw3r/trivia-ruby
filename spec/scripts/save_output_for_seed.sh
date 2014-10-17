#!/bin/bash

cd ~/Work/retreat/trivia/ruby

mkdir -p characteristic

echo "My job is done here"
exit

for seed in {1..20}; do
    SEED=$seed ./bin/trivia | tee spec/outputs/$seed.txt
done
