#!/bin/bash
#Example usage ./db.sh name phone email job > user_class.py gernerates user model.
if [ $# -lt 1 ]; then
  echo "Usage: $0 field1 [field2 field3 ...]"
  exit 1
fi
imports="from app import *\n"
imports+="from flask_sqlalchemy import SQLAlchemy\n"
imports+="import os\n"



table_name="Users"
class_code+="class $table_name(db.Model):\n"
class_code+="    __tablename__ = '${table_name}'\n"
class_code+="    id = db.Column(db.Integer, primary_key=True)\n"
for field in "$@"; do
  class_code+="    ${field} = db.Column(db.String(50))\n"
done

class_code+="def insert_data(**kwargs):\n"
class_code+="    db.session.add($table_name(**kwargs))\n"
class_code+="    db.session.commit()\n"
class_code+="\n"
class_code+="def modify_data(the_id, col_name, user_input):\n"
class_code+="    filter = ($table_name).query.filter_by(id=the_id).first()\n"
class_code+="    setattr(user, col_name, user_input)\n"
class_code+="    db.session.commit()\n"
class_code+="\n"
class_code+="def delete_data(the_id):\n"
class_code+="    el = User.query.filter_by(id=the_id).first()\n"
class_code+="    db.session.delete(el)\n"
class_code+="    db.session.commit()\n"
class_code+="\n"
class_code+="def get_all_rows_from_table():\n"
class_code+="    return $table_name.query.all()\n"

#echo -e "$class_code" >> app.py
echo -e "$imports" >> temp.py
echo -e "$class_code" >> temp.py
#awk -v class_code="$class_code" '/^db = SQLAlchemy\(app\)$/ {print; printf "%s", class_code; next} 1' app.py > temp_app.py
#mv temp_app.py app.py