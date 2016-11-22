ARCHS = armv7 armv7s arm64
TARGET = iphone:clang:9.2:8.0
DEBUG = 0

GO_EASY_ON_ME = 1

include theos/makefiles/common.mk

TWEAK_NAME = MCtivator
MCtivator_FILES = Tweak.xm LAMCtivatorForwardSeekListener.xm LAMCtivatorBackwardSeekListener.xm LAMCtivatorForwardSkipListener.xm LAMCtivatorBackwardSkipListener.xm MCtivatorNextDataSource.xm MCtivatorPrevDataSource.xm MCtivatorLongNextDataSource.xm MCtivatorLongPrevDataSource.xm
MCtivator_LIBRARIES = activator objcipc
MCtivator_PRIVATE_FRAMEWORKS = MediaRemote


include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"
SUBPROJECTS += mctivatorprefs
SUBPROJECTS += mctivatormchook
include $(THEOS_MAKE_PATH)/aggregate.mk
