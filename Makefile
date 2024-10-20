include $(TOPDIR)/rules.mk

PKG_NAME:=phantun
PKG_VERSION:=60f24d25633b078c3df436db371f44fa787817c2
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/phantun-$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/dndx/phantun.git
PKG_SOURCE_VERSION:=60f24d25633b078c3df436db371f44fa787817c2

PKG_BUILD_DEPENDS:=rust/host
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include ../../../feeds/packages/rust/rust-package.mk

define Package/phantun
  SECTION:=net
  CATEGORY:=Network
  TITLE:=A lightweight and fast UDP to TCP obfuscator
  URL:=https://github.com/dndx/phantun
  SUBMENU:=VPN
  DEPENDS:=+kmod-tun
endef

define Package/phantun/description
  Phantun is a project that obfuscated UDP packets into TCP connections.
endef

define Package/phantun/conffiles
/etc/config/phantun
endef

define Package/phantun/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $$(PKG_INSTALL_DIR)/bin/client $(1)/usr/sbin/phantun-client
endef

Build/Compile=$(call Build/Compile/Cargo,phantun)

$(eval $(call RustBinPackage,phantun))
$(eval $(call BuildPackage,phantun))
