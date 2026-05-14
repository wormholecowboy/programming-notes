# USERS
Identity, sessions, and account/group management.

whoami                             # current user name
id                                 # current user + primary group + all group IDs
id <user>                          # same, for a specific user
groups                             # group memberships for current user
groups <user>                      # group memberships for a specific user
users                              # users currently logged in (short list)

who                                # users currently logged in (with tty, login time)
w                                  # users + what they're running
last                               # login history (from /var/log/wtmp)
last <user>                        # login history for a specific user

getent passwd                      # list all users via NSS (works with LDAP/AD too)
getent passwd <user>               # look up one user
getent group                       # list all groups via NSS
cat /etc/passwd                    # local user database
cat /etc/group                     # local group database
sudo cat /etc/shadow               # password hashes (root-readable)

su - <user>                        # switch to user with their full login environment
sudo -u <user> <cmd>               # run one command as another user
sudo -i                            # interactive root shell with root env
sudo -s                            # root shell that keeps current env

sudo useradd <user>                # create user
sudo useradd -m -s /bin/bash <user>   # create user with home dir + login shell
sudo userdel <user>                # delete user, keep home dir
sudo userdel -r <user>             # delete user + home dir
sudo usermod -aG <group> <user>    # add user to a group (preserves existing groups)
sudo usermod -s /bin/bash <user>   # change user's login shell
sudo passwd <user>                 # set or change a user's password
sudo chage -l <user>               # show password aging info

sudo groupadd <group>              # create group
sudo groupdel <group>              # delete group
sudo gpasswd -a <user> <group>     # add user to group
sudo gpasswd -d <user> <group>     # remove user from group

id flags
-u UID only
-g primary GID only
-G all group IDs
-n print names instead of numeric IDs (combine with -u/-g/-G)
useradd flags
-m create the home directory
-s <shell> login shell (e.g. /bin/bash)
-G <groups> supplementary groups, comma-separated
-u <uid> specific UID
userdel flags
-r remove home directory and mail spool
usermod flags
-a append (use with -G to preserve existing group membership; without -a, -G replaces)
-G <groups> supplementary groups
-s <shell> change login shell
-l <newname> rename user
chage flags
-l list password aging info for a user
-E <date> account expiration date
-M <days> max days between password changes


# SYSTEMD
Service lifecycle (start/stop/restart/enable) and log inspection on systemd-based hosts.

sudo journalctl -u <service>.service -f   # tail stdout/stderr for a service
sudo systemctl status <service>           # status + recent log lines
sudo systemctl restart <service>          # restart a service
sudo systemctl start <service>            # start a service
sudo systemctl stop <service>             # stop a service
sudo systemctl enable <service>           # enable at boot
sudo systemctl disable <service>          # disable at boot
sudo systemctl daemon-reload              # reload after editing unit files

journalctl flags
-u <unit> filter to a specific service unit
-f follow mode — stream new log lines as they appear
-n <N> show last N lines
--since "<time>" filter by time (e.g. "2 hours ago", "today", "2026-05-14 06:00")
-p <level> filter by priority (err, warning, info, debug)


# PROCESSES
Listing, filtering, and inspecting running processes — useful for finding PIDs, worker counts, and ownership.

ps -ef | grep gunicorn             # all gunicorn processes (master + workers)
ps -ef | grep '[g]unicorn'         # same, but excludes the grep line itself (regex trick)
ps -ef | grep node                 # node process(es)
ps -o pid,rss,comm -C gunicorn     # RSS (memory) per process, by command name
ps -eo pid,user,%cpu,%mem,rss,comm --sort=-rss | head -20   # top 20 processes by RAM
pgrep -f 'gunicorn.*wsgi:app'      # PIDs matching a command-line pattern
pgrep -d, -f 'gunicorn'            # comma-separated PIDs (good for piping into top/pidstat)
pstree -p <pid>                    # process tree from a PID, with PIDs

ps flags
-e every process (all users, all sessions)
-f full-format listing (UID, PID, PPID, C, STIME, TTY, TIME, CMD)
-o custom output columns (e.g. pid,rss,comm)
-C filter by command name
--sort=-<col> sort descending by column (prefix with - for descending)
pgrep flags
-f match against the full command line, not just process name
-d <delim> delimiter between PIDs in output (default newline)
pstree flags
-p show PID alongside each process name


# MEMORY / CPU
Snapshotting current load and sampling CPU/memory over time. Distinguishes live, interval, and historical tools.

top vs *stat (vmstat, mpstat, pidstat) vs sar
top         live and interactive — refreshes in place. Best for "what's happening right now?"
*stat       periodic samples written line-by-line. Each sample reports the delta since the last.
            Good when you want a scrollable record of a burst without an interactive UI.
sar         same sample format as *stat, but also reads historical data from /var/log/sa/*
            (requires sysstat data collection enabled). Use for "what was load like at 6am yesterday?"

free -h                            # memory total + used (human-readable)

top -bn1 | head -20                # current CPU/RAM load (non-interactive snapshot)
top -p <pid>                       # watch a specific PID live
top -H -p <pid>                    # show threads within a process (press 1 for per-CPU)

mpstat -P ALL 2 30                 # per-core CPU usage, every 2s for 30 iterations
pidstat -p <pid> 1 10              # %CPU for a process, every 1s for 10 iterations
pidstat -t -p <pid> 1 10           # same, broken down per thread
vmstat 5                           # system-wide: CPU, IO, swap, runqueue, every 5s

sar -u 2 30                        # system-wide CPU %user/%sys/%idle, every 2s for 30 iters
sar -u -P ALL 2 30                 # same, per-core breakdown
sar -r 2 30                        # memory usage (free, used, buffers, cache, %memused) every 2s
sar -S 2 30                        # swap usage
sar -q 2 30                        # runqueue length + load average

free flags
-h human readable units (Gi/Mi/Ki)
top flags
-b batch mode (non-interactive, prints once and exits — good for scripting)
-n <N> number of iterations
-p <pid> monitor specific PID(s), comma-separated
-H show individual threads instead of summarised process
-d <secs> delay between refreshes
mpstat / sar / pidstat shared
-P ALL per-CPU breakdown (instead of aggregated)
<interval> <count> sampling pattern — every <interval>s, <count> times
pidstat flags
-p <pid> specific PID
-t include per-thread rows
-u CPU stats (default)
-r memory stats
sar flags
-u CPU utilization
-r memory utilization
-S swap utilization
-q runqueue + load average


# NETWORK / PORTS
Who's listening, who's connected, and on what port. Diagnoses bind conflicts and connection state.

lsof -i :8082                      # what's listening/connected on port 8082
ss -ltnp                           # listen sockets, with process info, no DNS lookup
ss -tan state established | wc -l  # count established TCP connections
ss -s                              # socket summary (TCP/UDP totals by state)
netstat -an | grep :8080           # old-school port check (use ss if available)
curl -v http://host:port           # verbose curl, shows TCP/TLS handshake

lsof flags
-i [:port] filter to network/internet sockets, optionally a specific port
-p <pid> filter to a specific process
ss flags
-l listening sockets only
-t TCP sockets
-u UDP sockets
-n numeric — skip DNS/service name lookup (faster)
-p show owning process info
-a all sockets (listening + non-listening)
-s summary counts by state
state <name> filter by TCP state (established, listen, time-wait, etc.)
netstat flags
-a all sockets
-n numeric (no name resolution)


# TIMING / BENCHMARKING
Measuring how long commands take, and patterns for firing parallel or sequential batches to compare.

time <cmd>                         # wall, user, sys time for one command
/usr/bin/time -v <cmd>             # detailed: max RSS, page faults, %CPU, etc.
time { for i in 1 2 3 4 5; do <cmd> & done; wait; }   # parallel batch, total wall time
time for i in 1 2 3 4 5; do <cmd>; done               # sequential loop timing
for i in $(seq 1 20); do <cmd> & done; wait           # fire N in parallel and wait

time vs /usr/bin/time
time — bash builtin, simple wall/user/sys output
/usr/bin/time — external, supports -v for detailed resource stats
/usr/bin/time flags
-v verbose: max RSS, page faults, context switches, %CPU, elapsed wall, etc.
-f <fmt> custom format string
bash patterns
&        run in background
wait     block until all backgrounded jobs finish
{ ...; } group commands so `time` measures the whole block


# CURL
Hitting HTTP endpoints from the shell — for testing services, capturing timings, and inspecting responses.

curl -s -o /dev/null URL                                  # silent, discard body
curl -s -o /dev/null -w "%{http_code} %{time_total}s\n" URL   # timing + status only
curl -X POST -H 'Content-Type: application/json' -d "$PAYLOAD" URL   # POST JSON
curl -I URL                                               # HEAD request only (headers)

curl flags
-s silent — suppress progress bar and error messages
-o <file> write body to file (use /dev/null to discard)
-w <fmt> write-out format string after transfer (e.g. %{http_code}, %{time_total}, %{size_download})
-X <method> HTTP method (GET default; POST, PUT, DELETE, etc.)
-H <header> add request header (repeatable)
-d <data> request body (implies POST unless -X says otherwise)
-I HEAD request — fetch headers only
-v verbose — show request/response headers and TCP/TLS handshake
-L follow redirects
-k allow insecure SSL (skip cert validation)


# LIMITS
Per-shell and system-wide resource ceilings. Common cause of "too many open files" or fork failures under load.

ulimit -n                          # file descriptor limit (default 1024)
ulimit -a                          # all current shell limits
ulimit -u                          # max user processes
cat /proc/sys/fs/file-max          # system-wide fd limit

ulimit flags
-n max open file descriptors
-u max user processes
-a show all current limits
-s stack size (KB)
-v virtual memory (KB)
soft vs hard: `ulimit -Sn` (soft) vs `ulimit -Hn` (hard ceiling)


# /PROC INSPECTION
Reading kernel-exposed per-process and system data from /proc. Source of truth when ps/top aren't enough.

cat /proc/<pid>/cmdline | tr '\0' ' '; echo   # full launch command of a process
cat /proc/<pid>/status              # process status: state, threads, RSS, parent, etc.
ls -l /proc/<pid>/fd                # open file descriptors for a process
cat /proc/meminfo                   # detailed memory breakdown
cat /proc/cpuinfo                   # CPU model, cores, flags

