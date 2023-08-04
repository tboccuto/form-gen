#!/bin/bash
#Example usage ./generate_user_class.sh name phone email job > user_class.py
# Check if at least one argument is provided
if [ $# -lt 1 ]; then
  echo "Usage: $0 field1 [field2 field3 ...]"
  exit 1
fi

# Get the table name (class name)
table_name="Users"

# Start generating the class code
class_code="class ${table_name}(db.Model):\n"
class_code+="    __tablename__ = '${table_name}'\n"
class_code+="    id = db.Column(db.Integer, primary_key=True)\n"

# Iterate through the arguments (fields) and add them to the class code
for field in "$@"; do
  class_code+="    ${field} = db.Column(db.String(50))\n"
done

# Print the generated class code
echo -e "$class_code"

