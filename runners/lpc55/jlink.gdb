# source .gdb-dashboard

set history save on
set confirm off
set pagination off

define rebootloop
  while (1)
    run
  end
end

target extended-remote :2331
load
monitor reset
monitor semihosting enable
# monitor semihosting breakOnError <digit>
# by default (1) output goes to Telnet client, 2 sends to GDB client, 3 would send to both
monitor semihosting IOClient 3
#break led.rs:67
#continue
#monitor swo enabletarget 0 0 1 0
# mon SWO EnableTarget 0 48000000 1875000 0
continue
# stepi
