from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

user = Blueprint('user', __name__)

# Get all the products from the database
@user.route('/user', methods=['GET'])
def get_user():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM User')
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

# Creates a new user 
@user.route('/user/new', methods=['POST'])
def add_new_user():
    the_data = request.json
    current_app.logger.info(the_data)

    nuid = the_data['nuid']
    first_name = the_data['first_name']
    last_name = the_data['last_name']
    password = the_data['password']
    user_status = the_data['user_status']

    query = 'insert into User (nuid, first_name, last_name, password, user_status) values ("'
    query += str(nuid) + '", "'
    query += (first_name) + '", "'
    query += (last_name) + '", "'
    query += (password) + '", "'
    query += str(user_status) + '")'

    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return "Success"