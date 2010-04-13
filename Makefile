prefix = /usr/local
exec_prefix = $(prefix)
sbindir     = $(exec_prefix)/sbin
datarootdir = $(prefix)/share
mandir      = $(datarootdir)/man

INSTALL         = install
INSTALL_PROGRAM = $(INSTALL) --mode a+rx,u+w
INSTALL_DIR     = $(INSTALL) -d
INSTALL_DATA    = $(INSTALL) --mode a+r,u+w

HELP2MAN = help2man

MANSECT=8

all: auto6to4.$(MANSECT)

auto6to4.$(MANSECT): auto6to4
	$(HELP2MAN) --no-info --section=$(MANSECT) \
	 --name="set up IPv6 over IPv4 protocol 41 tunnel" \
	 --output=auto6to4.$(MANSECT) ./auto6to4

install: auto6to4.$(MANSECT)
	-$(INSTALL_DIR)			$(DESTDIR)$(sbindir)
	$(INSTALL_PROGRAM) auto6to4	$(DESTDIR)$(sbindir)/
	-$(INSTALL_DIR)			$(DESTDIR)$(mandir)/man$(MANSECT)
	$(INSTALL_DATA) auto6to4.$(MANSECT)	$(DESTDIR)$(mandir)/man$(MANSECT)/

clean:
	-rm -f auto6to4.$(MANSECT)

.PHONY: all install clean
