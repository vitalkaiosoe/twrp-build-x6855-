#!/bin/bash
# === OrangeFox/TWRP build script for Infinix Note 50 Pro 4G (X6855) ===
# Tested for Ubuntu / Debian / WSL2

set -e

echo "=== Установка зависимостей ==="
sudo apt update
sudo apt install -y git make python3 openjdk-11-jdk bc bison flex gperf build-essential zip curl repo ccache

echo "=== Создание рабочего каталога ==="
mkdir -p ~/twrp_x6855
cd ~/twrp_x6855

echo "=== Инициализация репозитория OrangeFox (Android 12.1) ==="
repo init -u https://gitlab.com/OrangeFox/manifest.git -b fox_12.1
repo sync -j$(nproc)

echo "=== Добавление исходников устройства ==="
mkdir -p device/infinix/Infinix-X6855

# --- если твои файлы в той же папке, где этот скрипт ---
cp ../twrp-device_infinix_Infinix-X6855-fox_12.1-xos15\ \(1\).zip . || true
unzip -o twrp-device_infinix_Infinix-X6855-fox_12.1-xos15\ \(1\).zip -d device/infinix/Infinix-X6855/

# --- добавь вспомогательные файлы ---
cp ../vendorsetup.sh device/infinix/Infinix-X6855/
cp ../twrp_X6855.mk device/infinix/Infinix-X6855/
cp ../dtb.img device/infinix/Infinix-X6855/

echo "=== Настройка окружения ==="
source build/envsetup.sh

echo "=== Выбор устройства ==="
lunch twrp_X6855-eng

echo "=== Начало сборки recovery.img ==="
mka recoveryimage

echo "=== Сборка завершена! ==="
echo "Ищи готовый образ по пути:"
echo "~/twrp_x6855/out/target/product/X6855/recovery.img"