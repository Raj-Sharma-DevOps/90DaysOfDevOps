# Shell Scripting Cheat Sheet

> Quick-reference guide for Bash scripting (DevOps focused)

---

## Quick Reference Table

| Topic | Key Syntax | Example |
|------|-----------|---------|
| Variable | VAR="value" | NAME="DevOps" |
| Argument | $1, $2 | ./script.sh arg1 |
| If | if [ condition ]; then | if [ -f file ]; then |
| For loop | for i in list; do | for i in 1 2 3; do |
| Function | name() { ... } | greet() { echo "Hi"; } |
| Grep | grep pattern file | grep -i "error" log.txt |
| Awk | awk '{print $1}' file | awk -F: '{print $1}' /etc/passwd |
| Sed | sed 's/old/new/g' file | sed -i 's/foo/bar/g' config.txt |

---

## Task 1: Basics

### Shebang
Tells OS which interpreter to use.
```bash
#!/bin/bash
```

### Running a Script
```bash
chmod +x script.sh
./script.sh
bash script.sh
```

### Comments
```bash
# Single line comment
echo "Hello"  # Inline comment
```

### Variables
```bash
VAR=value
echo $VAR
echo "$VAR"   # expands
echo '$VAR'   # literal
```

### Read User Input
```bash
read -p "Enter name: " NAME
echo "Hello $NAME"
```

### Command-line Arguments
```bash
$0  # script name
$1  # first arg
$#  # number of args
$@  # all args
$?  # last exit status
```

---

## Task 2: Operators and Conditionals

### String Comparisons
```bash
[ "$a" = "$b" ]
[ "$a" != "$b" ]
[ -z "$a" ]   # empty
[ -n "$a" ]   # not empty
```

### Integer Comparisons
```bash
[ $a -eq $b ]
[ $a -ne $b ]
[ $a -lt $b ]
[ $a -gt $b ]
[ $a -le $b ]
[ $a -ge $b ]
```

### File Tests
```bash
[ -f file ]  # file exists
[ -d dir ]   # directory
[ -e path ]  # exists
[ -r file ]  # readable
[ -w file ]  # writable
[ -x file ]  # executable
[ -s file ]  # not empty
```

### if / elif / else
```bash
if [ condition ]; then
  echo "Yes"
elif [ other ]; then
  echo "Maybe"
else
  echo "No"
fi
```

### Logical Operators
```bash
[ cond1 ] && [ cond2 ]
[ cond1 ] || [ cond2 ]
! [ cond ]
```

### Case Statement
```bash
case $var in
  start) echo "Starting" ;;
  stop) echo "Stopping" ;;
  *) echo "Unknown" ;;
esac
```

---

## Task 3: Loops

### for Loop
```bash
for i in 1 2 3; do
  echo $i
done
```

### C-style for Loop
```bash
for ((i=0; i<5; i++)); do
  echo $i
done
```

### while Loop
```bash
while read line; do
  echo $line
done < file.txt
```

### until Loop
```bash
until [ $i -gt 5 ]; do
  echo $i
  ((i++))
done
```

### break / continue
```bash
break
continue
```

### Loop Files
```bash
for file in *.log; do
  echo $file
done
```

---

## Task 4: Functions

### Define & Call
```bash
myfunc() {
  echo "Hello"
}
myfunc
```

### Arguments in Functions
```bash
sum() {
  echo $(($1 + $2))
}
sum 2 3
```

### Return vs echo
```bash
return 0    # status
echo "data" # output
```

### Local Variables
```bash
func() {
  local x=10
}
```

---

## Task 5: Text Processing Commands

### grep
```bash
grep -i "error" file
grep -r "text" dir
grep -c "error" file
grep -n "error" file
grep -v "info" file
grep -E "err|fail" file
```

### awk
```bash
awk '{print $1}' file
awk -F: '{print $1}' /etc/passwd
awk '/error/ {print $0}' file
awk 'BEGIN{print "Start"} END{print "End"}' file
```

### sed
```bash
sed 's/old/new/g' file
sed '/pattern/d' file
sed -i 's/foo/bar/g' file
```

### cut
```bash
cut -d: -f1 file
```

### sort / uniq
```bash
sort file
sort -n file
sort -r file
sort file | uniq
uniq -c file
```

### tr
```bash
echo "abc" | tr a-z A-Z
```

### wc
```bash
wc -l file
wc -w file
wc -c file
```

### head / tail
```bash
head -n 10 file
tail -n 10 file
tail -f app.log
```

---

## Task 6: Useful One-Liners

```bash
# Delete files older than 7 days
find /path -type f -mtime +7 -delete

# Count lines in all .log files
wc -l *.log

# Replace string in multiple files
sed -i 's/old/new/g' *.conf

# Check if service is running
systemctl is-active nginx

# Disk usage alert
df -h | awk '$5+0 > 80 {print}'

# Tail log and filter errors
tail -f app.log | grep -i error
```

---

## Task 7: Error Handling & Debugging

### Exit Codes
```bash
exit 0
exit 1
echo $?
```

### Strict Modes
```bash
set -e        # exit on error
set -u        # unset vars error
set -o pipefail
set -x        # debug mode
```

### Trap
```bash
trap 'echo "Cleaning up"' EXIT
```

---

## Notes
- Always quote variables
- Use shellcheck for linting
- Prefer [[ ]] over [ ] in Bash

---

# Happy Scripting 🚀
#90DaysOfDevOps #DevOpsKaJosh

