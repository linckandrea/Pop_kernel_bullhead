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

function firststage() {
	# Block
	for block_device in /sys/block/*
	do
		echo 128 > $block_device/queue/read_ahead_kb
	done
	write /sys/block/mmcblk0/queue/rotational 0
	write /sys/block/mmcblk0/queue/add_random 0

	# Sched parameters kanged from ether (nextbit robin)
	write /proc/sys/kernel/power_aware_timer_migration 1
	write /proc/sys/kernel/sched_migration_fixup 1
	write /proc/sys/kernel/sched_small_task 30
	write /proc/sys/kernel/sched_upmigrate 95
	write /proc/sys/kernel/sched_downmigrate 85
	write /proc/sys/kernel/sched_window_stats_policy 2
	write /proc/sys/kernel/sched_ravg_hist_size 5
	get-set-forall /sys/devices/system/cpu/*/sched_mostly_idle_load 20
	get-set-forall /sys/devices/system/cpu/*/sched_mostly_idle_nr_run 3
	write /proc/sys/kernel/sched_freq_inc_notify 400000
	write /proc/sys/kernel/sched_freq_dec_notify 400000

	# android background processes are set to nice 10. Never schedule these on the a57s.
	write /proc/sys/kernel/sched_upmigrate_min_nice 9

	# Disable sched_boost
	write /proc/sys/kernel/sched_boost 0

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
}

{
	# Imported from ZSODP (thanks to lazerl0rd)

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

	sleep 15
	firststage
}&
