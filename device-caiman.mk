#
# SPDX-FileCopyrightText: 2021 The Android Open-Source Project
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-FileCopyrightText: The Calyx Institute
# SPDX-License-Identifier: Apache-2.0
#

# Always use scudo for memory allocator
PRODUCT_USE_SCUDO := true

# Build Type
ALCH3MY_BUILD_TYPE := Official

# Kernel
TARGET_LINUX_KERNEL_VERSION := 6.1
TARGET_KERNEL_DEVICE := caimito
TARGET_KERNEL_PATH := device/google/caimito-kernels
TARGET_KERNEL_DIR := $(TARGET_KERNEL_PATH)/6.1
TARGET_BOARD_KERNEL_HEADERS := $(TARGET_KERNEL_DIR)/kernel-headers
TARGET_PREBUILT_KERNEL := $(TARGET_KERNEL_DIR)/Image.lz4
LOCAL_KERNEL := $(TARGET_KERNEL_DIR)/Image.lz4

LOCAL_PATH := device/google/caimito

DEVICE_PACKAGE_OVERLAYS += device/google/caimito/caiman/overlay
DEVICE_PACKAGE_OVERLAYS += device/google/caimito/caiman/overlay-lineage
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
    DMServiceOverlayVendorCaiman \
    FrameworkResOverlayVendorCaiman \
    PixelDisplayServiceOverlayProductCaiman \
    PixelNfcOverlayCaiman \
    PixelUwbOverlayCT3 \
    SettingsCaimanOverlay \
    SettingsGoogleOverlayVendorCaiman \
    SystemUIGoogleOverlayVendorCaiman \
    Alch3mySettingsCaiman

PRODUCT_PACKAGES += \
    ApertureOverlayCaiman

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
	ro.quick_start.device_id=caiman \
	ro.product.brand_for_attestation=google \
	ro.product.device_for_attestation=caiman \
	ro.product.manufacturer_for_attestation=Google \
	ro.product.model_for_attestation=Pixel 9 Pro \
	ro.product.name_for_attestation=caiman \

PRODUCT_PROPERTY_OVERRIDES += \
	keyguard.no_require_sim=true \
	debug.sf.enable_sdr_dimming=1 \
	debug.sf.dim_in_gamma_in_enhanced_screenshots=1 \
	ro.hardware.keystore_desede=true \
	ro.hardware.keystore=trusty \
	ro.hardware.gatekeeper=trusty \
	persist.vendor.enable.thermal.genl=true \
	ro.incremental.enable=true \
	vendor.usb.product_string=Pixel 9 Pro

PRODUCT_SYSTEM_EXT_PROPERTIES += \
ro.hotword.detection_service_required=false

# Recovery
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/recovery/init.recovery.device.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.caiman.rc

PRODUCT_PACKAGES += \
    init.recovery.caimito.touch.rc

# Satellite
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/conf/allowlist_satellite.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/allowlist_satellite.xml \
    frameworks/native/data/etc/android.hardware.telephony.satellite.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.hardware.telephony.satellite.xml

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)

# Set support hide display cutout feature
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_hide_display_cutout=true

PRODUCT_PACKAGES += \
    NoCutoutOverlay \
    AvoidAppsInCutoutOverlay

# VINTF
DEVICE_PRODUCT_COMPATIBILITY_MATRIX_FILE += \
    $(DEVICE_PATH)/vintf/device_framework_matrix_product.xml

# Window extensions
$(call inherit-product, $(SRC_TARGET_DIR)/product/window_extensions.mk)

PRODUCT_PACKAGES += fir-proximity-feature.xml
