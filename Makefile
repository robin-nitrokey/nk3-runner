BOARD :=
DEVELOP :=
PROVISIONER :=

.PHONY: check
check:
	make -C runners/lpc55 check BOARD=nk3xn
	make -C runners/lpc55 check BOARD=nk3xn DEVELOP=1
	make -C runners/lpc55 check BOARD=nk3xn PROVISIONER=1
	make -C runners/lpc55 check BOARD=nk3am
	make -C runners/lpc55 check BOARD=nk3am DEVELOP=1
	make -C runners/lpc55 check BOARD=nk3am PROVISIONER=1
