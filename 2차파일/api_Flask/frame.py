from flask import Flask, request, Response
from db import connect_to_db
from pymysql import connect
import os, sys
sys.path.append(os.path.dirname(os.path.abspath(os.path.dirname(__file__))))
import ready
import camera

app = Flask(__name__)

@app.route("/<int:memberId>/<int:routineId>/<int:routineDetailId>/start", methods=["POST"])
def start(memberId, routineId, routineDetailId):
    conn = connect_to_db()
    cursor = conn.cursor()
    cursor.execute("""SELECT rd.exercise_name, rd.exercise_count 
                   FROM routine r 
                   JOIN routine_detail rd ON r.id = rd.routine_id 
                   WHERE r.member_id = %s AND r.id = %s AND rd.id = %s;""", (memberId, routineId, routineDetailId))
    results = cursor.fetchall()
    cursor.close()
    conn.close()
    print(results[0][0])
    print(results[0][1])
    result = ready.selectExercise(results[0][0],results[0][1])
    return result


UPLOAD_FOLDER = 'uploads'
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

@app.route("/frame", methods=["POST"])
def frame():
     file = request.files['file']
     camera.gen(file)
     return "Success"


if __name__ == '__main__':
    app.run(debug=True)