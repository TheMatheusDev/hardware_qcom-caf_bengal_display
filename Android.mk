ifeq ($(call my-dir),$(call project-path-for,qcom-display))

sdm-libs := sdm/libs
display-hals := include $(sdm-libs)/utils $(sdm-libs)/core libdebug gpu_tonemapper

ifneq ($(TARGET_IS_HEADLESS), true)
    display-hals += libcopybit liblight hdmi_cec \
                    libdrmutils libhistogram drm.vendor
endif

ifneq ($(TARGET_DISABLE_MEMTRACK), true)
    display-hals += libmemtrack
endif

display-hals += gralloc
display-hals += sde-drm
display-hals += composer
display-hals += init

ifeq ($(call is-vendor-board-platform,QCOM),true)
    include $(call all-named-subdir-makefiles,$(display-hals))
else
ifneq ($(filter msm% apq%,$(TARGET_BOARD_PLATFORM)),)
    include $(call all-named-subdir-makefiles,$(display-hals))
endif
endif

endif
