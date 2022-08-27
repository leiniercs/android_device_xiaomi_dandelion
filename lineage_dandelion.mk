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

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

# Build flags
TARGET_BOOT_ANIMATION_RES := 720
#TARGET_FACE_UNLOCK_SUPPORTED := true
#TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_INCLUDE_LIVE_WALLPAPERS := true
#TARGET_NO_RECOVERY := true
TARGET_USES_BLUR := true
TARGET_SUPPORTS_QUICK_TAP := true
TARGET_SUPPORTS_GOOGLE_RECORDER := true

# Inherit from AOSP
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from garden device makefile
$(call inherit-product, $(LOCAL_PATH)/device.mk)

# Device identifier. This must come after all inclusions.
PRODUCT_NAME := lineage_dandelion
PRODUCT_DEVICE := dandelion
PRODUCT_BRAND := Redmi
PRODUCT_MANUFACTURER := xiaomi

# Build info
TARGET_VENDOR := xiaomi
TARGET_VENDOR_PRODUCT_NAME := dandelion
# [device]-[build_variant] [android_version] [android_version_id] [sdk_platform_version] [key_type]
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="raven-user 12 SQ3A.220705.004 8233519 release-keys"

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
# 'vendor_load_properties()' function on 'init/init_dandelion.cpp' must be updated with Android Version ID
BUILD_FINGERPRINT := google/raven/raven:12/SQ3A.220705.004/8233519:user/release-keys

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)
