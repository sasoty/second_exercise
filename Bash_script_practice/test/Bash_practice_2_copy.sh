#!/bin/bash


function progress_bar {
    local inter=0
    local total=0
    local decimals=1
    local length=100
    local length=0
    local fill="█"

    # Parse command-line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -i) 
                inter=$2 
                shift 2
                ;;
            -t) 
                total=$2 
                shift 2
                ;;
            -l) 
                length=$2   
                shift 2
                ;;
            -f) 
                fill=$2    
                shift 2
                ;;
            -*)
                echo "invalid option: $1" >&2
                exit 1
                ;;
            *)
                echo "invalid argument: $1" >&2
                exit 1
                ;;
        esac
    done
    leng=$((length/10))

    while [ $inter -lt $total ]; do
        ((inter += (total / 10)))  
        percent=$((inter * 100 / total))
        local progress=()
        for (( i = 0; i < (percent*leng) / 10; i++ )); do
            progress+=("$fill")
        done
        for (( i = (percent*leng)/ 10; i < length; i++ )); do
            progress+=("-")
        done
        echo -ne "\r[${progress[*]}] $percent%"
        sleep 1
    done

    echo "" 
}
generate_large_file() {
    local file_name="$1"
    local size_mb="$2"

    # Calculate size in bytes
    local size=$((size_mb * 1024 * 1024))

    # Generate random contents and write to file
    dd if=/dev/urandom of="$file_name" bs=1M count=$((size_mb / 1024)) seek=1023 status=none
    
}

# Generate a large file with random contents (30MB minimum)


echo "Large file generated: $file_name"
progress_bar "$@"