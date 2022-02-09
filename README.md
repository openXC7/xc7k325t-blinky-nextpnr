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

# Status
* works on the QMTech XC7K325T board
* limited functionality on Digilent Genesys2

# How to reproduce
1. clone/build/install yosys from https://github.com/YosysHQ/yosys or download a release from https://github.com/YosysHQ/oss-cad-suite-build/releases
   note: test have been performed with Yosys 0.13+28 (git sha1 bf85dfee5, gcc 10.2.1-6 -fPIC -Os)
2. git clone https://github.com/kintex-chatter/xc7k325t-blinky-nextpnr.git
3. git clone --recurse-submodules https://github.com/kintex-chatter/nextpnr-xilinx.git
4. cd nextpnr-xilinx
5. git checkout xilinx-upstream
6. mkdir build
7. pushd build
8. cmake -DARCH=xilinx -DCMAKE_INSTALL_PREFIX=~/opt/nextpnr ..
9. make -j2 && make install
10. popd
11. pushd xilinx/external
12. rm -rf prjxray-db
13. git clone -b k325 https://github.com/kintex-chatter/prjxray-db.git
14. popd
15. python3 xilinx/python/bbaexport.py --device xc7k325tffg676-1 --bba xilinx/xc7k325tffg676-1.bba
16. build/bbasm -l xilinx/xc7k325tffg676-1.bba xilinx/xc7k325tffg676-1.bin
17. mkdir -p ~/opt/nextpnr/xilinx-chipdb
18. ln -s $PWD/xilinx/external/prjxray-db ~/opt/nextpnr/
19. cp xilinx/xc7k325tffg676-1.bin ~/opt/nextpnr/xilinx-chipdb/
20. Set XRAY_DIR to the path where Project Xray has been cloned and built
21. Change directory to this project
22. make

Note: Every time you change the installation of nextpnr-xilinx you will have to regenerate the chipdb,
because the chipdb does not seem to be compatible between different binaries of nextpnr-xilinx
