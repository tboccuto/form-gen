import forms
from forms import *
from forms import *
from flask import render_template, request, redirect, url_for
#import forms

def index():
    form = forms.LoginForm()
    return render_template('index.html', form=form)

def view_database():
    from app import get_all_rows_from_table
    rows = get_all_rows_from_table()
    
    return render_template('entire_database.html', rows=rows)

def modify_database(the_id ,modified_category):
    if request.method == 'POST':
        from app import modify_data
        user_input = request.form[modified_category]
        modify_data(the_id, modified_category, user_input)
        return redirect(url_for('view_database'))
    return redirect(url_for('index'))

def delete(the_id):
    if request.method == 'POST':
        from app import delete_data
        if 'remove' in request.form:
            delete_data(the_id)
    return redirect(url_for('view_database'))

def submitted():
    from app import insert_data
    if request.method == 'POST':
        insert_data(**{k: v for k,v in request.form.items() if k !='csrf_token'})
    return render_template('submitted.html')
