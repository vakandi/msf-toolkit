import sys
import re

# Get the command-line arguments
search_pattern = sys.argv[1]
replace_string = sys.argv[2]
input_file = sys.argv[3]
output_file = sys.argv[4]

# Read the contents of the input file
with open(input_file, 'r') as f:
    contents = f.read()

# Replace the search pattern with the replace string
new_contents = re.sub(search_pattern, replace_string, contents)

# Write the modified contents to the output file
with open(output_file, 'w') as f:
    f.write(new_contents)

