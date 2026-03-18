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
echo "Downloading MaximusBat Theme Configuration... - Download della configurazione del tema MaximusBat in corso..."
sleep 2

BASE="/userdata/emulators"
TMP="/tmp/mbt_install"
URL="https://raw.githubusercontent.com/MIKCPU/Maximusbat-Install-Service-Batocera/main/mbt.zip"

if ! curl -fsSL --connect-timeout 5 https://api.github.com >/dev/null 2>&1; then
    echo -e "${RED}ERROR: No internet connection${NC}"
    echo -e "${RED}ERRORE: Nessuna connessione internet${NC}"
    exit 1
fi

if ! command -v curl >/dev/null 2>&1; then
    echo -e "${RED}ERROR: curl not installed${NC}"
    exit 1
fi

if ! command -v unzip >/dev/null 2>&1; then
    echo -e "${RED}ERROR: unzip not installed${NC}"
    exit 1
fi

mkdir -p "$TMP"
cd "$TMP" || exit 1

echo
echo "Downloading installation package... - Download del pacchetto di installazione in corso..."

if ! curl -L -o mbt.zip "$URL"; then
    echo -e "${RED}Download failed!${NC}"
    exit 1
fi

if [ ! -f mbt.zip ]; then
    echo -e "${RED}Error: mbt.zip not downloaded.${NC}"
    exit 1
fi

echo
echo "Extracting files... - Estrazione dei file in corso..."

mkdir -p "$BASE"

if ! unzip -o mbt.zip -d "$BASE"; then
    echo -e "${RED}Extraction failed!${NC}"
    exit 1
fi

echo
echo "Fixing script format... - Correzione del formato dello script..."
find "$BASE/mbt" -type f -name "*.sh" -exec sed -i 's/\r$//' {} \;

chmod +x "$BASE/mbt"/*.sh 2>/dev/null
chmod +x "$BASE/mbt/Script"/*.sh 2>/dev/null

echo
echo "Cleaning temporary files... - Pulizia dei file temporanei..."

rm -f mbt.zip

MBT_SCRIPT="$BASE/mbt/Install_Maximusbat.sh"

echo
echo "Running installer... - Avvio del programma di installazione in corso..."

if [ -f "$MBT_SCRIPT" ]; then
    chmod +x "$MBT_SCRIPT"
    echo "Opening installer in xterm... - Apertura installer in xterm..."
    xterm -bg black -fg white -e "$MBT_SCRIPT" &
    echo
    echo "Installation completed. - Installazione completata."
    rm -rf "$TMP"
    exit 0
else
    echo -e "${RED}Error: Install_Maximusbat.sh not found!${NC}"
    rm -rf "$TMP"
    exit 1
fi
```
