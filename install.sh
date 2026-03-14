```bash
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
echo "Downloading MaximusBat Theme Configuration..."
sleep 2

BASE="/userdata/emulators"
TMP="/tmp/mbt_install"
URL="https://raw.githubusercontent.com/MIKCPU/Maximusbat-Install-Service-Batocera/main/mbt.zip"

# controllo connessione internet
if ! curl -fsSL --connect-timeout 5 https://api.github.com >/dev/null 2>&1; then
    echo -e "${RED}ERROR: No internet connection${NC}"
    echo -e "${RED}ERRORE: Nessuna connessione internet${NC}"
    exit 1
fi

# controllo programmi necessari
if ! command -v curl >/dev/null 2>&1; then
    echo -e "${RED}ERROR: curl not installed${NC}"
    exit 1
fi

if ! command -v unzip >/dev/null 2>&1; then
    echo -e "${RED}ERROR: unzip not installed${NC}"
    exit 1
fi

# cartella temporanea
mkdir -p "$TMP"
cd "$TMP" || exit 1

echo
echo "Downloading installation package..."

if ! curl -L -o mbt.zip "$URL"; then
    echo -e "${RED}Download failed!${NC}"
    exit 1
fi

if [ ! -f mbt.zip ]; then
    echo -e "${RED}Error: mbt.zip not downloaded.${NC}"
    exit 1
fi

echo
echo "Extracting files..."

mkdir -p "$BASE"

if ! unzip -o mbt.zip -d "$BASE"; then
    echo -e "${RED}Extraction failed!${NC}"
    exit 1
fi

echo
echo "Cleaning temporary files..."

rm -f mbt.zip

MBT_SCRIPT="$BASE/mbt/Install_Maximusbat.sh"

echo
echo "Running installer..."

if [ -f "$MBT_SCRIPT" ]; then
    chmod +x "$MBT_SCRIPT"
    bash "$MBT_SCRIPT"
else
    echo -e "${RED}Error: Install_Maximusbat.sh not found!${NC}"
    exit 1
fi

echo
echo "Installation completed."

rm -rf "$TMP"
```
