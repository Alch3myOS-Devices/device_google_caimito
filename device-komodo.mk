#
# SPDX-FileCopyrightText: 2021 The Android Open-Source Project
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-FileCopyrightText: The Calyx Institute
# SPDX-License-Identifier: Apache-2.0
#

# GMS/GAPPS
WITH_GMS := true

TARGET_SUPPORTED_REFRESH_RATES := 60,120

SURFACE_FLINGER_BOOST := true
$(call soong_config_set,surfaceflinger,frame_rate_category_high,120)
$(call soong_config_set,surfaceflinger,frame_rate_category_min,60)

# Always use scudo for memory allocator
PRODUCT_USE_SCUDO := true

TARGET_OPTIMIZED_DEXOPT := true

# Build Pixel Launcher
TARGET_INCLUDE_PIXEL_LAUNCHER := true

# Include Google Telephony
WITH_GMS_COMMS_SUITE := true

# Include BCR
WITH_BCR := true

# Include Chargeing Bypass
BYPASS_CHARGE_SUPPORTED := true

# Supports HBM
HBM_SUPPORTED := true
HBM_NODE := /sys/class/backlight/panel0-backlight/hbm_mode

# Kernel
TARGET_LINUX_KERNEL_VERSION := 6.1
TARGET_KERNEL_DEVICE := caimito
TARGET_KERNEL_PATH := device/google/caimito-kernels
TARGET_KERNEL_DIR := $(TARGET_KERNEL_PATH)/6.1
TARGET_BOARD_KERNEL_HEADERS := $(TARGET_KERNEL_DIR)/kernel-headers
TARGET_PREBUILT_KERNEL := $(TARGET_KERNEL_DIR)/Image.lz4
LOCAL_KERNEL := $(TARGET_KERNEL_DIR)/Image.lz4

LOCAL_PATH := device/google/caimito

DEVICE_PACKAGE_OVERLAYS += device/google/caimito/komodo/overlay
DEVICE_PACKAGE_OVERLAYS += device/google/caimito/komodo/overlay-lineage
DEVICE_PACKAGE_OVERLAYS += device/google/caimito/overlay-lineage

# Shipping API level
SHIPPING_API_LEVEL := 34

# Inherit from zumapro
include device/google/zumapro/common.mk

# Overlays
PRODUCT_PACKAGES += \
    ConnectivityResourcesOverlayCaimitoOverride \
    FrameworkResOverlayProductCaimito \
    FrameworkResOverlayVendorCaimito \
    PixelNfcOverlayCaimito \
    PixelWifiOverlay2024Caimito \
    SafetyRegulatoryInfoOverlayProductCaimito \
    SettingsGoogleOverlayProductCaimito \
    SystemUIGoogleOverlayVendorCaimito \
    TeleServiceOverlayVendorCaimito \
    TelecomOverlayProductCaimito

PRODUCT_PACKAGES += \
    DMServiceOverlayVendorKomodo \
    FrameworkResOverlayVendorKomodo \
    PixelDisplayServiceOverlayProductKomodo \
    PixelNfcOverlayKomodo \
    PixelUwbOverlayCT3 \
    SettingsGoogleOverlayVendorKomodo \
    SettingsKomodoOverlay \
    SystemUIGoogleOverlayVendorKomodo \
    Alch3mySettingsKomodo

PRODUCT_PACKAGES += \
    ApertureOverlayKomodo

# PowerShare
include hardware/google/pixel/powershare/device.mk

# Properties
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/$(DEVICE_CODENAME)/product.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/$(DEVICE_CODENAME)/vendor.prop

PRODUCT_PRODUCT_PROPERTIES += \
	ro.opa.eligible_device=true \
	ro.com.google.clientidbase=android-google \
	ro.com.google.ime.theme_id=5 \
	ro.com.google.ime.system_lm_dir=/product/usr/share/ime/google/d3_lms \
	ro.support_one_handed_mode=true \
	ro.quick_start.device_id=komodo \
	ro.product.brand_for_attestation=google \
	ro.product.device_for_attestation=komodo \
	ro.product.manufacturer_for_attestation=Google \
	ro.product.model_for_attestation=Pixel 9 Pro XL \
	ro.product.name_for_attestation=komodo \

PRODUCT_PROPERTY_OVERRIDES += \
	keyguard.no_require_sim=true \
	debug.sf.enable_sdr_dimming=1 \
	debug.sf.dim_in_gamma_in_enhanced_screenshots=1 \
	ro.hardware.keystore_desede=true \
	ro.hardware.keystore=trusty \
	ro.hardware.gatekeeper=trusty \
	persist.vendor.enable.thermal.genl=true \
	ro.incremental.enable=true \
	vendor.usb.product_string=Pixel 9 Pro XL

PRODUCT_SYSTEM_EXT_PROPERTIES += \
ro.hotword.detection_service_required=false

# Recovery
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/recovery/init.recovery.device.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.komodo.rc

PRODUCT_PACKAGES += \
    init.recovery.caimito.touch.rc

# Satellite
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/conf/allowlist_satellite.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/allowlist_satellite.xml \
    frameworks/native/data/etc/android.hardware.telephony.satellite.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.hardware.telephony.satellite.xml

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)

# VINTF
DEVICE_PRODUCT_COMPATIBILITY_MATRIX_FILE += \
    $(DEVICE_PATH)/vintf/device_framework_matrix_product.xml

# Window extensions
$(call inherit-product, $(SRC_TARGET_DIR)/product/window_extensions.mk)
