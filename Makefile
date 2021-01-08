.PHONY: all clean run

D64_IMAGE = "bin/voidrunner.d64"
D64_ORIG_IMAGE = "orig/voidrunner.d64"
X64 = xplus4
X64SC = xplus4sc
C1541 = c1541

all: clean d64 run
original: clean d64_orig run_orig

voidrunner.prg: src/voidrunner.asm
	64tass -Wall -Wno-implied-reg --cbm-prg -o bin/voidrunner.prg -L bin/list-co1.txt -l bin/labels.txt src/voidrunner.asm
	md5sum bin/voidrunner.prg orig/voidrunner.prg

d64: voidrunner.prg
	$(C1541) -format "voidrunner,rq" d64 $(D64_IMAGE)
	$(C1541) $(D64_IMAGE) -write bin/voidrunner.prg "voidrunner"
	$(C1541) $(D64_IMAGE) -list

d64_orig:
	$(C1541) -format "voidrunner,rq" d64 $(D64_ORIG_IMAGE)
	$(C1541) $(D64_ORIG_IMAGE) -write orig/voidrunner.prg "voidrunner"
	$(C1541) $(D64_ORIG_IMAGE) -list

run: d64
	$(X64) -verbose $(D64_IMAGE)

run_orig:
	$(X64) -verbose -moncommands bin/labels.txt $(D64_ORIG_IMAGE)

run: d64

clean:
	-rm $(D64_IMAGE) $(D64_ORIG_IMAGE) $(D64_HOKUTO_IMAGE)
	-rm bin/voidrunner.prg
	-rm bin/*.txt
