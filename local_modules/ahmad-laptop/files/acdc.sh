#!/bin/bash

## Turn on and off power saving features.


plugin_b='0'
unplug_b='5'

plugin_p='max_performance'
unplug_p='min_power'

plugin_a='on'
unplug_a='auto'

function main() {
    case $1 in
        plugin|unplug)
            eval n=\$${1}_n
            eval p=\$${1}_p
            eval a=\$${1}_a

            echo $p | tee /sys/class/scsi_host/host*/link_power_management_policy
            echo $a | tee /sys/bus/pci/devices/*/power/control
            echo $a > /sys/bus/i2c/devices/i2c-1/device/power/control
            echo $b > /sys/module/snd_hda_intel/parameters/power_save
            ;;
        *)
            echo "Usage: $0 {plugin|unplug}"
            ;;
    esac
}

main $1
