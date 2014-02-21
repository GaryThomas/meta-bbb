# Handle stray firmware files which now cause an error
do_install_append() {
    rm -fr ${D}/lib/firmware/korg
    rm -fr ${D}/lib/firmware/sb16
}

