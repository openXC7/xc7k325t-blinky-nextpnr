# Full Open Source Blinky on XC7K325T using yosys+nextpnr-xilinx

## Blinky on QMTech XC7K325T Core Board (xc7k325tffg676-1)
![qmtech_blinky](https://user-images.githubusercontent.com/89043237/152394699-52cf5a22-5fd6-45b6-b9a2-3d2ca89d1fd0.gif)
- For guide to reproduce see list below
- Full size video: [https://user-images.githubusercontent.com/148607/152079511-89539119-5d66-42f2-a709-3e35a81d7c0f.mp4]
- Large image: https://user-images.githubusercontent.com/148607/152079663-e42ce6ed-66ef-461e-aed7-82a4e5667e39.png

## Blinky on Digilent Genesys2 (xc7k325tffg900-2)
![genesys2_blinky](https://user-images.githubusercontent.com/89043237/152396095-bc4dc672-1c3f-4a6a-8477-e953363d0f2f.gif)
- For proof of concept see branch *ring-oscillator*
- Full size video: https://user-images.githubusercontent.com/20798131/152385360-3e4f140e-cb57-4b04-bbc3-1ecd1d7374d5.mov
- Stable operation possible with external "PMOD" type oscillator module
- *Breaking:* Should now work with the default clock. Unfortunately I don't have the board, so please test if you have it and let us know!

## Blinky on the AliExpress STLV7325 board
![stlv7325_bliny](https://user-images.githubusercontent.com/148607/176101822-2fa0d7bd-d3f2-4e3c-99e2-0fc40e834ecf.mp4)
- works with differential clock input on the high performance banks

# Status
* works on the QMTech XC7K325T board
* works with differential clock input on the high performance banks on the STLV7325 board.
* limited functionality on Digilent Genesys2 and [Memblaze PBlaze 3 SSD](https://github.com/kintex-chatter/xc7k325t-blinky-nextpnr/issues/12)

# How to reproduce
1. Install required software
   - sudo apt install libftdi1-dev libudev-dev git cmake build-essential tclsh clang tcl-dev libreadline-dev flex bison python3-dev libboost-all-dev libqt5-base-dev-tools libeigen3-dev python3 python3-pip python3-yaml pypy3 pkg-config libqt5opengl5-dev
   - clone/build/install yosys from https://github.com/YosysHQ/yosys or download a release from https://github.com/YosysHQ/oss-cad-suite-build/releases
   note: test have been performed with Yosys 0.13+28 (git sha1 bf85dfee5, gcc 10.2.1-6 -fPIC -Os)
2. git clone --recurse-submodules https://github.com/kintex-chatter/xc7k325t-blinky-nextpnr.git
3. cd xc7k325t-blinky-nextpnr
4. make BOARD=qmtech setup
5. make BOARD=qmtech all

Note: Every time you change the installation of nextpnr-xilinx you will have to regenerate the chipdb,
because the chipdb does not seem to be compatible between different binaries of nextpnr-xilinx
