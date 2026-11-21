#!/system/bin/sh
MODDIR=/data/adb/modules/qprof_autostart
LOG=/data/local/tmp/qprof-kernelsu.log
QPROF_DIR="$MODDIR/qprof"
log() { echo "[$(date '+%F %T' 2>/dev/null)] $*" >> "$LOG"; }

if [ -f "$MODDIR/disable" ]; then
  log "Module is disabled; skipping qprof startup"
  exit 0
fi

chmod 0755 "$QPROF_DIR" "$QPROF_DIR/bin" "$QPROF_DIR/libs" \
  "$QPROF_DIR/libs/backends" "$QPROF_DIR/libs/handlers" \
  "$QPROF_DIR/libs/command-handlers" 2>>"$LOG"
chmod 0755 "$QPROF_DIR/bin/qmonitor-grpc-server" "$QPROF_DIR/bin/qprof" \
  "$QPROF_DIR/bin/QualcommProfilerHandlerProbe" \
  "$QPROF_DIR/bin/profilerUtilityApp" \
  "$QPROF_DIR/libs/handlers/QualcommProfilerGpuProfilingRpcHandler" 2>>"$LOG"

if [ ! -x "$QPROF_DIR/bin/qmonitor-grpc-server" ] || \
   [ ! -x "$QPROF_DIR/bin/qprof" ] || \
   [ ! -r "$QPROF_DIR/libs/backends/libQMonitorProfilerBackend.so" ]; then
  log "ERROR: qprof files are missing from $QPROF_DIR"
  exit 1
fi

EXT_DIR=/data/shared/qcom/Shared/Prof_Ext
if [ -f "$MODDIR/payload/ExtQProfiler.db" ] && [ ! -f "$EXT_DIR/ExtQProfiler.db" ]; then
  mkdir -p "$EXT_DIR"
  cp "$MODDIR/payload/ExtQProfiler.db" "$EXT_DIR/ExtQProfiler.db"
  chmod 0644 "$EXT_DIR/ExtQProfiler.db"
  log "Installed Prof_Ext database"
fi

log "Module files ready; starting qprof root service"
setprop sys.qprof.ready 1
