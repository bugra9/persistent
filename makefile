COPY =  cp -r -T
UNINSTALL = rm -r
MKDIR = mkdir -p



makedir:
	test -d "temp" || $(MKDIR) "temp"
	test -d "dist" || $(MKDIR) "dist"

	cd src && ls -1 | xargs -I file $(COPY) file "../temp/"

	cd temp && find . | cpio --quiet --dereference -o -H newc | lzma -7 > ../dist/bootableusb.lz
	-$(UNINSTALL) temp
	

clean:
	-$(UNINSTALL) dist
	-$(UNINSTALL) temp
