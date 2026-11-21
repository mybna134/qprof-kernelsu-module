Qualcomm Profiler qprof AutoStart (KernelSU)

This arm64 module includes the Qualcomm Profiler LA target binaries, libraries,
handlers, backends and ExtQProfiler.db. Profiler binaries and libraries stay in
the module's private qprof/ directory and are not mounted into /vendor. At boot,
an initrc service fixes executable permissions, prepares the module data and
starts qmonitor-grpc-server in the foreground under KernelSU's root SELinux
domain.

Install/update the ZIP in KernelSU Manager > Modules, then reboot. Do not
install from custom recovery. Logs: /data/local/tmp/qprof-kernelsu.log
The server listens on 127.0.0.1:62472; on the computer run:
  adb forward tcp:62472 tcp:62472
