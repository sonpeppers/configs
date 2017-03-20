# Paul Epperson (github.com/sonpeppers)
CC=g++
FLAGS=-g -Wall --std=c++11
OBJECTS=$(patsubst %.cpp,%.o, $(wildcard *.cpp))

all: $(OBJECTS)

# TODO replace naive substitution target with your actual build targets
%.o : %.cpp
        $(CC) $(FLAGS) -o $@ $<

.PHONY: info
info:
        $(info OBJECTS = [${OBJECTS}])

.PHONY: new
new:
        @make --no-print-directory clean
        @make --no-print-directory all

.PHONY: clean
clean:
        -rm -f $(OBJECTS)
