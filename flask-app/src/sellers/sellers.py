from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

sellers = Blueprint('sellers', __name__)

# Get all sellers from the DB
@sellers.route('/sellers', methods=['GET'])
def get_sellers():
    cursor = db.get_db().cursor()
    cursor.execute('select seller_first_name, seller_last_name,\
        phone_number, seller_email from Seller')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get seller detail for seller with particular userID
@sellers.route('/sellers/<seller_id>', methods=['GET'])
def get_sellers_id(seller_id):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Seller where seller_id = seller_id'.format(seller_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get seller detail for seller with particular first name
@sellers.route('/sellers/first-name/<seller_first_name>', methods=['GET'])
def get_sellers_first_name(seller_first_name):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Seller where seller_first_name = seller_first_name'.format(seller_first_name))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get seller detail for seller with particular last name
@sellers.route('/sellers/last-name/<seller_last_name>', methods=['GET'])
def get_sellers_last_name(seller_last_name):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Seller where seller_last_name = seller_last_name'.format(seller_last_name))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get seller detail for seller with particular userID
@sellers.route('/sellers/street_address/<street_address>', methods=['GET'])
def get_sellers_street_address(street_address):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Seller where street_address = street_address'.format(street_address))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Makes a new seller
@sellers.route('/sellers', methods=['POST'])
def add_new_seller():
    cursor = db.get_db().cursor()
    req_data = request.get_json()
    current_app.logger.info(req_data)

    seller_id = req_data['seller_id']
    phone_number = req_data['phone_number']
    seller_email = req_data['seller_email']
    street_address = req_data['street_address']
    city = req_data['city']
    state = req_data['state']
    zip_code = req_data['zip_code']
    seller_first_name = req_data['seller_first_name']
    seller_last_name = req_data['seller_last_name']
    
    query = 'INSERT INTO Seller (seller_id, phone_number, seller_email, street_address, city, \
        state, zip_code, seller_first_name, seller_last_name) \
        VALUES ("' + str(seller_id) + '", "' + phone_number + '", "' + seller_email + '", "' + street_address + '", \
            "' + city + '", "' + state + '", "' + zip_code + '",  "' + seller_first_name + '",\
                 "' + seller_last_name + '")'
    
    current_app.logger.info(query)

    cursor.execute(query)
    db.get_db().commit()
    return "Success"

# Updates a seller
@sellers.route('/sellers', methods=['PUT'])
def update_seller():
    cursor = db.get_db().cursor()
    req_data = request.get_json()
    current_app.logger.info(req_data)

    seller_id = req_data['seller_id']
    phone_number = req_data['phone_number']
    seller_email = req_data['seller_email']
    street_address = req_data['street_address']
    city = req_data['city']
    state = req_data['state']
    zip_code = req_data['zip_code']
    seller_first_name = req_data['seller_first_name']
    seller_last_name = req_data['seller_last_name']
    
    query = 'UPDATE INTO Seller (seller_id, phone_number, seller_email, street_address, city, \
        state, zip_code, seller_first_name, seller_last_name) \
        VALUES ("' + str(seller_id) + '", "' + phone_number + '", "' + seller_email + '", "' + street_address + '", \
            "' + city + '", "' + state + '", "' + zip_code + '", "' + seller_first_name + '",\
                 "' + seller_last_name + '")'
    
    current_app.logger.info(query)

    cursor.execute(query)
    db.get_db().commit()
    return "Success"

# Delete the seller with particular userID
@sellers.route('/sellers/<seller_id>', methods=['DELETE'])
def delete_seller(seller_id):
    cursor = db.get_db().cursor()
    cursor.execute('DELETE * from Seller where seller_id = seller_id'.format(seller_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response