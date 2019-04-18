cls

:start

@echo -----------------------------
@echo %date%-%time%
@echo "hikey970 Updating:"

fastboot flash xloader sec_xloader.img
	@if errorlevel 1 goto error

fastboot flash ptable 64gtoendprm_ptable.img
	@if errorlevel 1 goto error

fastboot flash fastboot l-loader.bin
	@if errorlevel 1 goto error

fastboot flash fip fip.bin
	@if errorlevel 1 goto error

fastboot flash boot boot-hikey970.uefi.img
	@if errorlevel 1 goto error

fastboot flash system ubuntu_bionic.hikey970.V-2.0.sparse.img
	@if errorlevel 1 goto error

@goto sucess

:error
@echo "Update Failed!"
@pause
@goto end

:sucess
@echo "Update Sucess"
@pause

:end