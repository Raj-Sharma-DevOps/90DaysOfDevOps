#!/bin/bash

my_function() {
    local name="Raj"
    echo "Inside function: $name"
}

another_function() {
    age=22
    echo "Inside another function: $age"
}

my_function
echo "Outside function: $name"   # Will be empty

another_function
echo "Outside function: $age"    # Will print 22
