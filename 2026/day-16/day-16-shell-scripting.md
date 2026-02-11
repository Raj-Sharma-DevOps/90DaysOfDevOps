# Day 16 – Shell Scripting Basics

## Overview
Today I learned the fundamentals of shell scripting including shebang, variables, user input, and if-else conditions.

---

## Task 1: hello.sh

#!/bin/bash
echo "Hello, DevOps!"


chmod +x hello.sh
./hello.sh

What happens if we remove shebang?

If we remove #!/bin/bash, the script may still run using bash hello.sh, but when running with ./hello.sh, the system uses the default shell. If bash-specific syntax is used, it may fail. Shebang ensures the correct interpreter is used.



## Task 2: variables.sh

#!/bin/bash

NAME="Raj"
ROLE="DevOps Engineer"

echo "Hello, I am $NAME and I am a $ROLE"

Single vs Double Quotes

Double quotes allow variable expansion: "Hello $NAME"

Single quotes print as plain text: 'Hello $NAME'

## Task 3: greet.sh

#!/bin/bash

read -p "Enter your name: " name
read -p "Enter your favourite tool: " tool

echo "Hello $name, your favourite tool is $tool"

## Task 4: check_number.sh

#!/bin/bash

read -p "Enter a number: " num

if [ "$num" -gt 0 ]; then
    echo "Number is Positive"
elif [ "$num" -lt 0 ]; then
    echo "Number is Negative"
else
    echo "Number is Zero"
fi

## Task 4: file_check.sh

#!/bin/bash

read -p "Enter filename: " filename

if [ -f "$filename" ]; then
    echo "File exists."
else
    echo "File does not exist."
fi

## Task 5: server_check.sh

#!/bin/bash

service="nginx"

read -p "Do you want to check the status of $service? (y/n): " choice

if [ "$choice" = "y" ]; then
    if systemctl is-active --quiet "$service"; then
        echo "$service is ACTIVE."
    else
        echo "$service is NOT active."
    fi
elif [ "$choice" = "n" ]; then
    echo "Skipped."
else
    echo "Invalid input."
fi


*Key Learnings*
1. Shebang (#!/bin/bash) tells the system which interpreter to use.

2. Variables must not have spaces around =.

3. Exit code 0 means success in bash.

4. Always use quotes around variables to avoid errors.