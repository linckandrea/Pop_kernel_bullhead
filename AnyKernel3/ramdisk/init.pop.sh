#!/system/bin/sh

################################################################################
# helper functions to allow Android init like script

function write() {
    echo -n $2 > $1
}

function get-set-forall() {
    for f in $1 ; do
        cat $f
        write $f $2
    done
}

# macro to write pids to system-background cpuset
function writepid_sbg() {
    until [ ! "$1" ]; do
        echo -n $1 > /dev/cpuset/system-background/tasks;
        shift;
    done;
}

################################################################################

	# Wait 20 seconds to avoid any kind of conflicts
	sleep 20

	# according to Qcom this legacy value improves first launch latencies
	# stock value is 512k
	setprop dalvik.vm.heapminfree 2m
    
	# Block
	for block_device in /sys/block/*
	do
		echo 128 > $block_device/queue/read_ahead_kb
	done
	write /sys/block/mmcblk0/queue/rotational 0
	write /sys/block/mmcblk0/queue/add_random 0

	# Adreno idler
	write /sys/module/adreno_idler/parameters/adreno_idler_active 0
	write /sys/module/adreno_idler/parameters/adreno_idler_downdifferential 20
	write /sys/module/adreno_idler/parameters/adreno_idler_idlewait 20
	write /sys/module/adreno_idler/parameters/adreno_idler_idleworkload 6000

	# Disable KSM by default
	write /sys/kernel/mm/ksm/run 0
	write /sys/kernel/mm/ksm/sleep_millisecs 1500
	write /sys/kernel/mm/ksm/pages_to_scan 512
	write /sys/kernel/mm/ksm/deferred_timer 1

	# Zram tweaks
	write /sys/block/zram0/max_comp_streams 4

	# VM
	write /proc/sys/vm/dirty_background_ratio 10
	write /proc/sys/vm/dirty_ratio 30
	write /proc/sys/vm/dirty_expire_centisecs 3000
	write /proc/sys/vm/dirty_writeback_centisecs 3000
	write /proc/sys/vm/page-cluster 0
	write /proc/sys/vm/stat_interval 10
	write /proc/sys/vm/swappiness 100
	write /proc/sys/vm/vfs_cache_pressure 60

	# Enable EIS
	setprop persist.camera.eis.enable 1
	setprop persist.camera.is_type 4

	# Memory optimizations
	setprop ro.vendor.qti.am.reschedule_service=true
	setprop ro.vendor.qti.sys.fw.bservice_enable=true

	# Imported from ZSODP (thanks to lazerl0rd)
	sleep 10

	LOGCAT=`pidof logcat`
	RMT_STORAGE=`pidof rmt_storage`
	QMUXD=`pidof qmuxd`
	QTI=`pidof qti`
	NETMGRD=`pidof netmgrd`
	THERMAL-ENGINE=`pidof thermal-engine`
	WPA_SUPPLICANT=`pidof wpa_supplicant`
	LOC_LAUNCHER=`pidof loc_launcher`
	CNSS-DAEMON=`pidof cnss-daemon`
	QSEECOMD=`pidof qseecomd`
	TIME_DAEMON=`pidof time_daemon`
	CND=`pidof cnd`
	IMSQMIDAEMON=`pidof imsqmidaemon`
	IMSDATADAEMON=`pidof imsdatadaemon`

	writepid_sbg $LOGCAT
	writepid_sbg $RMT_STORAGE
	writepid_sbg $QMUXD
	writepid_sbg $QTI
	writepid_sbg $NETMGRD
	writepid_sbg $THERMAL-ENGINE
	writepid_sbg $WPA_SUPPLICANT
	writepid_sbg $LOC_LAUNCHER
	writepid_sbg $CNSS-DAEMON
	writepid_sbg $QSEECOMD
	writepid_sbg $TIME_DAEMON
	writepid_sbg $CND
	writepid_sbg $IMSQMIDAEMON
	writepid_sbg $IMSDATADAEMON
