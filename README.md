# assembly-nes
A NES game written completely in 6502 Assembly

## Table of Contents

- [Project Title](#project-title)
- [Description](#description)
- [Installation](#installation)
- [Usage](#usage)
- [Code Details](#code-details)
- [Sources](#sources)

## Description

Creating an NES game in 6502 assembly as a way to learn the NES hardware and using Assembly in a constricted environment (2k of memory!).
The purpose of this project was not to design a super intricate game, as least not for now, but rather learn how to program old systems that did not have the advanced hardware we have today.

## Installation

To run the project you're going to need an assembler/linker and an emulator.

For the assembler / linker you must install cc65, a powerful 6502 assembler, C compiler, linker and more. We're not using any of the C functionality of the CC65.

https://cc65.github.io/getting-started.html

For the emulator, I'm using Fceux because it has some other tools included but you can use any emulator of your choice. Particularly I'm interested in the feature that shows memory usage as the game is played.

https://fceux.com/web/download.html

With a little more setup, and a device for making cartridges, you can even make your own nes game cartridge and have it work with the original NES console!


Now that the compiler and emulator are downloaded, clone the project. 

If on Unix system (I use MacOS), you can use my ```compile.sh``` file that I've provided to run the assembler/linker and create an executable. 
Once in the project directory:
```
./compile.sh
```

If you're on Windows, please modify the script to match the Windows requirements.


## Usage 

How to use the game ** coming soon


## Code Details 

### Hardware
The nes has no persistent storage or operating system. It has 2k worth of RAM for us to execute our program and the cartridge gives us ROM, with the code and sprites. In more complex games theres extra features

The cart file includes a header which must be in a specific format to be identified as a NES game

Since there is no operating system on the NES, we need to provide our own interrupt handler.


### Graphics

#### Colour palettes 

#### Sprites


# Sources 

- https://www.chibiakumas.com/6502/nesfamicom.php                                               - great resource on NES hardware specifics and some 6502 assembly
- https://www.middle-engine.com/blog/posts/2020/06/23/programming-the-nes-the-6502-in-detail    - Another good resource on NES and 6502 assembly
- https://skilldrick.github.io/easy6502/#intro                                                  - 6502 assembly tutorial for beginners
- https://vfiuchcikicshuusrch.ddns.net/content/uploadfile/201507/4ab41437909857.txt             - more details on the NES file format requirements
- https://www.cc65.org/doc/ca65-11.html                                                         - control commands for cc65
- https://www.cc65.org/doc/ld65-5.html                                                          - config file documentation for cc65
- 