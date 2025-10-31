.PHONY: simulator ipod install clean configure


configure:
	mkdir -p build-ipod
	cd build-ipod && ../tools/configure --target=29 --type=na --prefix=$(shell findmnt -noTARGET "/dev/disk/by-uuid/DDF4-DA29") --rbdir=/beetbox

simulator:
	mkdir -p sim
	cd  sim && ../tools/configure --target=29 --type=s
	make -C sim -j 16
	make -C sim fullinstall
	beet convert -f flac -d sim/simdisk/music -y --link
	./sim/rockboxui

ipod: configure
	make -C build-ipod -j 16
	make -C build-ipod -j 16 
	cd build-ipod && make -C ../tools ipod_fw

install: ipod configure
	make -C build-ipod fullinstall -j 16
	sudo ./utils/ipodpatcher/ipodpatcher build-ipod/rockbox.ipod
	sync

flash: install
	sudo dd if=build-ipod/rockbox.bin of=/dev/sdb1 bs=512

ipodpatcher:
	make -C ./utils/ipodpatcher

clean:
	rm -rf sim build*

dev:
	rm -rf $(HOME)/.local/bin/arm-elf*
	rm -rf /tmp/rbdev-build/*
	./tools/rockboxdev.sh --prefix=$(HOME)/.local --target=a --makeflags="-j 16"

# sector size 4096

fdisk:
	@echo "---------------------------"
	@cat template.fdisk | sed "s/##size##/$(shell echo $$((10 * 1024 * 1024 / 512)))/" \
	 | sed "s/##offset##/$(shell echo $$((10 * 1024 * 1024 / 512 + 63)))/" | tee script.fdisk
	@echo
	@echo "---------------------------"
	@echo "Now run sfdisk /dev/sdX < script.fdisk"

watch: 
	fd | entr make simulator