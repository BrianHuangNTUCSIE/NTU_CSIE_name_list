import base64

# Input and output file paths
input_file = "people.csv"
output_file = "csie_name_list.txt"

# Read the CSV file and process each line
with open(input_file, "r", encoding="utf-8") as infile, open(output_file, "w", encoding="utf-8") as outfile:
    next(infile)  # Skip header
    for line in infile:
        parts = line.strip().split(",")
        if len(parts) == 3:
            uid = parts[0]
            sn = base64.b64decode(parts[1]).decode("utf-8")
            given_name = base64.b64decode(parts[2]).decode("utf-8")
            outfile.write(f"{uid}, {sn}{given_name}\n")

print("csie_name_list.txt has been created with transformed names.")

