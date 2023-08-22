#!/bin/bash
#Example usage ./db.sh name phone email job > user_class.py gernerates user model.
if [ $# -lt 1 ]; then
  echo "Usage: $0 field1 [field2 field3 ...]"
  exit 1
fi
imports="from app import *\n"
imports+="from flask_sqlalchemy import SQLAlchemy\n"
imports+="import os\n"
class_name="${1%?}"$''
class_code+="class $class_name(db.Model):\n"
table_name="${1%?}"$''
class_code+="    __tablename__ = '$1'\n"
class_code+="    id = db.Column(db.Integer, primary_key=True)\n"
for ((i = 2; i <= $#; i++)); do
   field="${!i}" 
  class_code+="    ${field} = db.Column(db.String(50))\n" 
done


class_code+="def insert_data(**kwargs):\n"
class_code+="    db.session.add($class_name(**kwargs))\n"
class_code+="    db.session.commit()\n"
class_code+="\n"
class_code+="def modify_data(the_id, col_name, user_input):\n"
class_code+="    filter = $class_name.query.filter_by(id=the_id).first()\n"
class_code+="    setattr(filter, col_name, user_input)\n"
class_code+="    db.session.commit()\n"
class_code+="\n"
class_code+="def delete_data(the_id):\n"
class_code+="    el = $class_name.query.filter_by(id=the_id).first()\n"
class_code+="    db.session.delete(el)\n"
class_code+="    db.session.commit()\n"
class_code+="\n"
class_code+="def get_all_rows_from_table():\n"
class_code+="    return $class_name.query.all()\n"

#echo -e "$class_code" >> app.py
echo -e "$imports" >> model.py
echo -e "db = SQLAlchemy(app)" >> model.py
echo -e "$class_code" >> model.py
echo -e "db.create_all()" >> model.py
#app_import="from model import *"
sed -i '1 i\from model import *' app.py
#echo -e "$app_import" >> app.py
#awk -v class_code="$class_code" '/^db = SQLAlchemy\(app\)$/ {print; printf "%s", class_code; next} 1' app.py > temp_app.py
#mv temp_app.py app.py