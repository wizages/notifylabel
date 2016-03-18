ARCHS = armv7 arm64
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = labelnotify
labelnotify_FILES = Tweak.xm NotifyManager.m
labelnotify_LIBRARIES = colorpicker applist
labelnotify_FRAMEWORKS = QuartzCore
labelnotify_EXTRA_FRAMEWORKS += Cephei

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += LabelNotify
include $(THEOS_MAKE_PATH)/aggregate.mk
