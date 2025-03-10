##############################################################
#
# LDD
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
LDD_VERSION = '144d74a4c2420b603fde2fe6c90b8e412b4155c7'
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
LDD_SITE = 'git@github.com:cu-ecen-aeld/assignment-7-Darshan-ES.git'
LDD_SITE_METHOD = git
LDD_GIT_SUBMODULES = YES
LDD_MODULE_SUBDIRS = misc-modules scull



LDD_MODULE_MAKE_OPTS = \
    ARCH=$(KERNEL_ARCH) \
    KERNELDIR=$(LINUX_DIR) \
    KVERSION=$(LINUX_VERSION_PROBED) \
    EXTRA_CFLAGS="-I$(@D)/include"



# TODO add your writer, finder and finder-test utilities/scripts to the installation steps below
define LDD_INSTALL_TARGET_CMDS
	#install scull load unloaD
	for script in scull_load scull_unload; do \
         $(INSTALL) -m 755 $(@D)/scull/$$script $(TARGET_DIR)/usr/bin/$$script; \
        done
	#install module load unload
	for script in module_load module_unload; do \
         $(INSTALL) -m 755 $(@D)/misc-modules/$$script $(TARGET_DIR)/usr/bin/$$script; \
        done

	
	#install Kernel Modules
	$(INSTALL) -m 755 $(@D)/scull/scull.ko $(TARGET_DIR)/usr/bin/scull.ko
        $(INSTALL) -m 755 $(@D)/scull/scull.ko $(TARGET_DIR)/etc/init.d/scull.ko
        
        for module in faulty hello; do \
	  $(INSTALL) -m 755 $(@D)/misc-modules/$$module.ko $(TARGET_DIR)/usr/bin/$$module.ko; \
	  $(INSTALL) -m 755 $(@D)/misc-modules/$$module.ko $(TARGET_DIR)/etc/init.d/$$module.ko; \
	done
endef

$(eval $(kernel-module))
$(eval $(generic-package))
