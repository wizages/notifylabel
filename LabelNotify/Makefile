ARCHS = armv7 arm64
include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = LabelNotify
LabelNotify_FILES = $(wildcard *.m) $(wildcard *.xm)
LabelNotify_INSTALL_PATH = /Library/PreferenceBundles
LabelNotify_FRAMEWORKS = UIKit Social
LabelNotify_PRIVATE_FRAMEWORKS = Preferences
LabelNotify_LIBRARIES = applist colorpicker
LabelNotify_EXTRA_FRAMEWORKS += CepheiPrefs Cephei

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/LabelNotify.plist$(ECHO_END)
