from app import *
from flask_sqlalchemy import SQLAlchemy 
import os



class User(db.Model):
    __tablename__ = 'Users'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50))
    phone = db.Column(db.String(50))
    email = db.Column(db.String(50))
    job = db.Column(db.String(50))
    alias = db.Column(db.String(50))
    test = db.Column(db.String(50))

def insert_data(**kwargs):
    db.session.add(User(**kwargs))
    db.session.commit()

def modify_data(the_id, col_name, user_input):
    user = User.query.filter_by(id=the_id).first()
    setattr(user, col_name, user_input)
    db.session.commit() 

def delete_data(the_id):
    the_user = User.query.filter_by(id=the_id).first()
    db.session.delete(the_user)
    db.session.commit()

def get_all_rows_from_table():
    users = User.query.all()
    return users 
    
