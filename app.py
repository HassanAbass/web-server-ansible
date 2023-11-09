from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

# Database configuration
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://db_user:Passw0rd@localhost/employee_db'

# Create a SQLAlchemy instance
db = SQLAlchemy(app)

# Define a model for your table
class Employees(db.Model):
    name = db.Column(db.String(255))
    id = db.Column(db.Integer, primary_key=True)
# Example route to query your database
@app.route('/')
def index():
    records = Employees.query.all()
    result = [{"name": record.name} for record in records]
    return str(result)

if __name__ == '__main__':
    app.run()
