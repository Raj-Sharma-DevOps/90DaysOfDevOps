# Day 17 – Shell Scripting: Loops, Arguments & Error Handling

## 📌 Overview

Today I practiced:
- For and While loops
- Command-line arguments ($1, $#, $@)
- Installing packages via script
- Basic error handling using set -e and ||

---

# 🟢 Task 1: For Loop

## 1️⃣ for_loop.sh

#!/bin/bash

fruits=("Apple" "Mango" "Banana" "Orange" "Grapes")

for fruit in "${fruits[@]}"
do
    echo $fruit
done

*Output*

Apple
Mango
Banana
Orange
Grapes

## 2️⃣ count.sh

#!/bin/bash

for ((i=1; i<=10; i++))
do
    echo $i
done

*Output*

1
2
3
4
5
6
7
8
9
10

Task 2: While Loop

#!/bin/bash

read -p "Enter a number: " num

while [ $num -ge 0 ]
do
    echo $num
    num=$((num-1))
done

echo "Done!"

*Output*

Enter a number: 5
5
4
3
2
1
0
Done!


## Task 3: Command-Line Arguments

1️⃣ greet.sh

#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: ./greet.sh <name>"
    exit 1
fi

echo "Hello, $1!"


*Output*

./greet.sh Raj
Hello, Raj!

2️⃣ args_demo.sh

#!/bin/bash

echo "Script name: $0"
echo "Total arguments: $#"
echo "All arguments: $@"

*Output*

./args_demo.sh apple mango banana

Script name: ./args_demo.sh
Total arguments: 3
All arguments: apple mango banana

## Task 4: Install Packages via Script

#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Run as root"
    exit 1
fi

packages=("nginx" "curl" "wget")

for pkg in "${packages[@]}"
do
    echo "Checking $pkg..."

    if dpkg -s "$pkg" &> /dev/null; then
        echo "$pkg is already installed"
    else
        echo "$pkg not found, installing..."
        apt install -y "$pkg"
    fi
done


## Task 5: Error Handling

#!/bin/bash

set -e

DIR="/tmp/devops-test"

mkdir "$DIR" || echo "Directory already exists"

cd "$DIR" || { echo "Failed to enter directory"; exit 1; }

touch test.txt || { echo "Failed to create file"; exit 1; }

echo "Script completed successfully"


# What I Learned

How to use for and while loops in shell scripting.

How command-line arguments work using $1, $#, $@ and $0.

How to handle errors using set -e, || and exit codes.

How to automate package installation using dpkg -s.

Why root privileges are required for system-level operations.