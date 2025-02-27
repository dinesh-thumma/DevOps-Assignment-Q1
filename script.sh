#!/bin/bash

# function to check if the given input number has atleast 2 distinct digits
has_two_different_digits() {
    num=$1
    unique_digits=$(echo "$num" | sed 's/\(.\)/\1\n/g' | sort | uniq | wc -l)
    if [ "$unique_digits" -lt 2 ]; then
        echo 0
    else
        echo 1
    fi
}

# Function to perform Kaprekar's routine
kaprekar_iteration() {
    num=$1
    num=$(printf "%04d" "$num")  # adding zeros to make it a 4-digit number for operations
    asc=$(echo "$num" | grep -o . | sort | tr -d '\n')   # Sorting the digits in order
    desc=$(echo "$num" | grep -o . | sort -r | tr -d '\n')
    result=$((10#$desc - 10#$asc))   # Converting to integers
    result=$(printf "%04d" "$result")   # making the result to 4 digits again
    echo "$result"
}

# Reading the input
printf "Please Enter any 4 digit number as input: \n"
read input

if ! [[ "$input" =~ ^[0-9]{4}$ ]]; then
    echo "Error: Input must be a 4 digit number"
    exit 1
fi

if [ "$(has_two_different_digits "$input")" -eq 0 ]; then
    echo "Error: The input number must have at least two distinct digits"
    exit 1
fi

iterations=0
num=$input

while [ "$num" -ne 6174 ]; do
    num=$(kaprekar_iteration "$num")
    iterations=$((iterations + 1))
    echo "Iteration $iterations: $num"
    if [ "$num" -eq 0 ]; then      # exiting the process if we rech 0 anywhere in between
        echo "Reached the value 0, stopping the routine."
        exit 1
    fi
done
