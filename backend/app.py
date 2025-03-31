from flask import Flask, request, jsonify
from flask_cors import CORS
import MySQLdb
# สำหรับ version ที่มีการเข้ารหัส ให้ import นี้:
# from werkzeug.security import check_password_hash

from datetime import datetime
import os

app = Flask(__name__)
CORS(app)
UPLOAD_FOLDER = 'product_images'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER


conn = MySQLdb.connect(
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

    cursor = conn.cursor(MySQLdb.cursors.DictCursor)
    if user_id:
        cursor.execute("SELECT * FROM Product WHERE seller_id = %s", (user_id,))
    else:
        cursor.execute("SELECT * FROM Product")
    products = cursor.fetchall()
    cursor.close()
    return jsonify(products), 200


@app.route('/add-product', methods=['POST'])
def add_product():
    try:
        product_name = request.form.get('product_name')
        description = request.form.get('description_')
        price = float(request.form.get('price'))
        stock_quantity = int(request.form.get('stock_quantity'))
        category_id = int(request.form.get('category_id'))
        category_name = request.form.get('category_name')
        user_id = request.form.get('user_id')
        image = request.files.get('image')

        if not all([product_name, price, stock_quantity, category_id, category_name, user_id, image]):
            return jsonify({'message': 'Missing required fields'}), 400

        # ตั้งชื่อไฟล์รูปไม่ให้ชนกัน
        timestamp = datetime.now().strftime("%Y%m%d%H%M%S")
        filename = f"{timestamp}_{image.filename}"
        image_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        image.save(image_path)

        # หาค่า product_id ใหม่
        cursor = conn.cursor()
        cursor.execute("SELECT MAX(product_id) FROM Product")
        result = cursor.fetchone()
        product_id = (result[0] or 0) + 1

        # INSERT ข้อมูลสินค้า
        sql = """
            INSERT INTO Product 
            (product_id, product_name, description_, price, stock_quantity, category_id, image_url, user_id, category_name) 
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        val = (product_id, product_name, description, price, stock_quantity, category_id, image_path, user_id, category_name)
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

