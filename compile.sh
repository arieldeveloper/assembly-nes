# create all the object files 
ca65 main.asm -o main.o
ca65 header.asm -o header.o

# link, with the config file
ld65 -C setup.cfg -o adevnes.nes main.o header.o

# remove the object files
rm main.o header.o
