#!/bin/bash

sys_start_date=$(date +'%Y-%m-%d')
sys_end_date=$(date -d "+14 month" +'%Y-%m-%d')
# Define the start date (now) and end date (1 year from now)
start_date=$(date +"%d-%m-%Y")
end_date=$(date -d "+14 month" +"%d-%m-%Y")

# Loop through dates
before_date=$start_date
current_date=$start_date
sys_current_date=$sys_start_date
# Convert the start_date and end_date to seconds since the epoch for comparison
start_date_seconds=$(date -d "$sys_start_date" +%s)
end_date_seconds=$(date -d "$sys_end_date" +%s)

# Loop through dates
current_date_seconds=$start_date_seconds
while [ "$current_date_seconds" -le "$end_date_seconds" ]; do
    # Print the current date
    echo "Processing date: $current_date"

    # Use sed to replace a specific date in README.md with the current date
    sed -i "s/$before_date/$current_date/g" README.md

    git commit --date="$sys_current_date" -am "$current_date"
    
    # Increment the current date by one day
    before_date=$current_date
    sys_current_date=$(date -d "$sys_current_date + 1 day" +"%Y-%m-%d")
    current_date=$(date -d "$sys_current_date" +"%d-%m-%Y")
    current_date_seconds=$((current_date_seconds + 86400))
done

# Print a message when the loop is done
echo "Date replacement complete!"
