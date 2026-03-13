#!/bin/bash

clear

echo
echo "                              ##     ## #### ##    ##  ######  ########  ##     ## "
echo "                              ###   ###  ##  ##   ##  ##    ## ##     ## ##     ## "
echo "                              #### ####  ##  ##  ##   ##       ##     ## ##     ## "
echo "                              ## ### ##  ##  #####    ##       ########  ##     ## "
echo "                              ##     ##  ##  ##  ##   ##       ##        ##     ## "
echo "                              ##     ##  ##  ##   ##  ##    ## ##        ##     ## "
echo "                              ##     ## #### ##    ##  ######  ##         #######"
echo

echo -e "\e[93m                                          PRESENT  -  PRESENTA\e[0m"
echo

echo -e "\e[91m"
echo "           ##     ##    ###    ##     ## #### ##     ## ##     ##  ######  ########     ###    ######## "
echo "           ###   ###   ## ##    ##   ##   ##  ###   ### ##     ## ##    ## ##     ##   ## ##      ##    "
echo "           #### ####  ##   ##    ## ##    ##  #### #### ##     ## ##       ##     ##  ##   ##     ##    "
echo "           ## ### ## ##     ##    ###     ##  ## ### ## ##     ##  ######  ########  ##     ##    ##    "
echo "           ##     ## #########   ## ##    ##  ##     ## ##     ##       ## ##     ## #########    ##    "
echo "           ##     ## ##     ##  ##   ##   ##  ##     ## ##     ## ##    ## ##     ## ##     ##    ##    "
echo "           ##     ## ##     ## ##     ## #### ##     ##  #######   ######  ########  ##     ##    ##    "
echo -e "\e[0m"

echo
echo "Downloading MaximusBat Theme Configuration..."
sleep 2

BASE="/userdata/emulators"
TMP="/tmp/mbt_install"

mkdir -p "$TMP"
cd "$TMP"

echo
echo "Downloading installation package..."

curl -L -O https://raw.githubusercontent.com/MIKCPU/Maximusbat-Install-Service-Batocera/main/mbt.zip.001
curl -L -O https://raw.githubusercontent.com/MIKCPU/Maximusbat-Install-Service-Batocera/main/mbt.zip.002

echo

if [ ! -f mbt.zip.001 ]; then
echo "Error: mbt.zip.001 not downloaded."
exit 1
fi

if [ ! -f mbt.zip.002 ]; then
echo "Error: mbt.zip.002 not downloaded."
exit 1
fi

echo "Merging installation package..."

cat mbt.zip.001 mbt.zip.002 > mbt.zip

echo
echo "Extracting files..."

mkdir -p "$BASE"

unzip -o mbt.zip -d "$BASE"

echo
echo "Cleaning temporary files..."

rm mbt.zip mbt.zip.001 mbt.zip.002

MBT_SCRIPT="$BASE/mbt/Install_Maximusbat.sh"

echo
echo "Running installer..."

if [ -f "$MBT_SCRIPT" ]; then
chmod +x "$MBT_SCRIPT"
bash "$MBT_SCRIPT"
else
echo "Error: Install_Maximusbat.sh not found!"
exit 1
fi

echo
echo "Installation completed."

rm -rf "$TMP"