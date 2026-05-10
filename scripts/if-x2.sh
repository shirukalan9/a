# Cleanup
rm -rf device external tools hardware/ device/mediatek  vendor/mediatek hardware/mediatek android packages prebuilts prebuilt

# ROM Init
repo init -u https://github.com/ProjectInfinity-X/manifest -b 16 -g default,-mips,-darwin,-notdefault --depth=1 --git-lfs --no-repo-verify
/opt/crave/resync.sh

# Device 
git clone -b staging https://github.com/testingprjct/8dua device/infinix/X6882

# Build
source build/envsetup.sh
lunch infinity_X6882-user
m bacon -j$(nproc --all)
