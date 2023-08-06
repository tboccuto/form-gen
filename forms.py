from flask_wtf import FlaskForm
from wtforms import StringField
from wtforms.fields.html5 import EmailField, TelField
class LoginForm(FlaskForm):
    name = StringField('name:', id='name')
    phone = StringField('phone:', id='phone')
    email = StringField('email:', id='email')
    job = StringField('job:', id='job')
    alias = StringField('alias:', id='alias')

