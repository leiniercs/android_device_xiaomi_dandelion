#
# Copyright (C) 2021 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/xiaomi/dandelion

# Build
BUILD_BROKEN_DUP_RULES := true
#BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
#BUILD_BROKEN_PREBUILT_ELF_FILES := true
BUILD_BROKEN_USES_BUILD_COPY_HEADERS := true
#BUILD_BROKEN_VINTF_PRODUCT_COPY_FILES := true

# Assert
TARGET_OTA_ASSERT_DEVICE := dandelion,dandelion_c3l2,dandelion_id2

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a53
TARGET_CPU_ABI_LIST := armeabi-v7a,armeabi
TARGET_CPU_ABI_LIST_32_BIT := armeabi-v7a,armeabi
TARGET_BOARD_SUFFIX := _32

# Platform
TARGET_BOARD_PLATFORM := mt6765
TARGET_BOARD_PLATFORM_GPU := POWERVR_GE8320

# Kernel
BOARD_BOOT_HEADER_VERSION := 2
BOARD_DTB_OFFSET := 0x07808000
BOARD_KERNEL_BASE := 0x40078000
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2 \
                        androidboot.init_fatal_reboot_target=bootloader
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_SECOND_OFFSET := 0x00e88000
BOARD_KERNEL_TAGS_OFFSET := 0x07808000
BOARD_RAMDISK_OFFSET := 0x11a88000
BOARD_MKBOOTIMG_ARGS += --base $(BOARD_KERNEL_BASE)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --second_offset $(BOARD_KERNEL_SECOND_OFFSET)
ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# Kernel prebuilt
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
# Kernel parameters for compilation
#BOARD_KERNEL_IMAGE_NAME := zImage
#BOARD_KERNEL_SEPARATED_DTBO := true
#TARGET_KERNEL_ARCH := $(TARGET_ARCH)
#TARGET_KERNEL_CONFIG := dandelion_defconfig
#TARGET_KERNEL_SOURCE := kernel/xiaomi/dandelion

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_DTBOIMG_PARTITION_SIZE := 8388608
BOARD_CACHEIMAGE_PARTITION_SIZE := 452984832
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_PARTITION_SIZE := 1490853888
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1490853888
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_PARTITION_SIZE := 118154574848
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

# Partitions (Dynamic)
BOARD_SUPER_PARTITION_SIZE := 4831838208
BOARD_SUPER_PARTITION_ERROR_LIMIT := 4831838208
BOARD_SUPER_PARTITION_GROUPS := main
BOARD_MAIN_SIZE := 3405828096
BOARD_MAIN_PARTITION_LIST := \
    product \
    system

# File systems
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := dandelion
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true

# Metadata
BOARD_ROOT_EXTRA_FOLDERS += metadata
BOARD_USES_METADATA_PARTITION := true

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_VBMETA_SYSTEM := system
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA2048
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

# Binder
TARGET_USES_64_BIT_BINDER := true

# Memory Config
MALLOC_SVELTE := true

# Recovery
TARGET_NO_RECOVERY := false
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.mt6765
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TARGET_RECOVERY_UI_BLANK_UNBLANK_ON_INIT := true
BOARD_INCLUDE_RECOVERY_DTBO := true
BOARD_USES_RECOVERY_AS_BOOT := false
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_HAS_LARGE_FILESYSTEM := true

# SELinux
include device/mediatek/sepolicy_vndr/SEPolicy.mk
TARGET_USES_PREBUILT_VENDOR_SEPOLICY := true
TARGET_HAS_FUSEBLK_SEPOLICY_ON_VENDOR := true

# Init
TARGET_INIT_VENDOR_LIB := //$(DEVICE_PATH):libinit_dandelion
TARGET_RECOVERY_DEVICE_MODULES := libinit_dandelion

# Display
TARGET_USES_HWC2 := true
TARGET_DISABLE_POSTRENDER_CLEANUP := true
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true

# DPI
TARGET_SCREEN_DENSITY := 270

# HWUI
HWUI_COMPILE_FOR_PERF := true

# Audio
USE_CUSTOM_AUDIO_POLICY := 1
USE_XML_AUDIO_POLICY_CONF := 1

# Treble
BUILD_WITHOUT_VENDOR := true
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM := system
TARGET_COPY_OUT_SYSTEM_EXT := system/system_ext
TARGET_COPY_OUT_VENDOR := vendor
BOARD_VNDK_VERSION := current
PRODUCT_FULL_TREBLE_OVERRIDE := true

# Network Routing
TARGET_IGNORES_FTP_PPTP_CONNTRACK_FAILURE := true

# APEX
DEXPREOPT_GENERATE_APEX_IMAGE := true

# Releasetools
TARGET_RELEASETOOLS_EXTENSIONS := $(DEVICE_PATH)

# Security patch level
#VENDOR_SECURITY_PATCH := 2021-08-01

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

# Inherit the proprietary files
#include vendor/xiaomi/dandelion/BoardConfigVendor.mk
