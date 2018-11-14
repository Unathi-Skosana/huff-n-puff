#
# COMPUTER SCIENCE 244
# Makefile for Huffman encoding tutorial
# (c) 2017 University of Stellenbosch
#
#
# NOTE: This Makefile does not include the ability to install to your local
# bindir, because there already exist various programs by the name of
# "compress" that might be installed on a Linux system.  However, if you do
# want to add rules for installation, simply pilfer the requisite parts from
# the compiler Makefile.
#
# NOTE: Mac OS X uses a different executable file format than Linux.  This
# tutorial is not compatible with Mac OS X.

NAME     = compress

# assembler and compiler flags
DEBUG    = -ggdb #-S
OPTIMISE = -O0
WARNINGS = -Wall
TARGET   = -m32
CFLAGS   = $(DEBUG) $(OPTIMISE) $(WARNINGS) $(TARGET)
DFLAGS   = # nothing yet....
ASMFLAGS = -g -f elf32
OBJ_LOC = ../obj
LIB_LOC = ../lib

# commands
ASM      = nasm
CC       = gcc
RM       = rm -f
COMPILE  = $(CC) $(CFLAGS) $(DFLAGS)
ASSEMBLE = $(ASM) $(ASMFLAGS)

# C main
C_OBJS   = $(OBJ_LOC)/main.o $(OBJ_LOC)/huffman_c.o $(OBJ_LOC)/heap_c.o $(OBJ_LOC)/utils.o

# assembler main
ASM_OBJS = $(OBJ_LOC)/heap.o $(OBJ_LOC)/huffman.o

# rules ########################################################################

$(NAME): $(C_OBJS) $(ASM_OBJS)
	$(COMPILE) -o $@ $(OBJ_LOC)/$^

$(OBJ_LOC)/heap.o: heap.asm $(LIB_LOC)/heap.h
	$(ASSEMBLE) $< -o $(OBJ_LOC)/$@

$(OBJ_LOC)/heap_c.o: heap_c.c $(LIB_LOC)/heap_c.h
	$(COMPILE) -c $< -o $(OBJ_LOC)/$@

$(OBJ_LOC)/huffman.o: huffman.asm $(LIB_LOC)/huffman.h
	$(ASSEMBLE) $< -o $(OBJ_LOC)/$@

$(OBJ_LOC)/huffman_c.o: huffman_c.c $(LIB_LOC)/huffman_c.h
	$(COMPILE) -c $< -o $(OBJ_LOC)/$@

$(OBJ_LOC)/utils.o: utils.c $(LIB_LOC)/utils.h
	$(COMPILE) -c $< -o $(OBJ_LOC)/$@

$(OBJ_LOC)/main.o: main.c
	$(COMPILE) -c $< -o $(OBJ_LOC)/$@

# PHONY TARGETS ################################################################

.PHONY: all clean types

all: $(NAME)

clean:
	$(RM) $(OBJ_LOC)/*.o
	$(RM) $(NAME)
