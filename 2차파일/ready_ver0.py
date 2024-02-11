from speechRecognition import tts
from speechRecognition import stt

## 여기 대폭적으로 수정하기 #input값은 string
def selectExercise():
    tts.q.queue.clear()
    tts.q.put("어떤 운동을 진행하시겠습니까? 번호로 말해주세요. 일번: 스쿼트, 이번: 숄더프레스, 삼번: 레터럴레이즈")
    flag = True
    print("Start")
    while flag:
        flag = tts.tts_engine.isBusy()
    print("end")
    exercise = int(stt.sttFunction())

    if exercise == 1:
        tts.q.put("스쿼트를 몇 회 반복하겠습니까? 번호로 말해주세요. 일번 : 5회, 이번 : 10회, 삼번 : 15회")
    elif exercise == 2:
        tts.q.put("숄드프레스를 몇 회 반복하겠습니까? 번호로 말해주세요. 일번 : 5회, 이번 : 10회, 삼번 : 15회")
    elif exercise == 3:
        tts.q.put("레터럴레이즈를 몇 회 반복하겠습니까? 번호로 말해주세요. 일번 : 5회, 이번 : 10회, 삼번 : 15회")

    flag = True
    print("Start")
    while flag:
        flag = tts.tts_engine.isBusy()
    print("end")

    countNum = int(stt.sttFunction()) * 5
    print(countNum)
    global countNumber
    global exerciseCode
    exerciseCode = 0
    countNumber = countNum

    if exercise == 1:
        tts.q.queue.clear()
        tts.q.put("스쿼트 운동을 시작합니다.")
        exerciseCode = 1
    elif exercise == 2:
        tts.q.queue.clear()
        tts.q.put("숄더프레스 운동을 시작합니다.")
        exerciseCode = 2
    elif exercise == 3:
        tts.q.queue.clear()
        tts.q.put("레터럴 레이즈 운동을 시작합니다.")
        exerciseCode = 3


def isReady(keypoint):
    # keypoint[15][0]: 왼쪽 발목 y좌표, keypoint[1][0]: 왼쪽 눈 y좌표
    height = keypoint[15][0] - keypoint[1][0]
    MAX_LIMIT = 320
    MIN_LIMIT = 250

    if MIN_LIMIT <= height <= MAX_LIMIT:
        tts.q.queue.clear()
        tts.q.put("준비상태가 되었습니다.")
        return True
    elif height > MAX_LIMIT:
        tts.q.queue.clear()
        tts.q.put("뒤로 가주세요")
        return False
    elif height < MIN_LIMIT:
        tts.q.queue.clear()
        tts.q.put("앞으로 가주세요")
        return False


def isSide(keypoint):
    # keypoint[11][1]: 왼쪽 골반 x좌표, keypoint[12][1]: 오른쪽 골반 x좌표
    pelvis = abs(keypoint[11][1] - keypoint[12][1])
    limit = 20

    if pelvis <= limit:
        tts.q.queue.clear()
        tts.q.put("측면입니다.")
        return True
    else:
        tts.q.queue.clear()
        tts.q.put("측면으로 서주세요.")
        return False


def isFront(keypoint):
    # keypoint[11][1]: 왼쪽 골반 x좌표, keypoint[12][1]: 오른쪽 골반 x좌표
    pelvis = abs(keypoint[11][1] - keypoint[12][1])
    limit = 30

    if pelvis <= limit:
        tts.q.queue.clear()
        tts.q.put("정면으로 서주세요.")
        return False
    else:
        tts.q.queue.clear()
        tts.q.put("정면입니다.")
        return True
