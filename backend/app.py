from flask import Flask, request, jsonify
from flask_cors import CORS
# import MySQLdb
import pymysql
pymysql.install_as_MySQLdb()
# สำหรับ version ที่มีการเข้ารหัส ให้ import นี้:
# from werkzeug.security import check_password_hash

from datetime import datetime
import os

app = Flask(__name__)
CORS(app)
UPLOAD_FOLDER = 'product_images'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER


conn = pymysql.connect(
    host="localhost",
    user="twindle",
    passwd="td3124",
    db="Twindle_db"
)

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    email = data.get('email')
    password = data.get('passwd')

    cursor = conn.cursor()
    cursor.execute("SELECT passwd, fname FROM User WHERE email = %s", (email,))

    result = cursor.fetchone()
    cursor.close()

    if result:
        stored_password = result[0]
        fname = result[1]
        # กรณีเป็น plain text:
        if password == stored_password:
            return jsonify({'message': 'Login successful',
            'fname': fname}), 200
        else:
            return jsonify({"message": "Incorrect password"}), 401
    else:
        return jsonify({"message": "User not found"}), 404


@app.route('/products', methods=['GET'])
def get_products():
    user_id = request.args.get('user_id')

    cursor = conn.cursor(pymysql.cursors.DictCursor)
    if user_id:
        cursor.execute("SELECT * FROM Product WHERE user_id = %s", (user_id,))
    else:
        cursor.execute("SELECT * FROM Product")
    products = cursor.fetchall()
    cursor.close()
    return jsonify(products), 200

@app.route('/sellers', methods=['GET'])
def get_sellers():
    cursor = conn.cursor(pymysql.cursors.DictCursor)
    cursor.execute("SELECT * FROM User")  # ชื่อ table อาจต้องตรงกับ DB ของคุณ
    sellers = cursor.fetchall()
    cursor.close()
    return jsonify(sellers), 200


@app.route('/add-product', methods=['POST'])
def add_product():
    try:
        data = request.get_json()

        # รับค่าจาก JSON
        product_name = data.get('product_name')
        description = data.get('description_')
        price = float(data.get('price'))
        stock_quantity = int(data.get('stock_quantity'))
        category_id = int(data.get('category_id'))
        category_name = data.get('category_name')
        user_id = data.get('user_id')

        # ตั้งค่า image_url ให้เป็น default
        image_url = "assets/imgs/product/default.png"

        # ตรวจสอบข้อมูลไม่ให้ว่าง
        if not all([product_name, price, stock_quantity, category_id, category_name, user_id]):
            return jsonify({'error': 'Missing required fields'}), 400

        # หาค่า product_id ถ้ายังไม่ได้ใช้ AUTO_INCREMENT
        cursor = conn.cursor()
        cursor.execute("SELECT MAX(product_id) FROM Product")
        result = cursor.fetchone()
        product_id = (result[0] or 0) + 1

        # เพิ่มสินค้า
        sql = """
            INSERT INTO Product 
            (product_id, product_name, description_, price, stock_quantity, category_id, image_url, user_id, category_name)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        val = (product_id, product_name, description, price, stock_quantity, category_id, image_url, user_id, category_name)
        cursor.execute(sql, val)
        conn.commit()
        cursor.close()

        return jsonify({'message': 'Product added successfully'}), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500

    
if __name__ == '__main__':
    if not os.path.exists(UPLOAD_FOLDER):
        os.makedirs(UPLOAD_FOLDER)
    #ให้แอป "รับ request จากทุก IP"
    app.run(host='0.0.0.0', port=5000)

