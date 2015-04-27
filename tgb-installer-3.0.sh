#!/bin/bash

#install needed software from apt
sudo apt-get install -y git

#remove any existing files

#create folders for install and enter make folder
sudo mkdir /home/pi/tgbdual
sudo mkdir /opt/retropie/libretrocores/lr-tgbdual/

cd /home/pi/tgbdual

#Git clone makefiles and enter directory
sudo git clone https://github.com/libretro/tgbdual-libretro
cd tgbdual-libretro

#Build binaries
sudo make

#Copy binary to libretro cores folder
sudo cp tgbdual_libretro.so /opt/retropie/libretrocores/lr-tgbdual/

#Add tgbdual to the GB load script
sudo sed -i -e 's|default="lr-gambatte"|lr-tgbdual="/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-tgbdual/tgbdual_libretro.so --config /opt/retropie/configs/gb/retroarch.cfg %ROM%"\ndefault="lr-gambatte"|g' /opt/retropie/configs/gb/emulators.cfg


#Enable tgbdual
#sudo echo "tgbdual_gblink_enable = enabled" >> /opt/retropie/configs/all/retroarch-core-options.cfg - permissions not available to run this command. Use below:
echo 'tgbdual_gblink_enable = enabled' | sudo tee --append /opt/retropie/configs/all/retroarch-core-options.cfg > /dev/null

#cleanup
sudo rm -rf /home/pi/tgbdual
