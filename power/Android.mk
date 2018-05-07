LOCAL_PATH := $(call my-dir)

ifeq ($(call is-vendor-board-platform,QCOM),true)

# HAL module implemenation stored in
# hw/<POWERS_HARDWARE_MODULE_ID>.<ro.hardware>.so
include $(CLEAR_VARS)

LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_MULTILIB := both
LOCAL_SHARED_LIBRARIES := liblog libcutils libdl
LOCAL_SRC_FILES := power.c metadata-parser.c utils.c list.c hint-data.c

# Include target-specific files.
ifeq ($(call is-board-platform-in-list, msm8992), true)
LOCAL_SRC_FILES += power-8992.c
LOCAL_CFLAGS += -DMPCTLV3
endif

ifeq ($(TARGET_USES_INTERACTION_BOOST),true)
    LOCAL_CFLAGS += -DINTERACTION_BOOST
endif

LOCAL_MODULE := power.ether
LOCAL_MODULE_TAGS := optional
include $(BUILD_SHARED_LIBRARY)

endif
