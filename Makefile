PROGRAM := tiny-lisp
OBJECTS := tiny-lisp.o

ifeq ($(shell uname -s), Linux)
CPPFLAGS += -D_DEFAULT_SOURCE -D_BSD_SOURCE
endif

CFLAGS += -std=c11 -Wall -pedantic

PREFIX ?= /usr/local

.PHONY: all
all: CPPFLAGS += -DNDEBUG
all: CFLAGS   += -O2
all: $(PROGRAM)

.PHONY: debug
debug: CPPFLAGS += -DDEBUG
debug: CFLAGS   += -g
debug: LDFLAGS  += -g
debug: $(PROGRAM)

.PHONY: clean
clean:
	$(RM) $(PROGRAM) $(OBJECTS)

$(PROGRAM): $(OBJECTS)
	$(CC) $(LDFLAGS) -o $@ $^

%.o: %.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

.PHONY: install
install: all
	mkdir -p $(PREFIX)/bin
	install $(PROGRAM) $(PREFIX)/bin
