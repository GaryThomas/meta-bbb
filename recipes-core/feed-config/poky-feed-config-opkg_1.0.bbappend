DESCRIPTION = "BeagleBoneBlack opkg feed configuration"

FEEDNAMEPREFIX ?= "INVALID"
FEEDURIPREFIX ?= "INVALID"

# This variable is only set for some targets that have sub-arch packages
MACHINE_SOCARCH ?= ""

do_compile_append() {
	if [ "${FEEDNAMEPREFIX}" != "INVALID" ]; then
	   for arch in all ${TUNE_PKGARCH} ${MACHINE_ARCH} ${MACHINE_SOCARCH}; do
	       if [ "x" != "x$arch" ]; then
                   echo "src/gz ${FEEDNAMEPREFIX}-$arch ${FEEDURIPREFIX}/$arch" >> $basefeedconf
               fi
	   done
	fi
}

