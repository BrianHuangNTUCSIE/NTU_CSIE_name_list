#!/bin/bash

# Define output file
OUTPUT_FILE="people.csv"

# Write CSV header
echo "UID,Surname,GivenName" > "$OUTPUT_FILE"

# Perform LDAP search and process the output
ldapsearch -x -b "ou=people,dc=csie,dc=ntu,dc=edu,dc=tw" "(objectClass=person)" uid sn givenName | \
awk 'BEGIN { uid=""; sn=""; givenName=""; }
    /^uid: / { uid=$2; }
    /^sn:: / { sn=$2; }
    /^givenName:: / { givenName=$2; }
    /^$/ { if (uid && sn && givenName) print uid "," sn "," givenName; uid=""; sn=""; givenName=""; }' >> "$OUTPUT_FILE"

# Inform the user
echo "Step 1: people.csv has been generated successfully."

# Execute the Python script to process the CSV
python3 convert.py

# Remove the CSV file after processing
rm "$OUTPUT_FILE"

# Final message
echo "Step 2: Name list has been created in csie_name_list.txt and temporary files are removed."

