from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

products = Blueprint('products', __name__)

# Get all the products sorted by alphabet
@products.route('/products', methods=['GET'])
def get_user():
    cursor = db.get_db().cursor()
    cursor.execute('select * from Products order by product_name asc')
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

# get only products in a specific category
@products.route('/products/<category_id>', methods=['GET'])
def get_category_products(category_id):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Products where category_id = {0}'.format(category_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Creates a new product post
@products.route('/products/new', methods=['POST'])
def add_new_product():
    the_data = request.json
    current_app.logger.info(the_data)

    product_name = the_data['product_name']
    description = the_data['description']
    price = the_data['price']
    category_id = the_data['category_id']
    condition_type = the_data['condition_type']
    seller_id = the_data['seller_id']

    query = 'insert into Products (product_name, description, price, category_id, condition_type, seller_id) values ("'
    query += (product_name) + '", "'
    query += (description) + '", "'
    query += price + '", "'
    query += str(category_id) + '", "'
    query += condition_type + '", "'
    query += str(seller_id) + '")'

    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return "Success"


@products.route('/products/delete/<product_id>', methods=['DELETE'])
def delete_product(product_id):
    cursor = db.get_db().cursor()
    cursor.execute('delete from Products where product_id = {0}'.format(product_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


# Updates a product price
@products.route('/put-new-price/<product_id>/<price>', methods=['PUT'])
def update_seller(product_id, price):
    cursor = db.get_db().cursor()
    req_data = request.get_json()
    current_app.logger.info(req_data)

    query = 'UPDATE Products SET price = "' + price + '" WHERE product_id = ' + str(product_id)
    
    current_app.logger.info(query)

    cursor.execute(query)
    db.get_db().commit()
    return "Success"

# Delete the seller with particular userID
@products.route('/products/<product_id>', methods=['DELETE'])
def delete_seller(product_id):
    cursor = db.get_db().cursor()
    cursor.execute('DELETE * from Products where product_id = {0}'.format(product_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Creates a new request post
@products.route('/request/new', methods=['POST'])
def add_new_request():
    the_data = request.json
    current_app.logger.info(the_data)

    request_id = the_data['request_id']
    nuid = the_data['nuid']
    request_name = the_data['request_name']
    category_id = the_data['category_id']
    condition_type = the_data['condition_type']
    description = the_data['description']
    upper_price_range = the_data['upper_price_range']
    lower_price_range = the_data['lower_price_range']

    query = 'insert into Requests (request_id, nuid, request_name, category_id, condition_type, description, upper_price_range, lower_price_range) values ("'
    query += str(request_id) + '", "'
    query += str(nuid) + '", "'
    query += request_name + '", "'
    query += str(category_id) + '", "'
    query += condition_type + '", "'
    query += description + '","'
    query += upper_price_range + '", "'
    query += lower_price_range + '")'

    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return "Success"

# get requests
@products.route('/requests', methods=['GET'])
def get_requests():
    cursor = db.get_db().cursor()
    cursor.execute('select * from Requests')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# get orders based on seller_id for the seller
@products.route('/orders-seller/<seller_id>', methods=['GET'])
def get_orders_seller(seller_id):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Orders where seller_id = {0}'.format(seller_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# get orders based on buyer_id for the buyer
@products.route('/orders-buyer/<buyer_id>', methods=['GET'])
def get_orders_buyer(buyer_id):
    cursor = db.get_db().cursor()
    cursor.execute('select * from Orders where buyer_id = {0}'.format(buyer_id))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response