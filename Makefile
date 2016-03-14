.PHONY: build test install uninstall reinstall clean

FINDLIB_NAME=unix-fcntl
MOD_NAME=unix_fcntl

OCAML_LIB_DIR=$(shell ocamlc -where)

CTYPES_LIB_DIR=$(shell ocamlfind query ctypes)

LWT_LIB_DIR=$(shell ocamlfind query lwt)

OCAMLBUILD=CTYPES_LIB_DIR=$(CTYPES_LIB_DIR)	\
           OCAML_LIB_DIR=$(OCAML_LIB_DIR)	\
           LWT_LIB_DIR=$(LWT_LIB_DIR)		\
             ocamlbuild -use-ocamlfind -classic-display

WITH_UNIX=$(shell ocamlfind query ctypes unix > /dev/null 2>&1 ; echo $$?)
WITH_LWT=$(shell ocamlfind query lwt threads > /dev/null 2>&1 ; echo $$?)

TARGETS=.cma .cmxa

PRODUCTS=$(addprefix fcntl,$(TARGETS))

ifeq ($(WITH_UNIX), 0)
PRODUCTS+=$(addprefix $(MOD_NAME),$(TARGETS)) \
          lib$(MOD_NAME)_stubs.a dll$(MOD_NAME)_stubs.so \
          fcntl_map.byte
endif

ifeq ($(WITH_LWT), 0)
PRODUCTS+=$(addprefix $(MOD_NAME)_lwt,$(TARGETS)) \
          lib$(MOD_NAME)_lwt_stubs.a dll$(MOD_NAME)_lwt_stubs.so
endif

TYPES=.mli .cmi .cmti

INSTALL:=$(addprefix fcntl,$(TYPES)) \
         $(addprefix fcntl_host,$(TYPES)) \
         $(addprefix fcntl,$(TARGETS))

INSTALL:=$(addprefix _build/lib/,$(INSTALL))

ifeq ($(WITH_UNIX), 0)
INSTALL_UNIX:=$(addprefix fcntl_unix,$(TYPES)) \
              $(addprefix $(MOD_NAME),$(TARGETS))

INSTALL_UNIX:=$(addprefix _build/unix/,$(INSTALL_UNIX))

INSTALL+=$(INSTALL_UNIX)
endif

ifeq ($(WITH_LWT), 0)
INSTALL_LWT:=$(addprefix fcntl_unix_lwt,$(TYPES)) \
             $(addprefix $(MOD_NAME)_lwt,$(TARGETS))

INSTALL_LWT:=$(addprefix _build/lwt/,$(INSTALL_LWT))

INSTALL+=$(INSTALL_LWT)
endif

ARCHIVES:=_build/lib/fcntl.a

ifeq ($(WITH_UNIX), 0)
ARCHIVES+=_build/unix/$(MOD_NAME).a
endif

ifeq ($(WITH_LWT), 0)
ARCHIVES+=_build/lwt/$(MOD_NAME)_lwt.a
endif

build:
	$(OCAMLBUILD) $(PRODUCTS)

test: build
	$(OCAMLBUILD) lwt_test/test.native
	./test.native

install:
	ocamlfind install $(FINDLIB_NAME) META \
		$(INSTALL) \
                -dll _build/unix/dll$(MOD_NAME)_stubs.so \
                -nodll _build/unix/lib$(MOD_NAME)_stubs.a \
                -dll _build/lwt/dll$(MOD_NAME)_lwt_stubs.so \
                -nodll _build/lwt/lib$(MOD_NAME)_lwt_stubs.a \
		$(ARCHIVES)

uninstall:
	ocamlfind remove $(FINDLIB_NAME)

reinstall: uninstall install

clean:
	ocamlbuild -clean
	rm -f lib/fcntl.cm? unix/fcntl_unix.cm? \
	      lib/fcntl.o unix/fcntl_unix.o
