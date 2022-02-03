#!/usr/bin/env bash
PROJECT_NAME=blinky
PREFIX=~/opt
PATH=$PATH:$PREFIX/nextpnr/bin
DB_DIR=$PREFIX/nextpnr/prjxray-db
CHIPDB_DIR=$PREFIX/nextpnr/xilinx-chipdb
# QMTech XC7K32T board
BOARD=qmtech
# Digilent Genesys2 board
# BOARD=genesys2

if [[ "$BOARD" == "qmtech" ]]
then
    PART=xc7k325tffg676-1
elif [[ "$BOARD" == "genesys2" ]]
then
    PART=xc7k325tffg900-2
else
    echo "No board selected. Please edit ${0}"
    exit 1
fi


set -ex
yosys -p "synth_xilinx -flatten -abc9 -nobram -arch xc7 -top ${PROJECT_NAME}; write_json ${PROJECT_NAME}.json" ${PROJECT_NAME}.v
nextpnr-xilinx --chipdb ${CHIPDB_DIR}/${PART}.bin --xdc ${PROJECT_NAME}-${BOARD}.xdc --json ${PROJECT_NAME}.json --write ${PROJECT_NAME}_routed.json --fasm ${PROJECT_NAME}.fasm --verbose --debug
source "${XRAY_DIR}/utils/environment.sh"
${XRAY_UTILS_DIR}/fasm2frames.py --part ${PART} --db-root ${DB_DIR}/kintex7 ${PROJECT_NAME}.fasm > ${PROJECT_NAME}.frames
echo ${XRAY_UTILS_DIR}
${XRAY_TOOLS_DIR}/xc7frames2bit --part_file ${DB_DIR}/kintex7/${PART}/part.yaml --part_name ${PART} --frm_file ${PROJECT_NAME}.frames --output_file ${PROJECT_NAME}.bit
#To send to SRAM:
#openFPGALoader --board xxx ${PROJECT_NAME}.bit
#To send to FLASH:
#openFPGALoader --board xxx -f ${PROJECT_NAME}.bit
