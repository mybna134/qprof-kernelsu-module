#!/system/bin/sh
MODDIR=/data/adb/modules/qprof_autostart
QPROF_DIR="$MODDIR/qprof"
LOG=/data/local/tmp/qprof-kernelsu.log
echo "[$(date '+%F %T' 2>/dev/null)] Starting Qualcomm Profiler gRPC server from module storage" >> "$LOG"
export QMONITOR_BACKEND_LIB_PATH="$QPROF_DIR/libs/backends"
export PROFILER_HANDLERS_LIB_PATH_1="$QPROF_DIR/libs/handlers"
export COMMAND_HANDLERS_LIB_PATH_1="$QPROF_DIR/libs/command-handlers"
export LD_LIBRARY_PATH="$QPROF_DIR/libs${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
export PATH="$QPROF_DIR/bin:$PATH"
exec "$QPROF_DIR/bin/qmonitor-grpc-server" -l -p 62472 -n 127.0.0.1 >> "$LOG" 2>&1
