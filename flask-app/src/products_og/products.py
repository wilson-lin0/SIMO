from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

products = Blueprint('products', __name__)

# Get all the products from the database
@products.route('/products', methods=['GET'])
def get_products():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM products')
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

# get the top 5 products from the database
@products.route('/mostExpensive')
def get_most_pop_products():
    cursor = db.get_db().cursor()
    query = '''
        SELECT product_code, product_name, list_price, reorder_level
        FROM products
        ORDER BY list_price DESC
        LIMIT 5
    '''
    cursor.execute(query)
       # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

@products.route('/product', methods=['POST'])
def add_new_product():
    # access json data from request object
    the_data = request.json
    p_name = the_data['product_name'] # whatever you named the variable in appsmith
    p_descr = the_data['product_description']
    p_price = the_data['product_price']

    # construct the insert statement
    the_query = 'insert into products (product_name, description, list_price)'
    the_query += 'values (''+ p_name + '', '' + p_descr + '', ' + str(p_price) + ')'

    current_app.logger.info(the_query)
    
    # execute the query    
    cursor = db.get.db().cursor()
    cursor.execute(the_query)
    db.get_db().commit()

    return 'Success!'

@products.route('/categories', methods = ['GET'])
def get_all_categories():
    query = '''
                SELECT DISTINCT category AS label, category as value
                FROM Products
                WHERE Category IS NOT NULL
                ORDER BY Category
            '''
    cursor = db.get_db().cursor
    cursor.execute(query)
    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)