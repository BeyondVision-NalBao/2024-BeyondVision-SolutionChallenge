from flask import Flask, request, Response, jsonify
from db import connect_to_db
from pymysql import connect
import os, sys
sys.path.append(os.path.dirname(os.path.abspath(os.path.dirname(__file__))))
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'
import ready
import camera

app = Flask(__name__)

#미사용
@app.route("/api/v1/ml/<int:memberId>/ready", methods=["POST"])
def ready_exercise(memberId):
    data = request.json
    routineName = data['routineName']

    conn = connect_to_db()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM routine_detail WHERE routine_id = (SELECT id FROM routine WHERE member_id = %s AND name = %s)", (memberId, routineName))
    results = cursor.fetchall()
    cursor.close()
    conn.close()
    
    if results:
        formatted_results = []
        for row in results:
            formatted_row = {}
            formatted_row['exercise_count'] = row[0]
            formatted_row['exercise_order'] = row[1]
            formatted_row['exercise_id'] = row[2]
            formatted_row['id'] = row[3]
            formatted_row['routineId'] = row[4]
            formatted_row['exercise_name'] = row[5]
            formatted_results.append(formatted_row)
        return Response(str(formatted_results), status=200, mimetype='application/json')
    else:
        return Response("No routine found for given memberId and routineName", status=404, mimetype='application/json')

#API 스펙 수정
@app.route("/<int:memberId>/start", methods=["POST"]) #클라이언트 정보를 select운동 어쩌구에 넘기는 함수
def start_exercise(memberId):
    data = request.json
    exerciseName = data['exerciseName']
    exerciseCount = data['exerciseCount']

    #미사용 부분   
    #conn = connect_to_db()
    #cursor = conn.cursor()
    #cursor.execute("""SELECT rd.exercise_name, rd.exercise_count 
    #               FROM routine r 
    #               JOIN routine_detail rd ON r.id = rd.routine_id 
    #              WHERE r.member_id = %s AND r.id = %s AND rd.id = %s;""", (memberId, routineId, routineDetailId))
    #results = cursor.fetchall() #여기에 운동정보, 횟수, 고객정보 들어있음
    #cursor.close()
    #conn.close()

    result = ready.selectExercise(exerciseName, memberId, exerciseCount)
    print(result)
    return str(result) #postnat

UPLOAD_FOLDER = 'uploads'
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

@app.route("/frame", methods=["POST"])
def frame():
    file = request.files['frame'].read()
    return camera.gen(file)

@app.route('/exercise/output', methods=['GET'])
def exercise_output():
    data = {
        'count': camera.cnt,
        'time': ready.cnt * 5,
        'name': ready.WorkOutName
    }
    return data

if __name__== "__main__":
    app.run(debug=True)




