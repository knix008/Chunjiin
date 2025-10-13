# Makefile for Chunjiin Korean Input Method

CC = gcc
CFLAGS = -Wall -Wextra -O2 $(shell pkg-config --cflags gtk+-3.0)
LIBS = $(shell pkg-config --libs gtk+-3.0)
TARGET = chunjiin
SOURCES = main.c chunjiin.c chunjiin_hangul.c
OBJECTS = $(SOURCES:.c=.o)

.PHONY: all clean install run

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CC) $(OBJECTS) -o $(TARGET) $(LIBS)

%.o: %.c chunjiin.h
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJECTS) $(TARGET) $(TARGET).exe

install: $(TARGET)
	@echo "Installing $(TARGET)..."
	cp $(TARGET) /usr/local/bin/ || cp $(TARGET).exe /usr/local/bin/
	@echo "Installation complete!"

run: $(TARGET)
	./$(TARGET)

help:
	@echo "Chunjiin Korean Input Method - Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  make          - Build the application"
	@echo "  make clean    - Remove build files"
	@echo "  make run      - Build and run the application"
	@echo "  make install  - Install to /usr/local/bin"
	@echo "  make help     - Show this help message"
