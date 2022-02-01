#!/usr/bin/env bash
PROJECT_NAME=blinky
PREFIX=/usr/local/share
DB_DIR=$PREFIX/nextpnr/prjxray-db
CHIPDB_DIR=$PREFIX/nextpnr/xilinx-chipdb
PART=xc7k325tffg676-1

set -ex
yosys -p "synth_xilinx -flatten -abc9 -nobram -arch xc7 -top ${PROJECT_NAME}; write_json ${PROJECT_NAME}.json" ${PROJECT_NAME}.v
nextpnr-xilinx --chipdb ${CHIPDB_DIR}/${PART}.bin --xdc ${PROJECT_NAME}.xdc --json ${PROJECT_NAME}.json --write ${PROJECT_NAME}_routed.json --fasm ${PROJECT_NAME}.fasm --verbose --debug
fasm2frames --part ${PART} --db-root ${DB_DIR}/kintex7 ${PROJECT_NAME}.fasm > ${PROJECT_NAME}.frames
xc7frames2bit --part_file ${DB_DIR}/kintex7/${PART}/part.yaml --part_name ${PART} --frm_file ${PROJECT_NAME}.frames --output_file ${PROJECT_NAME}.bit
#To send to SRAM:
#openFPGALoader --board xxx ${PROJECT_NAME}.bit
#To send to FLASH:
#openFPGALoader --board xxx -f ${PROJECT_NAME}.bit
