from flask import Flask, jsonify
import mysql.connector

app = Flask(__name__)

# MySQL 연결
db = mysql.connector.connect(
    host="localhost",  # MySQL 서버 호스트
    user="root",       # MySQL 사용자
    password="yourpassword",  # MySQL 비밀번호
    database="yourdatabase"   # MySQL 데이터베이스 이름
)

@app.route('/stadiums', methods=['GET'])
def get_stadiums():
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Stadium")  # Stadium 테이블에서 데이터 가져오기
    stadiums = cursor.fetchall()
    cursor.close()
    return jsonify(stadiums)  # JSON 형식으로 반환

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)