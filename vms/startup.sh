#!/usr/bin/bash
# starts the virtual machine with virsh. Useful if you just want
# to start the vm with a command without opening virt-man. Otherwise likely pointless.
VM_NAME=""
sudo virsh start $VM_NAME
