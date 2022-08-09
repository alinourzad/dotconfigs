#!/bin/bash
#vim: set noet ts=2 sw=2:

install_tools() {
	apt-get install libvirt-clients libvirt-daemon-system qemu-kvm virtinst virt-manager virt-viewer
}

install_tools
sudo mkdir /srv/kvm
sudo systemctl enable libvirtd
sudo systemctl start  libvirtd
sudo virsh pool-create-as srv-kvm dir --target /srv/kvm
