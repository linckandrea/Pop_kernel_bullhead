#!/system/bin/sh

################################################################################
# helper functions to allow Android init like script

function write() {
    echo -n $2 > $1
}


################################################################################

	# Wait 25 seconds to avoid any kind of conflicts
	sleep 25

	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor interactive
	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 384000
	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 1440000
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load 93
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay 0  600000:19000 787200:20000 960000:24000 1248000:38000
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate 50000
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq 600000
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack 380000
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads 29 384000:88 600000:90 787200:92 960000:93 1248000:98
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time 60000
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/boost 0
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/align_windows 1
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif 1
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load 0
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis 0
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/boostpulse_duration 0
	write /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor interactive
	write /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq 384000
	write /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq 1824000
	write /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load 150
	write /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay 20000 960000:60000 1248000:30000
	write /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate 60000
	write /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq 960000
	write /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_slack 380000
	write /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads 98
	write /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time 60000
	write /sys/devices/system/cpu/cpu4/cpufreq/interactive/boost 0
	write /sys/devices/system/cpu/cpu4/cpufreq/interactive/align_windows 1
	write /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif 1
	write /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load 0
	write /sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis 0
	write /sys/devices/system/cpu/cpu4/cpufreq/interactive/boostpulse_duration 0
	write /sys/module/cpu_boost/parameters/input_boost_freq 0:600000 1:600000 2:600000 3:600000 4:960000 5:960000
	write /sys/module/cpu_boost/parameters/sync_threshold 1248000
	write /sys/module/cpu_boost/parameters/boost_ms 40
	write /sys/module/cpu_boost/parameters/migration_load_threshold 15
	write /sys/module/cpu_boost/parameters/load_based_syncs Y
	write /sys/module/cpu_boost/parameters/shed_boost_on_input N
	write /sys/module/cpu_boost/parameters/input_boost_ms 300
	write /sys/module/cpu_boost/parameters/input_boost_enabled 1
	write /sys/module/msm_performance/parameters/touchboost 0
	write /sys/module/msm_thermal/core_control/enabled 0
	write /sys/module/msm_thermal/parameters/enabled Y
