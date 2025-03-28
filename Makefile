DC = gdc
LD = gdc
RM = rm -f
MKDIR = mkdir -p

LIBS = sdl SDL_image SDL_ttf

#DEBUGOPT = -O3 -frelease
DEBUGOPT = -ggdb3

DFLAGS = -Wall -Wextra -Wno-uninitialized -Wdeprecated -pedantic $(DEBUGOPT)
LDFLAGS = -use-ld=gold $(DEBUGOPT)
LIBFLAGS = $(shell pkg-config --libs $(LIBS))

DEPSDIR = .deps/
DEPEXT = dep

# Functions to generate a dependency file name or directory from a source or
# object file
depdir = $(dir $(1))$(DEPSDIR)
depfile = $(call depdir,$(1))$(basename $(notdir $(1))).$(DEPEXT)

SRC = $(wildcard *.d heap/*.d sdl/*.d)
OBJ = $(patsubst %.d,%.o,$(SRC))
DEPSDIRS = $(sort $(foreach DIR,$(SRC),$(call depdir,$(DIR))))
DEPSFILES = $(foreach DIR,$(SRC),$(call depfile,$(DIR)))
BIN = mazesolver



.PHONY: all

all: $(BIN)

$(BIN): $(OBJ) Makefile
	$(LD) $(LDFLAGS) -o $@ $(OBJ) $(LIBFLAGS)

.SECONDEXPANSION:

%.o: DEPFILE = $(call depfile,$@)
%.o: DEPDIR = $(call depdir,$@)
%.o: %.d Makefile | $$(DEPDIR)
	$(DC) -M -MF $(DEPFILE) -MT $@ -MT $(DEPFILE) $(DFLAGS) -o $@ -c $<

.PRECIOUS: $(DEPSDIR) %$(DEPSDIR)

$(DEPSDIR):
	$(MKDIR) $@

%$(DEPSDIR):
	$(MKDIR) $@


# Fix for gdc failing to detect transitive dependencies
gui.o: $(wildcard sdl/*.d)

# Use wildcards in order to only include the existing .dep files. This will
# prevent make from trying to rebuild them uselessly.
# Trying to rebuild them explicitely would fail as we don't have a rule for
# that.
-include $(wildcard $(addsuffix *.$(DEPEXT),$(DEPSDIRS)))


.PHONY: clean mrproper

clean:
	$(RM) $(OBJ)
	$(RM) $(DEPSFILES)

mrproper: clean
	$(RM) $(BIN)
	$(RM) -r $(DEPSDIRS)
