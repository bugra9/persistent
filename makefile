INSTALL = /usr/bin/install -c
UNINSTALL = rm -f
MKDIR = mkdir -p

OPT_DIR = /opt
PROGRAM_DIR = ${OPT_DIR}/baslatan/initrd

build:
	test -d "dist" || $(MKDIR) "dist"

	for dir in $$(ls src) ; do \
		cd src/$$dir && find . | cpio --quiet -o -H newc | lzma -7 > ../../dist/$$dir.lz && cd ../.. ; \
  done

makedir:
	test -d "$(DESTDIR)${PROGRAM_DIR}" || $(MKDIR) "$(DESTDIR)${PROGRAM_DIR}"
	
install: makedir
	$(INSTALL) -m 644 -D dist/* "$(DESTDIR)$(PROGRAM_DIR)"

uninstall:
	-$(UNINSTALL) -r "$(DESTDIR)$(PROGRAM_DIR)"

clean:
	-$(UNINSTALL) -r dist
