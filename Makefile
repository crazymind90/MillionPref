ARCHS = arm64e arm64 armv7 armv7s

THEOS_DEVICE_IP = 192.168.1.40

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MillionPref

MillionPref_FILES = Tweak.xm
MillionPref_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk


install3::
		install3.exec
 