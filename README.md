# assembly-nes
A NES game written using 6502 Assembly

## Table of Contents
- [Description](#description)
- [Installation](#installation)
- [Usage](#usage)
- [Code Details](#code-details)
- [Sources](#sources)

## Description

A side-scroller NES game written completely in 6502 assembly, created to learn assembly programming in a resource constrained environment (2k of memory!).
The purpose of this project was not to design a super intricate game, as least not for now, but rather learn how to program old systems that did not have the advanced hardware we have today.

## Installation

To run the project you're going to need an assembler/linker and an emulator.

For the assembler / linker you must install cc65, a 6502 assembler, C compiler, linker and more. We're not using any of the C functionality of the CC65.

https://cc65.github.io/getting-started.html

For the emulator, I'm using Fceux because it has a few other tools i'm looking for but you can use any emulator of your choice. Particularly I'm interested in the debugging tools and ability to view memory as the game runs.

https://fceux.com/web/download.html

With a little more setup, and a device for making cartridges, you can even make your own nes game cartridge and have it work with the original NES console!


Now that the compiler and emulator are downloaded, clone the project. 

If on Unix system (I use MacOS), you can use my ```compile.sh``` file that I've provided to run the assembler/linker and create an executable. 
Once in the project directory:
```
./compile.sh
```

If you're on Windows, please modify the script as needed.


## Usage 

Depending on how your emulator is configured, use the mapped up, down, right, left buttons to move the character.


## Code Details 

### Hardware
The nes has no persistent storage or operating system. It has 2k worth of RAM for us to execute our program and the cartridge gives us ROM, containing the code and sprites

The `header.asm` file includes a header which is in a specific format for emulators to recognize the file as an NES game.

Since there is no operating system on the NES, we need to provide our own interrupt handlers, which are found under `/vector_table`.

Our graphics include backgrounds and sprites. Sprites live in the OAM at `$0200` and backgrounds are inputted into the PPU at specified regions mentioned in the NES docs. 

# Sources 

- https://www.nesdev.org/NESDoc.pdf                                                             - main resource on NES development specifics
- https://skilldrick.github.io/easy6502/#intro                                                  - 6502 assembly tutorial for beginners
- https://vfiuchcikicshuusrch.ddns.net/content/uploadfile/201507/4ab41437909857.txt             - more details on the NES file format requirements
- https://www.cc65.org/doc/ca65-11.html                                                         - control commands for cc65
- https://www.cc65.org/doc/ld65-5.html                                                          - config file documentation for cc65
