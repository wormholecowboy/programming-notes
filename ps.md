# BASICS
`ps`              // processes in current shell  
`ps -e` / `ps -A` // all processes, system-wide  
`ps -ef`          // all processes, full format (UID, PID, PPID, start, tty, cmd)  
`ps aux`          // all processes, BSD-style (adds %CPU, %MEM, VSZ, RSS)  
`ps auxf`         // same + ASCII process tree  

# BY PID / PPID
`ps -p 1234`            // info on PID 1234  
`ps -p 1234,5678`       // multiple PIDs  
`ps --ppid 1234`        // children of PID 1234  
`ps -p 1234 -o ppid=`   // just the parent PID, no header  

# BY USER / TTY / COMMAND
`ps -u ec2-user`                    // all procs for user  
`ps -U ec2-user -u ec2-user u`      // BSD format, by user  
`ps -t pts/0`                       // procs on tty pts/0  
`ps -C gunicorn`                    // all procs named gunicorn  
`ps -C gunicorn -o pid,ppid,cmd`    // custom cols for matched name  

# CUSTOM OUTPUT (-o)
`ps -eo pid,ppid,user,stat,start,cmd`             // tailored cols, all procs  
`ps -eo pid,%cpu,%mem,cmd --sort=-%cpu | head`    // top CPU consumers  
`ps -eo pid,%mem,rss,cmd --sort=-%mem | head`     // top mem consumers  
`ps -eo pid,etime,cmd --sort=etime`               // sort by elapsed run time  

# PROCESS TREE
`ps -ejH`         // tree view, system-wide  
`ps axjf`         // BSD-style tree w/ session/PGID  
`pstree -p <pid>` // tree under specific PID (separate tool, more readable)  

# THREADS
`ps -eLf`         // show threads (LWPs)  
`ps -T -p <pid>`  // threads of a specific process  

# USEFUL COMBOS
`ps -ef | grep '[g]unicorn'`                       // find without matching the grep itself  
`ps -o ppid= -p <pid>`                             // parent PID only, no header  
`ps -eo pid,etimes,cmd --sort=-etimes | head`      // longest-running procs  
`ps -eo user,pid,%cpu,%mem,cmd --sort=-%cpu | head -20`  

# KEY COLUMNS
STAT: R running, S sleeping, D uninterruptible (usually I/O), Z zombie, T stopped, + foreground  
VSZ: virtual size (KB) — RSS: resident set size (real RAM, KB)  
TTY: ? = no controlling terminal (daemon)  
ETIME / ETIMES: elapsed wall-clock since start (formatted / seconds)  
