#!/bin/bash
#! /bin/bash
 
set -e

rm -f adevnes.o
rm -f adevnes.nes
rm -f adevnes.map.txt
rm -f adevnes.labels.txt
rm -f adevnes.nes.*
rm -f adevnes.dbg
 
echo compiling...
ca65 src/main.asm -g -o adevnes.o
 
echo linking...
ld65 -o adevnes.nes -C setup.cfg adevnes.o -m adevnes.map.txt -Ln adevnes.labels.txt --dbgfile adevnes.dbg
echo Succesfully built adevnes.nes