include $(TOPDIR)/rules.mk

PKG_NAME:=phantun
PKG_VERSION:=0.7.0
PKG_RELEASE:=2

PKG_BUILD_DIR:=$(BUILD_DIR)/phantun-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/hizukiayaka/phantun.git
PKG_SOURCE_VERSION:=d5a9eb0ac823631f91c1c6ced2119111acc36460

PKG_BUILD_DEPENDS:=rust/host
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include ../../../feeds/packages/rust/rust-package.mk

define Package/phantun-common
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Phantun Common Files
  URL:=https://github.com/dndx/phantun
  SUBMENU:=VPN
  DEPENDS:=+kmod-tun
  HIDDEN:=1
endef

define Package/phantun-common/description
  Common files for Phantun Client and Server.
endef

define Package/phantun-common/conffiles
/etc/config/phantun
endef

define Package/phantun-common/install
	$(INSTALL_DIR) \
	    $(1)/etc/init.d \
	    $(1)/etc/config

	$(INSTALL_BIN) files/phantun.init \
	    $(1)/etc/init.d/phantun

	$(INSTALL_CONF) files/phantun.config \
	    $(1)/etc/config/phantun
endef

define Package/phantun-client
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Phantun Client - A lightweight and fast UDP to TCP obfuscator
  URL:=https://github.com/dndx/phantun
  SUBMENU:=VPN
  DEPENDS:=+phantun-common
endef

define Package/phantun-client/description
  Phantun Client is a project that obfuscates UDP packets into TCP connections.
endef

define Package/phantun-client/install
	$(INSTALL_DIR) \
		$(1)/usr/sbin

	$(INSTALL_BIN) $$(PKG_INSTALL_DIR)/bin/client $(1)/usr/sbin/phantun-client
endef

define Package/phantun-server
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Phantun Server - A lightweight and fast UDP to TCP obfuscator
  URL:=https://github.com/dndx/phantun
  SUBMENU:=VPN
  DEPENDS:=+phantun-common
endef

define Package/phantun-server/description
  Phantun Server is a project that obfuscates UDP packets into TCP connections.
endef

define Package/phantun-server/install
	$(INSTALL_DIR) \
		$(1)/usr/sbin

	$(INSTALL_BIN) $$(PKG_INSTALL_DIR)/bin/server $(1)/usr/sbin/phantun-server
endef

define Build/Compile
    $(call Build/Compile/Cargo,phantun)
endef

$(eval $(call BuildPackage,phantun-common))
$(eval $(call BuildPackage,phantun-client))
$(eval $(call BuildPackage,phantun-server))
