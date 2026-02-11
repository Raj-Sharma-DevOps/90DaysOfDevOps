# Day 15 – Networking Concepts: DNS, IP, Subnets & Ports

## Task 1 – DNS

When I type google.com:
1. Browser checks cache
2. DNS resolves name to IP
3. TCP connection is created
4. HTTP request is sent

### DNS Records

A – Maps domain to IPv4  
AAAA – Maps domain to IPv6  
CNAME – Alias record  
MX – Mail server record  
NS – Name server record  

### dig Output

A Record:  192.178.155.113(Got multiple ipv4)
TTL: 48 

---

## Task 2 – IP Addressing

IPv4 has 4 octets (32 bits), example: 192.168.1.10

Public IP example: 8.8.8.8  
Private IP example: 192.168.1.5  

Private ranges:
10.x.x.x  
172.16.x.x – 172.31.x.x  
192.168.x.x  

My private IP from ip addr show:
172.31.24.125/20

---

## Task 3 – CIDR & Subnetting

192.168.1.0/24 means 24 bits for network.

### CIDR Table

CIDR | Subnet Mask | Total IPs | Usable Hosts
/24  | 255.255.255.0 | 256 | 254
/16  | 255.255.0.0   | 65536 | 65534
/28  | 255.255.255.240 | 16 | 14

Why subnet?
To divide network logically, improve security and reduce IP waste.

---

## Task 4 – Ports

22 – SSH  
80 – HTTP  
443 – HTTPS  
53 – DNS  
3306 – MySQL  
6379 – Redis  
27017 – MongoDB  

From ss output:
Port 80 → Service HTTP (Nginx likely)
Port 22 → Service SSH
---

## Task 5 – Putting It Together

curl  curl  https://melodious-marigold-cac143.netlify.app/ involves DNS, TCP, IP and HTTP.

If DB at 10.0.1.50:3306 fails:
Check reachability, port, firewall and service status.

---

## What I Learned

1. DNS converts names to IPs
2. CIDR defines network size
3. Ports define which service handles traffic
