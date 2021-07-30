
CC=gcc

#OS=test
# try to do some autodetecting
UNAME := $(shell uname -s)

ifeq "$(UNAME)" "Darwin"
	OS=macosx
endif

ifeq "$(OS)" "Windows_NT"
	OS=windows
endif

ifeq "$(UNAME)" "Linux"
	OS=linux
endif

ifeq "$(UNAME)" "FreeBSD"
	OS=freebsd
endif

ifeq "$(UNAME)" "OpenBSD"
	OS=openbsd
endif

ifeq "$(UNAME)" "NetBSD"
       OS=netbsd
endif

MACH_TYPE:="$(strip $(shell uname -m))"
GIT_TAG?="$(strip $(shell git tag 2>&1 | tail -1 | cut -f1 -d' '))"
# deal with case of no git or no git tags, check for presence of "v" (i.e. "v1.93")
ifneq ($(findstring v,$(GIT_TAG)), v)
	GIT_TAG:="v$(strip $(shell date -r . +'%Y%m%d' ))"
endif

VERSION?="$(GIT_TAG)-$(OS)-$(MACH_TYPE)"

CFLAGS += -DVERSION=\"$(VERSION)\"

# osx

ifeq "$(OS)" "macosx"
CFLAGS += -arch x86_64 -arch arm64
endif

testme:
	$(CC) $(CFLAGS) -o testme testme.c

all: testme

clean:
	rm testme
