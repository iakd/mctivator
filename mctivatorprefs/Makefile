include theos/makefiles/common.mk

BUNDLE_NAME = mctivatorprefs
mctivatorprefs_FILES = mctivatorprefs.mm
mctivatorprefs_INSTALL_PATH = /Library/PreferenceBundles
mctivatorprefs_FRAMEWORKS = UIKit
mctivatorprefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/mctivatorprefs.plist$(ECHO_END)
