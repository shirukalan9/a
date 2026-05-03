# Cleanup things
rm -rf device/infinix tools hardware/lineage/compat device/mediatek vendor/infinix vendor/mediatek hardware/mediatek android packages prebuilts prebuilt

# Backup Keys
LOG="key_backup.log"
BACKUP_FILE="keys_backup.tar.gz"

{
    echo "Backup keys..."
    tar czf "$BACKUP_FILE" vendor/lineage-priv/keys/
    echo "Created: $BACKUP_FILE ($(du -h "$BACKUP_FILE" | cut -f1))"
    echo "Files: $(tar tzf "$BACKUP_FILE" | wc -l)"

    UPLOAD_URL=$(curl -s -T "$BACKUP_FILE" https://bashupload.app)
    [ -z "$UPLOAD_URL" ] && { echo "ERROR: Upload failed"; exit 1; }
    echo "URL: $UPLOAD_URL"

    repo init -u https://github.com/AxionAOSP/android.git -b lineage-23.2 --depth=1 --git-lfs
    /opt/crave/resync.sh

    mkdir -p vendor/lineage-priv/keys
    curl -L "$UPLOAD_URL" -o /tmp/keys_restore.tar.gz
    tar xzf /tmp/keys_restore.tar.gz -C vendor/lineage-priv/keys/ --strip-components=1

    [ -f "vendor/lineage-priv/keys/releasekey.pk8" ] || { echo "ERROR: Restore failed"; exit 1; }

} | tee "$LOG"

source build/envsetup.sh
---------------------------------------------------
# Device 
git clone -b axion-16.2 https://github.com/zaidannn7/b device/infinix/X6882
git clone --depth=1 -b lineage-23.2 https://gitlab.com/zaidannn7/vendor_infinix_X6882 vendor/infinix/X6882
git clone --depth=1 https://github.com/zaidannn7/device_infinix_X6882-kernel device/infinix/X6882-kernel
----------------------------------------------------
# Mediatek Specific
git clone --depth=1 -b sixteen-oem https://github.com/MillenniumOSS/android_vendor_mediatek_ims vendor/mediatek/ims
git clone --depth=1 https://github.com/MillenniumOSS/android_hardware_millennium hardware/millennium
git clone --depth=1 https://github.com/MillenniumOSS/android_device_mediatek_sepolicy_vndr device/mediatek/sepolicy_vndr
git clone --depth=1 https://github.com/MillenniumOSS/android_hardware_mediatek hardware/mediatek
git clone https://github.com/MillenniumOSS/android_device_millennium_common-kernel device/millennium/common-kernel
-----------------------------------------------------
export BUILD_USERNAME=zaidannn7
export BUILD_HOSTNAME=android
export KBUILD_BUILD_NAME=zaidannn7
export KBUILD_BUILD_HOST=android

rm a.py
wget -q https://raw.githubusercontent.com/shirukalan9/anooo/refs/heads/main/a.py 
python3 a.py || exit 1


# Build
axion X6882 user pico
ax -br -j$(nproc)








