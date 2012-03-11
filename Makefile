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

RM = rm

MANSECT=8

PROG=auto6to4

all: $(PROG).$(MANSECT)

$(PROG).$(MANSECT): $(PROG)
	$(HELP2MAN) --no-info --section=$(MANSECT) \
	 --name="set up IPv6 over IPv4 protocol 41 tunnel" \
	 --output=$(PROG).$(MANSECT) ./$(PROG)

install: $(PROG).$(MANSECT)
	-$(INSTALL_DIR)			$(DESTDIR)$(sbindir)
	$(INSTALL_PROGRAM) $(PROG)	$(DESTDIR)$(sbindir)/
	-$(INSTALL_DIR)			$(DESTDIR)$(mandir)/man$(MANSECT)
	$(INSTALL_DATA) $(PROG).$(MANSECT) $(DESTDIR)$(mandir)/man$(MANSECT)/

uninstall:
	-$(RM) -f $(DESTDIR)$(sbindir)/$(PROG)
	-$(RM) -f $(DESTDIR)$(mandir)/man$(MANSECT)/$(PROG).$(MANSECT)

clean:
	-rm -f $(PROG).$(MANSECT)

.PHONY: all install clean
