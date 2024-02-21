from flask import Flask
from db import connect_to_db
from datetime import datetime

app = Flask(__name__)

conn = connect_to_db()
cursor = conn.cursor()

# @app.route('/exercise/output', methods=['GET'])
def exercise_output(member_id, exercise_name, exercise_count, exercise_time):
    record_id = get_record_id();
    exercise_id = get_exercise_id(exercise_name);
    insert_exercise_record(member_id, exercise_id, record_id, exercise_count, exercise_time)
    cursor.close()
    conn.close()

def insert_exercise_record(member_id, exercise_id, record_id, exercise_count, exercise_time):
    try:
        time = datetime.today().strftime("%Y-%m-%d %H:%M:%S")
        sql = """INSERT INTO record (average_heart_rate, calories_burned_sum, exercise_count, exercise_time, created_time, exercise_id, id, member_id, modified_at) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)"""
        data = (None, None, exercise_count, exercise_time, time, exercise_id, record_id, member_id, time)
        cursor.execute(sql, data)
        conn.commit()
    except:
        print("Fail to insert exercise record")

def get_exercise_id(exercise_name):
    try:
        exercise_mapping = ["스쿼트", "숄더프레스", "레터럴레이즈", "헌드레드", "플랭크", "프론트레이즈", "제트업", "브릿지", "스트레칭1", "스트레칭2", "스트레칭3"]
        return exercise_mapping.index(exercise_name) + 1
    except:
        print("Fail to get exercise id")

def get_record_id():
    try:
        sql = """SELECT COALESCE(MAX(id), 0) + 1 FROM record"""
        cursor.execute(sql)
        get_record_row = cursor.fetchone()
        return get_record_row[0] + 1
    except:
        print("Fail to get record id")
        
if __name__== "__main__":
    app.run(debug=True)

