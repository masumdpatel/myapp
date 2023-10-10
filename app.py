from flask import Flask, render_template, request, redirect, url_for, flash
from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField

app = Flask(__name__)
app.secret_key = 'your_secret_key'  # Replace with a strong secret key

# Sample data - You can replace this with a database
tasks = []

class TaskForm(FlaskForm):
    task_description = StringField('Task Description')
    submit = SubmitField('Add Task')

@app.route('/', methods=['GET', 'POST'])
def index():
    form = TaskForm()
    
    if form.validate_on_submit():
        task_description = form.task_description.data
        tasks.append(task_description)
        flash('Task added successfully!', 'success')
        return redirect(url_for('index'))

    return render_template('index.html', tasks=tasks, form=form)

if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0')

