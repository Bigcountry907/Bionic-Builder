#!/bin/sh

echo "-----------------------------"
echo `date`
echo "Hikey970 Updating:"

output="$(sudo fastboot devices)"
echo $output

output="$(sudo fastboot flash ptable 64gtoendprm_ptable.img)"
echo $output

output="$(sudo fastboot flash xloader sec_xloader.img)"
echo $output

output="$(sudo fastboot flash fastboot l-loader.bin)"
echo $output

output="$(sudo fastboot flash fip fip.bin)"
echo $output

output="$(sudo fastboot flash boot boot-hikey970.uefi.img)"
echo $output

output="$(sudo fastboot flash system ubuntu_bionic.hikey970.V-2.0.sparse.img)"
echo $output

echo "Update Done!"
