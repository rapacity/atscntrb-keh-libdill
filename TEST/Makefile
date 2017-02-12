
INCLUDE 		+= -lgc
INCLUDE 		+= -ldill

INCLUDE 		+= $(patsubst %,-I %,$(subst :, ,$(PATSHOMELOCS)))
INCLUDE_ATS += $(patsubst %,-IATS %,$(subst :, ,$(PATSHOMELOCS)))

PATSCC=patscc
PATSCC2=$(PATSCC) $(INCLUDE) $(INCLUDE_ATS)

CC=gcc

all: test01.out test02.out test03.out test04.out test05.out test06.out

%.out: %.dats
	$(PATSCC2) -DATS_MEMALLOC_GCBDW -o $@ $<

clean:
	rm -f *.out
	rm -f *_dats.c

