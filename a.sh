# Cleanup
rm -rf device/infinix vendor kernel/infinix hardware

# ROM
repo init -u https://github.com/AxionAOSP/android.git -b lineage-23.2 --depth=1 --git-lfs
/opt/crave/resync.sh
source build/envsetup.sh

---------------------------------------------------
# Device 
git clone -b axion https://github.com/zaidanprjkt/device_infinix_X6882 device/infinix/X6882
git clone https://github.com/zaidanprjkt/vendor_infinix_X6882-2 vendor/infinix/X6882

----------------------------------------------------
# Mediatek Specific
git clone -b sixteen-qpr2 https://github.com/MillenniumOSS/android_vendor_mediatek_ims vendor/mediatek/ims
git clone https://github.com/mt6789-transsion/hardware_transsion hardware/mediatek

-----------------------------------------------------
# Build
gk -s
axion X6882 user va
ax -br -j$(nproc)








