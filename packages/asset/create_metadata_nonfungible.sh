#!/bin/bash

# Function to create a JSON file
create_json_file() {
    local name="$1"
    local tier="$2"
    local index="$3"
    cat <<EOF >"${index}"
{
    "description": "${name^} ERC-721 character token from Forgotten Lands collection (${tier} tier)",   
    "image": "ipfs://QmdJQKDMTAfXLW97XHB9rrQGpQXbm8ev3tDoy7QSKd2fx2/${index}",
    "name": "${name^}",
    "attributes": [
        {
            "trait_type": "Tier",
            "value": "${tier}"
        }
    ]
}
EOF
}

# Characters and their tiers
characters=("Barbarian" "Demon" "Dwarf" "Elf" "Fire mage" "Huntress" "Lizardman" "Monk" "Warrior" "Viking")
tiers=("Regular" "Wooden" "Silver" "Golden")

# Loop to create files
for ((i=0; i<${#characters[@]}; i++)); do
    for ((j=0; j<${#tiers[@]}; j++)); do
        index=$((i*4 + j + 7))
        create_json_file "${characters[i]}" "${tiers[j]}" "$index"
    done
done

