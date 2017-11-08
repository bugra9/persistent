#!/bin/sh

#set -e

is_int() { return $(test "$@" -eq "$@" > /dev/null 2>&1); }
probe_for_file_name ()
{
	local overlays dev ret backing
	overlays="${1}"
	dev="${2}"

	ret=""
	backing="$(mount_persistence_media ${dev} probe)"
	if [ -z "${backing}" ]
	then
	    return
	fi

	for x in $(cat /proc/cmdline); do
		case $x in
		persistence-new)
			persistenceNew="Yes"
			;;
		persistence-size=*)
			persistenceSize="${x#persistence-size=}"
			if $(is_int "$persistenceSize") && [ "$persistenceSize" -ge "100" ] && [ "$persistenceSize" -le "16000" ]; then
				:
			else
				persistenceNew=""
			fi
		;;
		persistence-uuid=*)
			persistenceUUID="${x#persistence-uuid=}"
		;;
		esac
	done
	fsUUID=$(blkid -s UUID -o value $dev)

	for label in ${overlays}
	do
		path=${backing}/${PERSISTENCE_PATH}/${label}
		if [ ! -e "${path}" ] && [ x$persistenceNew = "xYes" ] && [ "x$fsUUID" = "x$persistenceUUID" ]; then
			mkdir -p "${backing}/${PERSISTENCE_PATH}"
      /helper/bin/dd if="/dev/zero" of="${path}" bs=1M count=${persistenceSize} >/dev/null
      sync >/dev/null
      /helper/sbin/mkfs.ext4 -F -q -e panic -D "${path}" >/dev/null
      sync >/dev/null
      mkdir -p "/mnt/mp"
      fs_type=$(get_fstype "${path}")
      mount -t ${fs_type} -o "rw,noatime" "${path}" "/mnt/mp" >/dev/null
      echo "/ union" >> /mnt/mp/persistence.conf
      umount "/mnt/mp" >/dev/null
      sleep 5
		fi
		if [ -f "${path}" ]
		then
			local loopdev
			loopdev=$(setup_loop "${path}" "loop" "/sys/block/loop*")
			ret="${ret} ${label}=${loopdev}"
		fi
	done

	if [ -n "${ret}" ]
	then
		echo ${ret}
	else
		# unmount and remove mountpoint
		umount ${backing} > /dev/null 2>&1 || true
		rmdir ${backing} > /dev/null 2>&1 || true
	fi
}