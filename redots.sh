#!/bin/bash

YELLOW='\033[38;5;214m'
GREEN='\033[38;5;142m'
BLUE='\033[38;5;109m'
RED='\033[38;5;167m'
NC='\033[0m'

echo -e "${BLUE}███ Starting Config Backup ███${NC}\n"

echo -e "${YELLOW}→ Creating config directories...${NC}"
mkdir -p i3 polybar kitty picom
echo -e "${GREEN}✔ Directories created${NC}\n"

echo -e "${YELLOW}→ Copying i3 config...${NC}"
if cp -f "$HOME/.config/i3/config" ./i3/config; then
    echo -e "${GREEN}✔ i3 config copied${NC}\n"
else
    echo -e "${RED}✖ Failed to copy i3 config${NC}\n"
fi

echo -e "${YELLOW}→ Copying polybar config...${NC}"
if cp -f /etc/polybar/config.ini ./polybar/config.ini; then
    echo -e "${GREEN}✔ polybar config copied${NC}\n"
else
    echo -e "${RED}✖ Failed to copy polybar config${NC}\n"
fi

echo -e "${YELLOW}→ Copying picom config...${NC}"
if cp -f "$HOME/picom/picom-animations/picom.sample.conf" ./picom/picom.conf; then
    echo -e "${GREEN}✔ picom config copied${NC}\n"
else
    echo -e "${RED}✖ Failed to copy picom config${NC}\n"
fi

echo -e "${YELLOW}→ Copying kitty config...${NC}"
if cp -f "$HOME/.config/kitty/kitty.conf" ./kitty/kitty.conf; then
    echo -e "${GREEN}✔ kitty config copied${NC}\n"
else
    echo -e "${RED}✖ Failed to copy kitty config${NC}\n"
fi

echo -e "${BLUE}███ Backup Process Complete ███${NC}\n"

read -p "Do you want to commit and push these changes? [y/N]: " confirm
confirm=$(echo "$confirm" | tr '[:upper:]' '[:lower:]')

if [[ "$confirm" == "y" || "$confirm" == "yes" ]]; then
    read -p "Enter commit message: " commit_msg
    cd /home/ronish/dev/dotfiles/
    git add .
    git commit -m "$commit_msg"
    git push
    cd -
fi
