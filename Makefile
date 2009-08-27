# auto generated - do not edit

default: all

all:\
UNIT_TESTS/t_16_01 UNIT_TESTS/t_16_01.ali UNIT_TESTS/t_16_01.o \
UNIT_TESTS/t_32_01 UNIT_TESTS/t_32_01.ali UNIT_TESTS/t_32_01.o \
UNIT_TESTS/t_64_01 UNIT_TESTS/t_64_01.ali UNIT_TESTS/t_64_01.o \
UNIT_TESTS/t_r16_01 UNIT_TESTS/t_r16_01.ali UNIT_TESTS/t_r16_01.o \
UNIT_TESTS/t_r32_01 UNIT_TESTS/t_r32_01.ali UNIT_TESTS/t_r32_01.o \
UNIT_TESTS/t_r64_01 UNIT_TESTS/t_r64_01.ali UNIT_TESTS/t_r64_01.o \
UNIT_TESTS/test.a UNIT_TESTS/test.ali UNIT_TESTS/test.o serial_io.ali \
serial_io.o

UNIT_TESTS/t_16_01:\
ada-bind ada-link UNIT_TESTS/t_16_01.ald UNIT_TESTS/t_16_01.ali \
UNIT_TESTS/test.ali serial_io.ali
	./ada-bind UNIT_TESTS/t_16_01.ali
	./ada-link UNIT_TESTS/t_16_01 UNIT_TESTS/t_16_01.ali

UNIT_TESTS/t_16_01.ali:\
ada-compile UNIT_TESTS/t_16_01.adb serial_io.ali UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_16_01.adb

UNIT_TESTS/t_16_01.o:\
UNIT_TESTS/t_16_01.ali

UNIT_TESTS/t_32_01:\
ada-bind ada-link UNIT_TESTS/t_32_01.ald UNIT_TESTS/t_32_01.ali \
UNIT_TESTS/test.ali serial_io.ali
	./ada-bind UNIT_TESTS/t_32_01.ali
	./ada-link UNIT_TESTS/t_32_01 UNIT_TESTS/t_32_01.ali

UNIT_TESTS/t_32_01.ali:\
ada-compile UNIT_TESTS/t_32_01.adb serial_io.ali UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_32_01.adb

UNIT_TESTS/t_32_01.o:\
UNIT_TESTS/t_32_01.ali

UNIT_TESTS/t_64_01:\
ada-bind ada-link UNIT_TESTS/t_64_01.ald UNIT_TESTS/t_64_01.ali \
UNIT_TESTS/test.ali serial_io.ali
	./ada-bind UNIT_TESTS/t_64_01.ali
	./ada-link UNIT_TESTS/t_64_01 UNIT_TESTS/t_64_01.ali

UNIT_TESTS/t_64_01.ali:\
ada-compile UNIT_TESTS/t_64_01.adb serial_io.ali UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_64_01.adb

UNIT_TESTS/t_64_01.o:\
UNIT_TESTS/t_64_01.ali

UNIT_TESTS/t_r16_01:\
ada-bind ada-link UNIT_TESTS/t_r16_01.ald UNIT_TESTS/t_r16_01.ali \
UNIT_TESTS/test.ali serial_io.ali
	./ada-bind UNIT_TESTS/t_r16_01.ali
	./ada-link UNIT_TESTS/t_r16_01 UNIT_TESTS/t_r16_01.ali

UNIT_TESTS/t_r16_01.ali:\
ada-compile UNIT_TESTS/t_r16_01.adb serial_io.ali UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_r16_01.adb

UNIT_TESTS/t_r16_01.o:\
UNIT_TESTS/t_r16_01.ali

UNIT_TESTS/t_r32_01:\
ada-bind ada-link UNIT_TESTS/t_r32_01.ald UNIT_TESTS/t_r32_01.ali \
UNIT_TESTS/test.ali serial_io.ali
	./ada-bind UNIT_TESTS/t_r32_01.ali
	./ada-link UNIT_TESTS/t_r32_01 UNIT_TESTS/t_r32_01.ali

UNIT_TESTS/t_r32_01.ali:\
ada-compile UNIT_TESTS/t_r32_01.adb serial_io.ali UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_r32_01.adb

UNIT_TESTS/t_r32_01.o:\
UNIT_TESTS/t_r32_01.ali

UNIT_TESTS/t_r64_01:\
ada-bind ada-link UNIT_TESTS/t_r64_01.ald UNIT_TESTS/t_r64_01.ali \
UNIT_TESTS/test.ali serial_io.ali
	./ada-bind UNIT_TESTS/t_r64_01.ali
	./ada-link UNIT_TESTS/t_r64_01 UNIT_TESTS/t_r64_01.ali

UNIT_TESTS/t_r64_01.ali:\
ada-compile UNIT_TESTS/t_r64_01.adb serial_io.ali UNIT_TESTS/test.ali
	./ada-compile UNIT_TESTS/t_r64_01.adb

UNIT_TESTS/t_r64_01.o:\
UNIT_TESTS/t_r64_01.ali

UNIT_TESTS/test.a:\
cc-slib UNIT_TESTS/test.sld UNIT_TESTS/test.o
	./cc-slib UNIT_TESTS/test UNIT_TESTS/test.o

UNIT_TESTS/test.ali:\
ada-compile UNIT_TESTS/test.adb UNIT_TESTS/test.ads
	./ada-compile UNIT_TESTS/test.adb

UNIT_TESTS/test.o:\
UNIT_TESTS/test.ali

ada-bind:\
conf-adabind conf-systype conf-adatype conf-adabflags conf-adafflist flags-cwd

ada-compile:\
conf-adacomp conf-adatype conf-systype conf-adacflags conf-adafflist flags-cwd

ada-link:\
conf-adalink conf-adatype conf-systype conf-adaldflags

ada-srcmap:\
conf-adacomp conf-adatype conf-systype

ada-srcmap-all:\
ada-srcmap conf-adacomp conf-adatype conf-systype

cc-compile:\
conf-cc conf-cctype conf-systype

cc-link:\
conf-ld conf-ldtype conf-systype

cc-slib:\
conf-systype

conf-adatype:\
mk-adatype
	./mk-adatype > conf-adatype.tmp && mv conf-adatype.tmp conf-adatype

conf-cctype:\
conf-cc mk-cctype
	./mk-cctype > conf-cctype.tmp && mv conf-cctype.tmp conf-cctype

conf-ldtype:\
conf-ld mk-ldtype
	./mk-ldtype > conf-ldtype.tmp && mv conf-ldtype.tmp conf-ldtype

conf-systype:\
mk-systype
	./mk-systype > conf-systype.tmp && mv conf-systype.tmp conf-systype

mk-adatype:\
conf-adacomp conf-systype

mk-cctype:\
conf-cc conf-systype

mk-ctxt:\
mk-mk-ctxt
	./mk-mk-ctxt

mk-ldtype:\
conf-ld conf-systype conf-cctype

mk-mk-ctxt:\
conf-cc conf-ld

mk-systype:\
conf-cc conf-ld

serial_io.ali:\
ada-compile serial_io.adb serial_io.ads
	./ada-compile serial_io.adb

serial_io.o:\
serial_io.ali

clean-all: obj_clean ext_clean
clean: obj_clean
obj_clean:
	rm -f UNIT_TESTS/t_16_01 UNIT_TESTS/t_16_01.ali UNIT_TESTS/t_16_01.o \
	UNIT_TESTS/t_32_01 UNIT_TESTS/t_32_01.ali UNIT_TESTS/t_32_01.o \
	UNIT_TESTS/t_64_01 UNIT_TESTS/t_64_01.ali UNIT_TESTS/t_64_01.o \
	UNIT_TESTS/t_r16_01 UNIT_TESTS/t_r16_01.ali UNIT_TESTS/t_r16_01.o \
	UNIT_TESTS/t_r32_01 UNIT_TESTS/t_r32_01.ali UNIT_TESTS/t_r32_01.o \
	UNIT_TESTS/t_r64_01 UNIT_TESTS/t_r64_01.ali UNIT_TESTS/t_r64_01.o \
	UNIT_TESTS/test.a UNIT_TESTS/test.ali UNIT_TESTS/test.o serial_io.ali \
	serial_io.o
ext_clean:
	rm -f conf-adatype conf-cctype conf-ldtype conf-systype mk-ctxt

regen:\
ada-srcmap ada-srcmap-all
	./ada-srcmap-all
	cpj-genmk > Makefile.tmp && mv Makefile.tmp Makefile
