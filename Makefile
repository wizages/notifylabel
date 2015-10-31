ARCHS = armv7 arm64
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = labelnotify
labelnotify_FILES = Tweak.xm
labelnotify_LIBRARIES = colorpicker applist
labelnotify_FRAMEWORKS = QuartzCore

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += LabelNotify
include $(THEOS_MAKE_PATH)/aggregate.mk
