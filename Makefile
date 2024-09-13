-include config.mk

TARGET  ?= petool
REV     := $(shell git describe --match=NeVeRmAtCh --always --dirty)
STRIP   ?= strip
CFLAGS  ?= -std=c99 -pedantic -Wall -Wextra -DREV=\"$(REV)\"

ifdef DEBUG
	CFLAGS  += -ggdb
else
	CFLAGS  += -O2
endif

ifeq ($(DESTDIR)$(PREFIX),)
	PREFIX := /usr/local
endif

SRCS   := $(wildcard src/*.c) src/incbin.S
OBJS   := $(addsuffix .o, $(basename $(SRCS)))

.PHONY: clean all install
all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) -o $@ $^

clean:
	$(RM) $(TARGET) $(OBJS)

install: $(TARGET)
	install $(TARGET) $(DESTDIR)$(PREFIX)/bin/

uninstall: 
	$(RM) $(DESTDIR)$(PREFIX)/bin/$(TARGET)
