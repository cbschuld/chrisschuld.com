#!/bin/bash

# Navigate to the directory containing the md files if not already there
# cd /path/to/directory

for file in *.md; do
    # Extract YYYY, MM, DD, and TITLE from the filename
    IFS='-' read -r YYYY MM DD TITLE <<< "${file%.md}"
    
    # Reconstruct TITLE to include all parts after DD, as the initial read will only capture up to the first '-'
    TITLE=$(echo $file | cut -d'-' -f4- | sed 's/.md$//')
    
    # Concatenate to form the redirect string, ignoring DD
    redirect="redirect_from: /$YYYY/$MM/${TITLE}"
    
    # Use awk to find the line with "tags:", add the redirect after it, and output to a temp file
    awk -v r="$redirect" '/tags:/ {print $0 "\n" r; next} {print}' "$file" > temp && mv temp "$file"
done
