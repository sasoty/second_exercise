#!/bin/bash


function progress_bar {
    local inter=0
    local total=1
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
   
}
generate_large_file() {
    local file_name="$1"
    local size_mb="$2"

    # Create the file with initial content
    echo "Hello, world!" > "$file_name"

    # Get the initial size of the file
    local file_size=$(stat -c "%s" "$file_name")

    # Loop until the file reaches the desired size
    while ((file_size < size_mb * 1024 * 1024)); do 
        dd if=/dev/urandom bs=1024 count=512 >> "$file_name" 2>/dev/null
        file_size=$(stat -c "%s" "$file_name")
        progress_bar -i "$file_size" -t "$((size_mb * 1024 * 1024))" -l 10 -f "#"
        sleep 1
    done

    echo ""
}


# Generate a large file with random contents (30MB minimum)


echo "Large file generated: $file_name"
progress_bar "$@"