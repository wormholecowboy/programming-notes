# macOS Local Network CLI Cheat Sheet

## Mental Models
- **ifconfig** — Old-school encyclopedia of network interfaces. Shows full details (IP, MAC, status).  
- **ipconfig** — Mac-specific pocketknife. Quick answers: IP, router, DNS.  
- **arp** — Your Mac’s “little black book.” List of devices it has seen on the LAN.  
- **netstat** — Roadmap of network traffic. Shows where packets go (router, routes).  
- **nmap** — (Extra tool) The radar sweep. Scans the subnet for all active devices.  

---

## Core Tasks

### Find Your Device
- `ifconfig` → Show all interfaces, IPs, and MAC addresses.  
- `ipconfig getifaddr [enX]` → Show your IP for a specific interface.  

### Identify Your Router
- `ipconfig getoption [enX] router` → Show the router’s IP.  
- `netstat -nr | grep default` → Show the default gateway route.  

### See Other Devices
- `arp -a` → List IP ↔ MAC pairs your Mac has seen.  
- `ping [broadcast]` + `arp -a` → Nudge everyone, then list active devices.  
- `nmap -sn [subnet]` → Full sweep of all live devices (best method).  

### Interface Control & Info
- `ifconfig [enX]` → Full details of one interface (status, IPs).  
- `ifconfig [enX] down/up` → Disable or enable an interface.  
- `ifconfig [enX] | grep ether` → Show MAC address of the card.  
- `ipconfig getoption [enX] subnet_mask` → Show subnet mask.  
- `ipconfig getoption [enX] domain_name_server` → Show DNS servers.  

### Connectivity Checks
- `ping [target]` → Test reachability of a device.  
- `nc -zv [target] 1-1024` → Check which ports are open on a device.  
- `dig [domain]` / `nslookup [domain]` → Look up DNS records.  
- `curl ifconfig.me` → Show your public IP address.  

---

## Common Questions

### How do I find my subnet?
Your subnet is determined by your **IP address** and **subnet mask**.  
- Example: IP `192.168.1.37` + mask `255.255.255.0` → subnet is `192.168.1.0/24`.  
- Get it with: `ipconfig getoption [enX] subnet_mask`.  

### How do I know which `enX` is wired vs. wireless?
Run: `networksetup -listallhardwareports` 
It will list hardware ports like Wi-Fi, Ethernet, and their matching device (`en0`, `en1`, etc.).  

### How do I read `ifconfig` output?
Sample block:
- **en0:** → Interface name.  
- **flags:** → State of the interface (`UP` means enabled, `RUNNING` means connected).  
- **inet 192.168.1.37** → Your IPv4 address.  
- **netmask 0xffffff00** → Subnet mask (same as 255.255.255.0).  
- **broadcast 192.168.1.255** → Broadcast address for the subnet.  
- **inet6 ...** → IPv6 address (can ignore for basics).  
- **ether ac:de:48:00:11:22** → MAC address of the interface.  
- **status: active** → Interface is up and working.  

---

## Reading the Output (Quick Tips)
- **`inet`** → IPv4 address (your LAN IP).  
- **`127.0.0.1`** → Loopback (ignore).  
- **`ether`** → MAC address.  
- **`default`** in netstat → Router.  
- **ARP entries** → Devices your Mac has seen on the LAN.  
