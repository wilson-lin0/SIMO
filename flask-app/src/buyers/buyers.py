from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


buyers = Blueprint('buyers', __name__)

# Get all buyers from the DB
@buyers.route('/buyers', methods=['GET'])
def get_buyers():
    cursor = db.get_db().cursor()
    cursor.execute('select buyer_first_name, buyer_last_name,\
        phone_number, buyer_email from Buyer')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get buyer's detail for buyer with particular userID
@buyers.route('/get-buyer/<buyer_id>', methods=['GET'])
def get_buyers_id(buyer_id):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Buyer where buyer_id = {0}'.format(buyer_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Makes a new buyer
@buyers.route('/new-buyer', methods=['POST'])
def add_new_buyer():
    cursor = db.get_db().cursor()
    req_data = request.get_json()
    current_app.logger.info(req_data)

    buyer_id = req_data['buyer_id']
    phone_number = req_data['phone_number']
    buyer_email = req_data['buyer_email']
    street_address = req_data['street_address']
    city = req_data['city']
    state = req_data['state']
    zip_code = req_data['zip_code']
    buyer_first_name = req_data['buyer_first_name']
    buyer_last_name = req_data['buyer_last_name']
    
    query = 'INSERT INTO Buyer (buyer_id, phone_number, buyer_email, street_address, city, \
        state, zip_code, buyer_first_name, buyer_last_name) \
        VALUES ("' + str(buyer_id) + '", "' + phone_number + '", "' + buyer_email + '", "' + street_address + '", \
            "' + city + '", "' + state + '", "' + zip_code + '",  "' + buyer_first_name + '",\
                 "' + buyer_last_name + '")'
    
    current_app.logger.info(query)

    cursor.execute(query)
    db.get_db().commit()
    return "Success"

# Updates a buyer
@buyers.route('/buyers', methods=['PUT'])
def update_buyer():
    cursor = db.get_db().cursor()
    req_data = request.get_json()
    current_app.logger.info(req_data)

    buyer_id = req_data['buyer_id']
    phone_number = req_data['phone_number']
    buyer_email = req_data['buyer_email']
    street_address = req_data['street_address']
    city = req_data['city']
    state = req_data['state']
    zip_code = req_data['zip_code']
    buyer_first_name = req_data['buyer_first_name']
    buyer_last_name = req_data['buyer_last_name']
    
    query = 'UPDATE INTO Buyer (buyer_id, phone_number, buyer_email, street_address, city, \
        state, zip_code, buyer_first_name, buyer_last_name) \
        VALUES ("' + str(buyer_id) + '", "' + phone_number + '", "' + buyer_email + '", "' + street_address + '", \
            "' + city + '", "' + state + '", "' + zip_code + '", "' + buyer_first_name + '",\
                 "' + buyer_last_name + '")'
    
    current_app.logger.info(query)

    cursor.execute(query)
    db.get_db().commit()
    return "Success"

# Delete the buyer with particular userID
@buyers.route('/buyers/<buyer_id>', methods=['DELETE'])
def delete_buyer(buyer_id):
    cursor = db.get_db().cursor()
    cursor.execute('DELETE * from Buyer where buyer_id = buyer_id'.format(buyer_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
