
import routes
from flask import Flask
import os 
#from flask_sqlalchemy import SQLAlchemy 
import click
from flask_sqlalchemy import SQLAlchemy 
app = Flask(__name__)
app.config['SECRET_KEY'] = 'A secret'
app.add_url_rule('/', view_func=routes.index)
app.add_url_rule('/submitted', methods=['GET', 'POST'], view_func=routes.submitted)
app.add_url_rule('/database', view_func=routes.view_database)
app.add_url_rule('/modify<the_id>/<modified_category>', methods=['GET', 'POST'], view_func=routes.modify_database)
app.add_url_rule('/delete<the_id>', methods=['GET', 'POST'], view_func=routes.delete)
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False # no warning messages
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///info.db' # for using the sqlite database
db = SQLAlchemy(app)
#cli code
@app.cli.command('title')
@click.argument('args', nargs=-1)
def make_title(args):
  os.system('./index.sh ' + ' '.join(args))  

@app.cli.command('model')
@click.argument('args', nargs=-1)
def make_model(args):
  os.system('./db.sh ' + ' '.join(args))  

@app.cli.command('forms')
@click.argument('args', nargs=-1)
def make_form(args):
  os.system('./forms.sh ' + ' '.join(args))  

if __name__ == '__main__':
  app.run()