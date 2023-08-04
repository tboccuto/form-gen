#!/bin/bash
#Example usage ./db.sh name phone email job > user_class.py
if [ $# -lt 1 ]; then
  echo "Usage: $0 field1 [field2 field3 ...]"
  exit 1
fi
table_name="Users"
class_code="class ${table_name}(db.Model):\n"
class_code+="    __tablename__ = '${table_name}'\n"
class_code+="    id = db.Column(db.Integer, primary_key=True)\n"
for field in "$@"; do
  class_code+="    ${field} = db.Column(db.String(50))\n"
done
echo -e "$class_code"

ret=$(ls -t | head -n1)


echo "from ${ret%.*} import *" | cat - app.py > temp && mv temp app.py
 
