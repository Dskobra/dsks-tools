#!/usr/bin/bash
# safely shuts down the virtual machine using virsh
# as using qemu/virt-man tends to not do so properly
# and creates issues when restarting/shutting down the host.
VM_NAME=""
sudo virsh shutdown $VM_NAME --mode acpi
