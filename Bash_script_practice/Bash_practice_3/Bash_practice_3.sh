string="AABCCCDEEEE"

IFS="" read -r -a array <<< "$string"

# Iterate over the elements of the array
for element in "${array[@]}"; do
    echo "$element"
done

# Delete an element from the array (e.g., the second element)
unset 'array[1]