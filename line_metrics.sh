#!/bin/bash

# line_metrics: Analyse lines in a text file, sorting them by character count

# Parse command-line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -l|--length) length="$2"; shift; shift ;;
        -n) num_lines="$2"; shift; shift ;;
        *) filename="$1"; shift ;;
    esac
done

# Validate input file
if [[ ! -f $filename ]]; then
    echo "Error: File '$filename' not found."
    exit 1
fi

# Main logic to process each line and filter out those longer than $length
process_lines() {  # creates the process_lines function
    local counter=1
    while IFS= read -r line || [[ -n "$line" ]]; do
        char_count=$(echo -n "$line" | wc -c | awk '{print $1}')
        
        # If $length is defined, filter out only the lines which are greater than $length long
        if [[ ! -n $length || $char_count -gt $length ]]; then
            echo "$counter,$char_count:$line"
        fi    
        (( counter++ ))
    done < "$filename"
}

# Process and sort the file
lines=$(process_lines | sort -t',' -k2,2nr)

# Filter out just the top $num_lines in terms of length
if [[ -n $num_lines ]]; then
    echo "$lines" | head -n "$num_lines"
else
   echo "$lines" 
fi