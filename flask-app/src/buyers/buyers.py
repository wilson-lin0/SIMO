from flask import Blueprint, request, jsonify, make_response, current_app
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
    cursor.execute('select * from Buyer where buyer_id = buyer_id'.format(buyer_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Creates a new buyer account
@buyers.route('/buyers/make', methods=['POST'])
def add_new_buyer():
    the_data = request.json
    current_app.logger.info(the_data)

    buyer_id = the_data['buyer_id']
    phone_number = the_data['phone_number']
    buyer_email = the_data['buyer_email']
    street_address = the_data['street_address']
    city = the_data['city']
    state = the_data['state']
    zip_code = the_data['zip_code']
    buyer_first_name = the_data['buyer_first_name']
    buyer_last_name = the_data['buyer_last_name']

    query = 'insert into Buyer (buyer_id, phone_number, buyer_email, street_address, city, state, zip_code, buyer_first_name, buyer_last_name) values ("'
    query += str(buyer_id) + '", "'
    query += str(phone_number) + '", "'
    query += buyer_email + '", "'
    query += street_address + '", "'
    query += city + '", "'
    query += state + '", "'
    query += str(zip_code) + '", "'
    query += buyer_first_name + '", "'
    query += buyer_last_name + '")'

    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return "Success"

@buyers.route('/buyers/put', methods=['PUT'])
def guide_update(id):
    guide = Guide.query.get(id)
    title = request.json['title']
    content = request.json['content']

    guide.title = title
    guide.content = content

    db.session.commit()
    return guide_schema.jsonify(guide)
