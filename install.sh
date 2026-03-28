#!/bin/bash

clear

RED='\033[1;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo
echo "                              ##     ## #### ##    ##  ######  ########  ##     ## "
echo "                              ###   ###  ##  ##   ##  ##    ## ##     ## ##     ## "
echo "                              #### ####  ##  ##  ##   ##       ##     ## ##     ## "
echo "                              ## ### ##  ##  #####    ##       ########  ##     ## "
echo "                              ##     ##  ##  ##  ##   ##       ##        ##     ## "
echo "                              ##     ##  ##  ##   ##  ##    ## ##        ##     ## "
echo "                              ##     ## #### ##    ##  ######  ##         #######"
echo

echo -e "\e[93m$(printf "%50s" "PRESENT  -  PRESENTA")\e[0m"

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

echo -e "\e[93m$(printf "%50s" "FOR - PER BATOCERA")\e[0m"
echo

echo
echo "Downloading MaximusBat Theme Configuration... - Download della configurazione del tema MaximusBat in corso..."
sleep 2

BASE="/userdata/roms"
TMP="/tmp/mbt_install"
URL="https://raw.githubusercontent.com/MIKCPU/Maximusbat-Install-Service-Batocera/main/mbt.zip"

# Controllo internet
if ! curl -fsSL --connect-timeout 5 https://api.github.com >/dev/null 2>&1; then
    echo -e "${RED}ERROR: No internet connection${NC}"
    exit 1
fi

# Controlli programmi
for cmd in curl unzip; do
    if ! command -v $cmd >/dev/null 2>&1; then
        echo -e "${RED}ERROR: $cmd not installed${NC}"
        exit 1
    fi
done

# Preparazione cartelle
mkdir -p "$TMP"
mkdir -p "$BASE/mbt"    # <- qui estraiamo tutto dentro mbt
cd "$TMP" || exit 1

echo
echo "Downloading installation package..."
if ! curl -L -o mbt.zip "$URL"; then
    echo -e "${RED}Download failed!${NC}"
    exit 1
fi

echo
echo "Extracting files into $BASE/mbt ..."
if ! unzip -o mbt.zip -d "$BASE/mbt"; then
    echo -e "${RED}Extraction failed!${NC}"
    exit 1
fi

echo
echo "Fixing script format and permissions..."
find "$BASE/mbt" -type f -name "*.sh" -exec sed -i 's/\r$//' {} \;
find "$BASE/mbt" -type f -name "*.sh" -exec chmod +x {} \;

echo
echo "Cleaning temporary files..."
rm -f mbt.zip

MBT_SCRIPT="$BASE/mbt/Install_Maximusbat.sh"

echo
echo "Running installer in terminal..."
if [ -f "$MBT_SCRIPT" ]; then
    chmod +x "$MBT_SCRIPT"
    # Avvio diretto nel terminale senza xterm
    cd "$BASE/mbt" && exec ./Install_Maximusbat.sh
    echo
    echo "Installation completed."
    rm -rf "$TMP"
    exit 0
else
    echo -e "${RED}Error: Install_Maximusbat.sh not found!${NC}"
    rm -rf "$TMP"
    exit 1
fi