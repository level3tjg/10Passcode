TARGET := iphone:clang:latest:11.0
INSTALL_TARGET_PROCESSES = SpringBoard

ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = 10Passcode

$(TWEAK_NAME)_FILES = Tweak.x
$(TWEAK_NAME)_CFLAGS = -fobjc-arc
$(TWEAK_NAME)_FRAMEWORKS = CoreText
$(TWEAK_NAME)_PRIVATE_FRAMEWORKS = TelephonyUI

include $(THEOS_MAKE_PATH)/tweak.mk
