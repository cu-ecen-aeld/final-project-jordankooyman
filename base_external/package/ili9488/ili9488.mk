ILI9488_VERSION = adb8c24
ILI9488_SITE = git@github.com:jordankooyman/ili9488-userspace-driver.git
ILI9488_SITE_METHOD = git
ILI9488_GIT_SUBMODULES = YES

ILI9488_DEPENDENCIES = libgpiod

define ILI9488_BUILD_CMDS
    $(MAKE) $(TARGET_CONFIGURE_OPTS) \
        CFLAGS="$(TARGET_CFLAGS) -I../include" \
        LDFLAGS="$(TARGET_LDFLAGS) -lgpiod" \
        -C $(@D)/demo
endef

define ILI9488_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/demo/ili9488_demo $(TARGET_DIR)/usr/bin/ILI9488-demo
endef

$(eval $(generic-package))
