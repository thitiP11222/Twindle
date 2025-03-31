from flask import Flask, request, jsonify
from flask_cors import CORS
import MySQLdb
# สำหรับ version ที่มีการเข้ารหัส ให้ import นี้:
# from werkzeug.security import check_password_hash

app = Flask(__name__)
CORS(app)

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


    
if __name__ == '__main__':
    #ให้แอป "รับ request จากทุก IP"
    app.run(host='0.0.0.0', port=5000)

