from flask import Flask, request, jsonify, send_from_directory


from flask_cors import CORS
from werkzeug.utils import secure_filename
# import MySQLdb
import pymysql
pymysql.install_as_MySQLdb()
# สำหรับ version ที่มีการเข้ารหัส ให้ import นี้:
# from werkzeug.security import check_password_hash

from datetime import datetime
import os

app = Flask(__name__)
CORS(app)
# CONFIG
UPLOAD_FOLDER = os.path.join('static', 'uploads')
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.config['MAX_CONTENT_LENGTH'] = 5 * 1024 * 1024  # 5MB

ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}
def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

# Make sure upload folder exists
os.makedirs(app.config['UPLOAD_FOLDER'], exist_ok=True)


conn = pymysql.connect(
    host="localhost",
    user="twindle",
    passwd="td3124",
    db="Twindle_db",
    cursorclass=pymysql.cursors.DictCursor,  
    autocommit=True  
)

@app.route('/')
def index():
    return '🟢 Flask Server is Running!'
@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    email = data.get('email')
    password = data.get('passwd')

    cursor = conn.cursor()
    cursor.execute("SELECT user_id, passwd, fname, lname, email, profile_pic FROM User WHERE email = %s", (email,))
    result = cursor.fetchone()
    cursor.close()

    if result is None:
        return jsonify({"message": "User not found"}), 404

    user_id = result['user_id']
    stored_password = result['passwd']
    fname = result['fname']
    lname = result['lname']
    email = result['email']
    profile_pic  = result['profile_pic']

    print(">>> Input password:", repr(password))
    print(">>> Stored password:", repr(stored_password))
    print(">>> lname from DB:", lname)
    if password == stored_password:
        return jsonify({
            'message': 'Login successful',
            'fname': fname,
            'lname': lname,
            'user_id': user_id,
            'profile_pic':profile_pic
        }), 200
    else:
        return jsonify({"message": "Incorrect password"}), 401
    



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
@app.route('/reviews/<user_id>', methods=['GET'])
def get_reviews(user_id):
    try:
        with conn.cursor(pymysql.cursors.DictCursor) as cursor:
            cursor.execute("""
                SELECT reviewer_name, rating, review_text
                FROM Reviews
                WHERE user_id = %s
            """, (user_id,))
            reviews = cursor.fetchall()
            return jsonify(reviews), 200
    except Exception as e:
        print("Get Reviews Error:", str(e))
        return jsonify({"error": str(e)}), 500


@app.route('/sellers', methods=['GET'])
def get_sellers():
    cursor = conn.cursor(pymysql.cursors.DictCursor)
    cursor.execute("SELECT * FROM User")  # ชื่อ table อาจต้องตรงกับ DB ของคุณ
    sellers = cursor.fetchall()
    cursor.close()
    return jsonify(sellers), 200

@app.route('/seller_products/<user_id>', methods=['GET'])
def get_seller_products(user_id):
    try:
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        cursor.execute("SELECT * FROM Product WHERE user_id = %s", (user_id,))
        products = cursor.fetchall()
        print("Seller Products:", products)  # Debug line
        cursor.close()
        return jsonify(products), 200
    except Exception as e:
        print("Error in /seller_products:", str(e))  # แสดง Error จริง
        return jsonify({'error': str(e)}), 500

@app.route('/add-product', methods=['POST'])
def upload_product():
    try:
        print("request.form:", request.form)
        print("request.files:", request.files)

        # รับข้อมูลจาก Flutter
        name = request.form.get('product_name')
        description = request.form.get('description')
        brand = request.form.get('brand')
        price = request.form.get('price')
        quality = request.form.get('qualityStatus')
        category_id = request.form.get('category_id')
        user_id = request.form.get('user_id')
        category_name = request.form.get('category_name')

        # ตรวจสอบไฟล์ภาพ
        if 'image' not in request.files:
            return jsonify({"error": "No image file provided"}), 400

        image = request.files['image']
        if image.filename == '':
            return jsonify({"error": "Empty image filename"}), 400

        # เช็คชนิดไฟล์
        if not allowed_file(image.filename):
            return jsonify({"error": "File type not allowed"}), 400

        # บันทึกไฟล์
        filename = secure_filename(image.filename)
        image_save_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        image_url = f"static/uploads/{filename}"
        image.save(image_save_path)

        # INSERT ลง MySQL
        cursor = conn.cursor()
        cursor.execute("""
            INSERT INTO Product (
                product_name, description_, brand, price, qualityStatus,
                category_id, image_url, user_id, category_name
            )
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, (
            name, description, brand, price, quality, category_id, image_url, user_id, category_name
        ))
        conn.commit()
        cursor.close()

        return jsonify({
            "message": "✅ Product uploaded successfully",
            "image_url": image_url
        }), 200

    except Exception as e:
        print("Error:", str(e))
        return jsonify({"error": str(e)}), 500

@app.route('/delete-product/<int:product_id>', methods=['DELETE'])
def delete_product(product_id):
    try:
        print(f" Trying to delete product ID: {product_id}")
        cursor = conn.cursor()

        #  ค้นหา path รูปภาพก่อนลบ
        cursor.execute("SELECT image_url FROM Product WHERE product_id = %s", (product_id,))
        result = cursor.fetchone()
        print(" Fetched product for deletion:", result)

        if not result:
            return jsonify({"error": "Product not found"}), 404

        image_url = result['image_url'] if isinstance(result, dict) else result[0]
        image_path = os.path.join(os.getcwd(), image_url)

        # ลบสินค้าออกจาก DB
        cursor.execute("DELETE FROM Product WHERE product_id = %s", (product_id,))
        conn.commit()
        cursor.close()
        print(" Deleted product from DB")

        # 3️⃣ ลบไฟล์รูป (ถ้ามีอยู่จริง)
        if os.path.exists(image_path):
            os.remove(image_path)
            print(f"Deleted image file: {image_path}")
        else:
            print("Image file not found:", image_path)

        return jsonify({"message": "✅ Product deleted successfully"}), 200

    except Exception as e:
        print(f"Delete Error: {e.__class__.__name__} - {str(e)}")
        return jsonify({"error": str(e)}), 500

    
if __name__ == '__main__':
    if not os.path.exists(UPLOAD_FOLDER):
        os.makedirs(UPLOAD_FOLDER)
    #ให้แอป "รับ request จากทุก IP"
    app.run(host='0.0.0.0', port=5000)

