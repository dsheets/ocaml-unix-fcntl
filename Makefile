.PHONY: build install uninstall reinstall clean

FINDLIB_NAME=unix-fcntl
MOD_NAME=unix_fcntl
BUILD=_build/lib

HAS_CTYPES := $(shell ocamlfind query ctypes.foreign fd-send-recv unix-sys-stat > /dev/null; echo $$?)

ifneq ($(HAS_CTYPES),0)
SRC=lib/no_ctypes
FLAGS=
EXTRA_META=
else
SRC=lib/ctypes
FLAGS=-package ctypes.foreign,fd-send-recv,unix-sys-stat
EXTRA_META=requires = \"ctypes.foreign fd-send-recv unix-sys-stat\"
endif

CFLAGS=-fPIC -Wall -Wextra -Werror -std=c99

build:
	mkdir -p $(BUILD)
	cc -c $(CFLAGS) -o $(BUILD)/$(MOD_NAME)_stubs.o lib/$(MOD_NAME)_stubs.c -I$(shell ocamlc -where)
	ocamlfind ocamlc -o $(BUILD)/$(MOD_NAME)_common.cmi -g \
		-c lib/$(MOD_NAME)_common.mli
	ocamlfind ocamlc -o $(BUILD)/$(MOD_NAME).cmi -g -I $(BUILD) -I lib \
		$(FLAGS) -c $(SRC)/$(MOD_NAME).mli
	ocamlfind ocamlmklib -o $(BUILD)/$(MOD_NAME) \
		-ocamlc "ocamlc -g" -ocamlopt "ocamlopt -g" -I $(BUILD) \
		$(FLAGS) lib/$(MOD_NAME)_common.ml $(SRC)/$(MOD_NAME).ml \
		$(BUILD)/$(MOD_NAME)_stubs.o

META: META.in
	cp META.in META
	echo $(EXTRA_META) >> META

install: META
	ocamlfind install $(FINDLIB_NAME) META \
		$(SRC)/$(MOD_NAME).mli \
		$(BUILD)/$(MOD_NAME).cmi \
		$(BUILD)/$(MOD_NAME).cma \
		$(BUILD)/$(MOD_NAME).cmxa \
		-dll $(BUILD)/dll$(MOD_NAME).so \
		-nodll $(BUILD)/lib$(MOD_NAME).a $(BUILD)/$(MOD_NAME).a

uninstall:
	ocamlfind remove $(FINDLIB_NAME)

reinstall: uninstall install

clean:
	rm -rf _build
	bash -c "rm -f lib/$(MOD_NAME)_common.{cm?,o} META"
	bash -c "rm -f lib/{ctypes,no_ctypes}/$(MOD_NAME).{cm?,o}"
