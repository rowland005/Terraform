sudo apt update -y && sudo apt install libguestfs-tools -y

sudo virt-customize -a jammy-server-cloudimg-amd64.img --install qemu-guest-agent

sudo qm create 9001 --name "ubuntu-2204-cloudinit-template-local" --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0

sudo qm importdisk 9001 jammy-server-cloudimg-amd64.img local
sudo qm importdisk 9001 jammy-server-cloudimg-amd64.img local-lvm
sudo qm set 9001 --scsihw virtio-scsi-pci -scsi0 local-lvm:vm-9001-disk-0
sudo qm set 9001 --boot c --bootdisk scsi0
sudo qm set 9001 --ide2 local-lvm:cloudinit
sudo qm set 9001 --serial0 socket --vga serial0
sudo qm set 9001 --agent enabled=1
