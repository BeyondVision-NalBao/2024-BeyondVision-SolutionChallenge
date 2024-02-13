from flask import Flask, request, Response
from db import connect_to_db
from pymysql import connect
import os, sys
sys.path.append(os.path.dirname(os.path.abspath(os.path.dirname(__file__))))
import ready

app = Flask(__name__)

@app.route("/<int:memberId>/<int:routineId>/<int:routineDetailId>/start", methods=["POST"]) #클라이언트 정보를 select운동 어쩌구에 넘기는 함수
def start(memberId, routineId, routineDetailId):
    conn = connect_to_db()
    cursor = conn.cursor()
    cursor.execute("""SELECT rd.exercise_name, rd.exercise_count 
                   FROM routine r 
                   JOIN routine_detail rd ON r.id = rd.routine_id 
                   WHERE r.member_id = %s AND r.id = %s AND rd.id = %s;""", (memberId, routineId, routineDetailId))
    results = cursor.fetchall() #여기에 운동정보, 횟수, 고객정보 들어있음
    cursor.close()
    conn.close()
    result = ready.selectExercise(results[0][0],results[0][1])
    print(result)
    return str(result) #postnat


UPLOAD_FOLDER = 'uploads'
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

@app.route("/<int:memberId>/<int:routineDetailId>/frame", methods=["POST"])
def start_2(memberId, routineDetailId):
     file = request.files['frame']
     filename = file.filename
     file_path = os.path.join(UPLOAD_FOLDER, filename)
     file.save(file_path)
     'File successfully uploaded to {}'.format(file_path)
     return "successful"


if __name__ == '__main__':
    app.run(debug=True)