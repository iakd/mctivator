ARCHS = armv7 armv7s arm64
TARGET = iphone:clang:9.2:8.0
DEBUG = 0

GO_EASY_ON_ME = 1

include theos/makefiles/common.mk

TWEAK_NAME = MCtivatorMCHook
MCtivatorMCHook_FILES = Tweak.xm
MCtivatorMCHook_FRAMEWORKS = UIKit
MCtivatorMCHook_PRIVATE_FRAMEWORKS = MediaRemote
MCtivatorMCHook_LIBRARIES = activator objcipc

include $(THEOS_MAKE_PATH)/tweak.mk