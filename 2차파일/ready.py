#from speechRecognition import tts
#from speechRecognition import stt


global countNumber
global exerciseCode
global messege

# 솔챌에서는 음성인식 과정을 거치지 않고 프론트에서 직접 값을 받아오기로 함. 
# 원래 코드는 ready_ver0.py 파일에 저장되어있습니다

#운동코드 받아오기
#횟수 설정하기
print('this is test messege')
def selectExercise(name,count='30'): #경원이가 디폴트 30으로 해놓으라고 했음 ㅎㅎ
    global exerciseCode
    if name=='스쿼트':
        exerciseCode = 1
    elif name=='숄더프레스':
        exerciseCode = 2
    elif name=='레터럴레이즈':
        exerciseCode = 3
    elif name=='헌드레드':
        exerciseCode = 4
    elif name=='플랭크':
        exerciseCode = 5
    elif name=='프론트레이즈':
        exerciseCode = 6
    elif name=='제트업':
        exerciseCode = 7
    elif name=='브릿지':
        exerciseCode = 8
    
    countNumber = int(count)
    return exerciseCode
        
    
def isReady(keypoint):
    # keypoint[15][0]: 왼쪽 발목 y좌표, keypoint[1][0]: 왼쪽 눈 y좌표
    height = keypoint[15][0] - keypoint[1][0]
    MAX_LIMIT = 320
    MIN_LIMIT = 250

    if MIN_LIMIT <= height <= MAX_LIMIT:
        messege="준비상태가 되었습니다."
        return True
    elif height > MAX_LIMIT:    
        messege="뒤로 가주세요"
        return False
    elif height < MIN_LIMIT:
        messege="앞으로 가주세요"
        return False


def isSide(keypoint):
    # keypoint[11][1]: 왼쪽 골반 x좌표, keypoint[12][1]: 오른쪽 골반 x좌표
    pelvis = abs(keypoint[11][1] - keypoint[12][1])
    limit = 20

    if pelvis <= limit:
        messege="측면입니다."
        return True
    else:
        messege="측면으로 서주세요."
        return False


def isFront(keypoint):
    # keypoint[11][1]: 왼쪽 골반 x좌표, keypoint[12][1]: 오른쪽 골반 x좌표
    pelvis = abs(keypoint[11][1] - keypoint[12][1])
    limit = 30

    if pelvis <= limit:
        messege="정면으로 서주세요."
        return False
    else:
        messege="정면입니다."
        return True
