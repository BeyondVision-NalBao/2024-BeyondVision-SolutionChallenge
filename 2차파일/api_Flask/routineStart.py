from flask import Flask, request, Response
from db import connect_to_db
from pymysql import connect

app = Flask(__name__)

@app.route("/<int:memberId>/start", methods=["POST"])
def start(memberId):
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

if __name__ == '__main__':
    app.run()

#@app.route("/<long:memberId>/<long:routineDetailId>/frame", method=['POST'])
#def frame(memberId, routineDetailId):
#  output.save(camera.gen(images))
    
