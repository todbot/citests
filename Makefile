
CC=gcc

OS=test
MACH_TYPE:="$(strip $(shell uname -m))"
GIT_TAG?="$(strip $(shell git tag 2>&1 | tail -1 | cut -f1 -d' '))"
# deal with case of no git or no git tags, check for presence of "v" (i.e. "v1.93")
ifneq ($(findstring v,$(GIT_TAG)), v)
	GIT_TAG:="v$(strip $(shell date -r . +'%Y%m%d' ))"
endif

VERSION?="$(GIT_TAG)-$(OS)-$(MACH_TYPE)"

CFLAGS += -DVERSION=\"$(VERSION)\"

testme:
	$(CC) $(CFLAGS) -o testme testme.c

all: testme
