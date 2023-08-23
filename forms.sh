#!/bin/bash
#Example usage ./forms.sh name phone email job > user_class.py gernerates the model for form.

if [ $# -lt 1 ]; then
  echo "Usage: $0 field1 [field2 field3 ...]"
  exit 1
fi
table_name="LoginForm"
class_code="from flask_wtf import FlaskForm\n"

class_code+="from wtforms import StringField\n"
class_code+="from wtforms.fields.html5 import EmailField, TelField\n"

class_code+="class ${table_name}(FlaskForm):\n"
#class_code+="    id = db.Column(db.Integer, primary_key=True)\n"
#class_code+="    id = db.Column(db.Integer, primary_key=True)\n"
for field in "$@"; do
  #class_code+="    ${field} = db.Column(db.String(50))\n"
  class_code+="    ${field} = StringField('$field:', id='$field')\n"
done
echo -e "$class_code"
echo -e "$class_code" >> forms.py
sed -i '1i import forms' routes.py