# Persistent

## Original

| Boot | File (vFat) | File (Other) | File Name | Partition | Partition Label | Directory |
| :----- | :-----------: | :-------------: | :------------: | :---------: | :-----------------: | :-----------: |
| Casper (Ubuntu, ...) | &#x2714; | &#x2718;  | &#x2718; | &#x2714;  | &#x2718;  | &#x2718; |
| Live-Boot (Debian, ...) | &#x2714; | &#x2714; | &#x2714; | &#x2714; | &#x2714; | &#x2714; |
| Archiso (Arch Linux, ...) | &#x2718; | &#x2718; | &#x2718; | &#x2714; | &#x2714; | &#x2714; |
| Dracut (Fedora, ...) | &nbsp; | &nbsp; | &nbsp; | &nbsp; | &nbsp; | &nbsp; |


### Menu Entry

#### Casper (Ubuntu, ..)

**File:** /bootableusb/persistent/casper-rw  
**Partition Label:** casper-rw  

| Boot | Menu Entry |
| :----- | :----------- |
| Initrd | initrd /casper/initrd.lz |
| Kernel | linux /casper/vmlinuz.efi boot=casper quiet splash  ${opt} |
| Persistent (File) | set opt="persistent persistent-path=/bootableusb/persistent" |
| Persistent (Partition) | set opt="persistent" |
| Persistent (directory) | &#x2718; |

#### Live-Boot (Debian, ..)

**File:** /bootableusb/persistent/bugra  
**Partition Label:** test  
**Directory:** /bootableusb/persistent/deneme  

| Boot | Menu Entry |
| :----- | :----------- |
| Initrd | initrd /live/initrd.img |
| Kernel | linux /live/vmlinuz boot=live config  ${opt} |
| Persistent (File) | set opt="persistence persistence-path=/bootableusb/persistent persistence-label=bugra"  |
| Persistent (Partition) | set opt="persistence persistence-label=test" |
| Persistent (directory) | set opt="persistence persistence-label=deneme persistence-path=/bootableusb/persistent persistence-storage=directory" |

#### Archiso (Arch Linux, ...)

**Partition Label:** test  
**Directory:** /bootableusb/persistent/deneme  

| Boot | Menu Entry |
| :----- | :----------- |
| Initrd | initrd /arch/boot/x86_64/archiso.img |
| Kernel | linux /arch/boot/x86_64/vmlinuz  ${opt} |
| Persistent (File) | &#x2718;  |
| Persistent (Partition) | set opt="cow_label=test" |
| Persistent (directory) | set opt="cow_directory=bootableusb/persistent/deneme cow_label=test" |

## Modified Initrd


## License

[MIT License](https://github.com/bugra9/persistent/blob/master/LICENSE)
