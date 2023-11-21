#!/bin/bash
# This file creates all the object files and then links them
# ----------------------------

# general
ca65 main.asm -o main.o

# header
ca65 header.asm -o header.o

# Vector table
ca65 vector_table/nmi.asm -o nmi.o
ca65 vector_table/reset.asm -o reset.o
ca65 vector_table/irq.asm -o irq.o
ca65 vector_table/vector_table.asm -o vectortb.o

# link, with the config file
ld65 -C setup.cfg -o adevnes.nes main.o header.o nmi.o reset.o irq.o vectortb.o

# remove the object files
rm main.o header.o irq.o nmi.o reset.o vectortb.o
