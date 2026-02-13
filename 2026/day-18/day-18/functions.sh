#!/bin/bash

greet(){

	echo "hello $1"
}

add(){
	sum=$(( $1 + $2 ))
	echo "Sum: $sum"
}

greet "renchoo"
add 5 10
