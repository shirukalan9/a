# Cleanup things
rm -rf device/infinix rm -rf hardware device/mediatek vendor/infinix frameworks build vendor/mediatek hardware/mediatek android packages bionic art tools prebuilt prebuilts

# Backup Keys
LOG="key_status.txt"
cp -r vendor/lineage-priv/keys /tmp/axion_keys_backup
[ -d "/tmp/axion_keys_backup" ] && echo "[OK] Backuping to /tmp/." > $LOG || echo "[FAIL] Backup Failed." > $LOG

# ROM
repo init --depth=1 --no-repo-verify --git-lfs -u https://github.com/ProjectInfinity-X/manifest -b 16 -g default,-mips,-darwin,-notdefault
/opt/crave/resync.sh

# Restore keys
mkdir -p vendor/lineage-priv/keys
cp -r /tmp/axion_keys_backup/* vendor/lineage-priv/keys/
[ -f "vendor/lineage-priv/keys/releasekey.pk8" ] && echo "[OK] Restore to vendor/ success." >> $LOG || echo "[FAIL] Restore failed." >> $LOG

---------------------------------------------------
# Device 
git clone -b lineage-23.0 https://github.com/shirukalan9/z device/infinix/X6882
git clone -b fixup https://gitlab.com/zaidannn7/vendor_infinix_X6882 vendor/infinix/X6882
git clone --depth=1 https://github.com/mt6789-transsion/device_infinix_X6882-kernel device/infinix/X6882-kernel
----------------------------------------------------
# Mediatek Specific
git clone --depth=1 -b sixteen-oem https://github.com/MillenniumOSS/android_vendor_mediatek_ims vendor/mediatek/ims
git clone --depth=1 https://github.com/MillenniumOSS/android_hardware_millennium hardware/millennium
git clone --depth=1 https://github.com/MillenniumOSS/android_device_mediatek_sepolicy_vndr device/mediatek/sepolicy_vndr
git clone --depth=1 https://github.com/MillenniumOSS/android_hardware_mediatek hardware/mediatek
-----------------------------------------------------

# Build
source build/envsetup.sh
lunch infinity_X6882-user
m bacon 
