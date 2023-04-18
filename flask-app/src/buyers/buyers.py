from flask import Blueprint, request, jsonify, make_response
import json
from src import db


buyers = Blueprint('buyers', __name__)

# Get all buyers from the DB
@buyers.route('/buyers', methods=['GET'])
def get_buyers():
    cursor = db.get_db().cursor()
    cursor.execute('select buyer_first_name, buyer_last_name,\
        phone_number, buyer_email, total_buyer_rating from Buyer')
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
@buyers.route('/buyers/<buyer_id>', methods=['GET'])
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