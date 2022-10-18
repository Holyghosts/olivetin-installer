#!/bin/bash

# Ensure running as root
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "ERROR  Not running as root!" 1>&2
    exit 1
fi

oliveTinDownload="$1"
tmpDir="/var/tmp/olivetin"

# Download and Extract Application
[[ -d "${tmpDir}" ]] || mkdir -p "${tmpDir}"
curl -Lo "${tmpDir}/OliveTin-2022-04-07-linux-amd64.tar.gz" "${oliveTinDownload}"
tar -xzf "${tmpDir}/OliveTin-2022-04-07-linux-amd64.tar.gz" -C "${tmpDir}"

# Install Application
cp "${tmpDir}/OliveTin-2022-04-07-linux-amd64/OliveTin" "/usr/local/bin/OliveTin"
! [[ -d "/var/www/olivetin" ]] || eval 'echo "web directory already exists, aborting" 1>&2; exit 1'
mkdir -p "/var/www/olivetin"
cp -R "${tmpDir}/OliveTin-2022-04-07-linux-amd64/webui/"* "/var/www/olivetin/"


# Create Example Configuration
! [[ -f "/etc/OliveTin/config.yaml" ]] || eval 'echo "configuration file already exists, aborting" 1>&2; exit 1'
mkdir -p "/etc/OliveTin"
cp -R "${tmpDir}/OliveTin-2022-04-07-linux-amd64/config.yaml" "/etc/OliveTin/config.yaml"

# Create Service File
! [[ -f "/etc/systemd/system/OliveTin.service" ]] || eval 'echo "service file already exists, aborting" 1>&2; exit 1'
cp -R "${tmpDir}/OliveTin-2022-04-07-linux-amd64/OliveTin.service" "/etc/systemd/system/OliveTin.service"

# Start Service and Enable on Reboot
systemctl daemon-reload
systemctl enable --now OliveTin

# Output Details for End User
echo    "Please be sure default port 1337 is open"