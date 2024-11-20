from flask import Flask, render_template, jsonify
import mysql.connector

app = Flask(__name__)

# MySQL 데이터베이스 설정
db_config = {
    'user': 'root',
    'password': 'yourpassword',
    'host': 'localhost',
    'database': 'soccerdb'
}

@app.route('/')
def home():
    return render_template('home.html')

@app.route('/match')
def match_page():
    return render_template('matchPage.html')

@app.route('/match-data/<category>')
def match_data(category):
    connection = mysql.connector.connect(**db_config)
    cursor = connection.cursor(dictionary=True)

    # 카테고리에 따른 데이터 쿼리
    query = f"SELECT * FROM matches WHERE category = %s"  # 예시 쿼리
    cursor.execute(query, (category,))
    data = cursor.fetchall()

    connection.close()
    return jsonify(data)

if __name__ == '__main__':
    app.run(debug=True)