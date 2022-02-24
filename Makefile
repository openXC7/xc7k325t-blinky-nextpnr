PROJECT_NAME = blinky
PREFIX ?= ${HOME}/opt
DB_DIR = ${PREFIX}/nextpnr/prjxray-db
CHIPDB_DIR = ${PREFIX}/nextpnr/xilinx-chipdb
XRAY_DIR ?= ${PREFIX}/prjxray
NEXTPNR_DIR ?= ${PREFIX}/nextpnr
SHELL = /bin/bash
PYTHONPATH ?= ${XRAY_DIR}

# This workaround is only required for macOS, because Apple has explicitly disabled OpenMP support in their compilers.
ifeq ($(shell uname -s),Darwin)
NEXTPNR_BUILD_ENV = env CC=/usr/local/opt/llvm/bin/clang CXX=/usr/local/opt/llvm/bin/clang++ LDFLAGS="-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"
NEXTPNR_CMAKE_FLAGS = -DBUILD_GUI=0
endif

ifeq (${BOARD}, qmtech)
PART = xc7k325tffg676-1
else ifeq (${BOARD}, genesys2)
PART = xc7k325tffg900-2
PROG = openFPGALoader --cable digilent --bitstream blinky.bit --ftdi-channel 1
else
.PHONY: check
check:
	@echo "BOARD environment variable not set. Available boards:"
	@echo " * qmtech"
	@echo " * genesys2"
	@exit 1
endif

.PHONY: all
all: ${PROJECT_NAME}.bit
	${PROG}

${PROJECT_NAME}.json: ${PROJECT_NAME}.v
	yosys -p "synth_xilinx -flatten -abc9 -nobram -arch xc7 -top ${PROJECT_NAME}; write_json ${PROJECT_NAME}.json" $<

${PROJECT_NAME}.fasm: ${PROJECT_NAME}.json
	${NEXTPNR_DIR}/bin/nextpnr-xilinx --chipdb ${CHIPDB_DIR}/${PART}.bin --xdc ${PROJECT_NAME}-${BOARD}.xdc --json $< --write ${PROJECT_NAME}_routed.json --fasm $@ --verbose --debug

${PROJECT_NAME}.frames: ${PROJECT_NAME}.fasm
	prjxray/env/bin/fasm2frames --part ${PART} --db-root ${DB_DIR}/kintex7 $< > $@

${PROJECT_NAME}.bit: ${PROJECT_NAME}.frames
	${XRAY_DIR}/bin/xc7frames2bit --part_file ${DB_DIR}/kintex7/${PART}/part.yaml --part_name ${PART} --frm_file $< --output_file $@

.PHONY: setup
setup:
ifeq (${PART},)
	make check
endif
	${NEXTPNR_BUILD_ENV} cmake -S nextpnr-xilinx -B nextpnr-xilinx/build ${NEXTPNR_CMAKE_FLAGS} -DARCH=xilinx -DCMAKE_INSTALL_PREFIX=${NEXTPNR_DIR}
	make -C nextpnr-xilinx/build -j2 all
	make -C nextpnr-xilinx/build install
	if [ ! -f nextpnr-xilinx/xilinx/${PART}.bba ] ; then \
		cd nextpnr-xilinx ; \
		python3 xilinx/python/bbaexport.py --device ${PART} --bba xilinx/${PART}.bba ; \
	fi
	if [ ! -f nextpnr-xilinx/xilinx/${PART}.bin ] ; then \
		cd nextpnr-xilinx ; \
		build/bbasm -l xilinx/${PART}.bba xilinx/${PART}.bin ; \
	fi
	if [ ! -f ${NEXTPNR_DIR}/xilinx-chipdb/${PART}.bin ] ; then \
		mkdir -p ${NEXTPNR_DIR}/xilinx-chipdb ; \
		cp nextpnr-xilinx/xilinx/${PART}.bin ${NEXTPNR_DIR}/xilinx-chipdb/ ; \
	fi
	if [ ! -e ${NEXTPNR_DIR}/prjxray-db ] ; then \
		ln -s ${PWD}/nextpnr-xilinx/xilinx/external/prjxray-db ${NEXTPNR_DIR}/ ; \
	fi
	cmake -S prjxray -B prjxray/build -DCMAKE_INSTALL_PREFIX=${XRAY_DIR}
	make -C prjxray/build
	make -C prjxray/build install
	make -C prjxray env

.PHONY: clean
clean:
	@rm -f *.bit
	@rm -f *.frames
	@rm -f *.fasm
	@rm -f *.json

.PHONY: clobber
clobber:
	rm -rf nextpnr-xilinx/build
	rm -rf prjxray/build
	rm -rf prjxray/env
