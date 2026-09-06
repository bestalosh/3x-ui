#!/bin/bash
echo -e "\nDownloading x-ui custom release from GitHub..."

# دانلود فایل زیپ از بخش Release شما
wget -N --no-check-certificate -O x-ui.zip "https://github.com/bestalosh/3x-ui/releases/download/v1.0/x-ui.zip"

if [[ $? -ne 0 ]]; then
    echo "Failed to download the release. Check the URL or make sure the repo is Public."
    exit 1
fi

unzip -o x-ui-custom.zip
cd x-ui

echo -e "\nSelect Xray Core type:"
echo "1) Standard Xray Core"
echo "2) Custom Protected Xray Core"
read -p "Choose option [1 or 2] (Default: 2): " core_choice
[[ -z "${core_choice}" ]] && core_choice="2"

if [[ "$core_choice" == "1" ]]; then
    echo "Preparing Standard Core..."
    mv bin/xray-standard bin/xray-linux-arm64
    rm -f bin/xray-custom
else
    echo "Preparing Custom Protected Core..."
    mv bin/xray-custom bin/xray-linux-arm64
    rm -f bin/xray-standard
fi

chmod +x x-ui
./x-ui install

cd ..
rm -rf x-ui.zip x-ui
echo -e "\nInstallation finished successfully."
