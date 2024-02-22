# global countNumber, exerciseCode, message

# 솔챌에서는 음성인식 과정을 거치지 않고 프론트에서 직접 값을 받아오기로 함. 
# 원래 코드는 ready_ver0.py 파일에 저장되어있습니다 -> 이거 삭제함
#flask에서 넘겨준 값을 여기서 저장하고 있어야 함. 해당 값을 가지고 camera에서 돌아가게 해야함.

#운동코드 받아오기
#횟수 설정하기

import imageDetect

import squat
import lateralRaise
import shoulderPress
import hundred
import plank
import zup
import bridge
import front_raise
import stretching10
import stretching4
import stretching5

print('this is test message ')
def selectExercise(name, memberId, count='30'): #경원이가 디폴트 30으로 해놓으라고 했음 ㅎㅎ
    global exerciseCode, countNumber, member_id, WorkOutName, cnt, cnt_1
    cnt = 0
    cnt_1 =0
    if name=='스쿼트':
        exerciseCode = 1
        squat.setting(1)
    elif name=='숄더프레스':
        exerciseCode = 2
        shoulderPress.setting(2)
    elif name=='레터럴레이즈':
        exerciseCode = 3
        lateralRaise.setting(3)
    elif name=='헌드레드':
        exerciseCode = 4
        hundred.setting(4)
    elif name=='플랭크':
        exerciseCode = 5
        plank.setting(5)
    elif name=='프론트레이즈':
        exerciseCode = 6
        front_raise.setting(6)
    elif name=='제트업':
        exerciseCode = 7
        zup.setting(7)
    elif name=='브릿지':
        exerciseCode = 8
        bridge.setting(8)
    elif name=='스트레칭1':
        exerciseCode = 9
        bridge.setting(9)
    elif name=='스트레칭2':
        exerciseCode = 10
        bridge.setting(10)
    elif name=='스트레칭3':
        exerciseCode = 11
        bridge.setting(11)
    
    countNumber = int(count)
    member_id=memberId
    WorkOutName=name
    return str(exerciseCode)
        
    
def isReady(keypoint):
    global message
    # keypoint[15][0]: 왼쪽 발목 y좌표, keypoint[1][0]: 왼쪽 눈 y좌표
    height = keypoint[15][0] - keypoint[1][0]
    MAX_LIMIT = 320
    MIN_LIMIT = 250

    if MIN_LIMIT <= height <= MAX_LIMIT:
        message ="준비상태가 되었습니다."
        return True
    elif height > MAX_LIMIT:    
        message ="뒤로 가주세요"
        return False
    elif height < MIN_LIMIT:
        message ="앞으로 가주세요"
        return False


def isSide(keypoint):
    global message
    # keypoint[11][1]: 왼쪽 골반 x좌표, keypoint[12][1]: 오른쪽 골반 x좌표
    pelvis = abs(keypoint[11][1] - keypoint[12][1])
    limit = 20

    if pelvis <= limit:
        message ="측면입니다."
        return True
    else:
        message ="측면으로 서주세요."
        return False


def isFront(keypoint):
    global message
    # keypoint[11][1]: 왼쪽 골반 x좌표, keypoint[12][1]: 오른쪽 골반 x좌표
    pelvis = abs(keypoint[11][1] - keypoint[12][1])
    limit = 30

    if pelvis <= limit:
        message ="정면으로 서주세요."
        return False
    else:
        message ="정면입니다."
        return True
