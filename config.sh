#!/bin/bash

cp -r assets/* build/web/assets/
cd build/web

counter=1
files=$(find . -name '*.jpg')
for i in $(echo $files); do
  cp $i ./$count.jpg &&  jpegoptim --size=30kb $count.jpg && mv ./$count.jpg $i && count=$(($count+1))
done

counter=1
files=$(find . -name '*.js')
for i in $(echo $files); do
  cp $i ./$count &&  terser ./$count > $i && rm ./$count && count=$(($count+1))
done
