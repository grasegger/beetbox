.PHONY: simulator ipod install clean configure

configure:
	mkdir -p build-ipod
	cd build-ipod && ../tools/configure --target=29 --type=na --prefix=$(shell findmnt -noTARGET "/dev/disk/by-uuid/DDF4-DA29") --rbdir=/beetbox

simulator:
	mkdir -p sim
	cd  sim && ../tools/configure --target=29 --type=s
	make -C sim -j 64


ipod: configure
	make -C build-ipod -j 64
	make -C build-ipod -j 64

install: ipod configure
	make -C build-ipod fullinstall -j 64
	sync

clean:
	rm -rf sim build*

dev:
	rm -rf $(HOME)/.local/bin/arm-elf*
	rm -rf /tmp/rbdev-build/*
	./tools/rockboxdev.sh --prefix=$(HOME)/.local --target=a --makeflags="-j 64"