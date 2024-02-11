import math
import imageDetect
from speechRecognition import tts
import time

CNT = 0


def getDegree(key1, key2, key3):
    try:
        x = math.atan((key1[0] - key2[0]) / (key1[1] - key2[1])) - math.atan((key3[0] - key2[0]) / (key3[1] - key2[1]))
        return abs(x*180/math.pi)
    except:
        getDegree(key1, key2, key3)


def setting(exCode):
    global down_LIMIT, cnt_flag
    global up_LIMIT1, up_LIMIT2
    global knee_up , pelvis_down, knee_down, pelvis_up
    up_arr = imageDetect.main(exCode)
    down_arr = imageDetect.main(exCode+0.5)

    # 무릎 골반 평균 setting
    knee_up = (up_arr[13]+up_arr[14])/2
    knee_down = (down_arr[13]+down_arr[14])/2
    pelvis_up = (up_arr[11]+up_arr[12])/2
    pelvis_down = (down_arr[11]+down_arr[12])/2
    
    # 무릎-골반-척추 중
    up_LIMIT1 = getDegree(knee_up, pelvis_up, up_arr[18])
    # 골반-척추 중 -척추 상
    up_LIMIT2 = getDegree(pelvis_up, up_arr[18], up_arr[17])
    # 무릎-골반-척추 중
    down_LIMIT = getDegree(knee_down, pelvis_down, down_arr[18])

    cnt_flag = True


def bridge_up1(keypoint):
    knee= (keypoint[13]+keypoint[14])/2
    pelvis=(keypoint[11+keypoint[12]])/2
    
    # 무릎-골반-척추 중
    angle = getDegree(knee, pelvis, keypoint[18])
    value = 16

    if up_LIMIT1 - value <= angle <= up_LIMIT1 + value:
        return True
    elif angle < up_LIMIT1 - value:
        tts.q.queue.clear()
        tts.q.put("엉덩이를 조금 더 들어올려 흉통과 골반 무릎이 일자에 놓여있도록 해주세요")
        return False
    elif up_LIMIT1 +value < angle:
        tts.q.queue.clear()
        tts.q.put("엉덩이를 조금 내려 흉통과 골반 무릎이 일자에 놓여있도록 해주세요")
        return False


def bridge_up2(keypoint):
    pelvis=(keypoint[11+keypoint[12]])/2
    value=10

    # 골반 - 척추 중- 척추상
    angle = getDegree(pelvis, keypoint[18], keypoint[17])

    if up_LIMIT2 - value <= angle <= up_LIMIT2 + value:
        return True
    elif angle < up_LIMIT2 - value:
        tts.q.queue.clear()
        tts.q.put("어깨를 펴서 흉통과 골반 무릎이 일자에 놓여있도록 해주세요")
        return False
    elif up_LIMIT2 +value < angle:
        tts.q.queue.clear()
        tts.q.put("어깨를 조금 말아 흉통과 골반 무릎이 일자에 놓여있도록 해주세요")
        return False


def bridge_down(keypoint):
    knee= (keypoint[13]+keypoint[14])/2
    pelvis=(keypoint[11+keypoint[12]])/2
    
    # 무릎-골반-척추 중
    angle = getDegree(knee, pelvis, keypoint[18])
    value = 20

    if angle <= down_LIMIT + value:
        return True
    elif down_LIMIT +value < angle:
        tts.q.queue.clear()
        tts.q.put("엉덩이를 완전히 바닥에 붙혀주세요")
        return False


def isUp(keypoint):
    if bridge_up1(keypoint) and bridge_up2(keypoint):
        return True
    else:
        return False



def bridge_count(keypoint):
    global cnt_flag
    knee= (keypoint[13]+keypoint[14])/2
    pelvis=(keypoint[11+keypoint[12]])/2
    
    # 무릎-골반-척추 중
    angle = getDegree(knee, pelvis, keypoint[18])
    value = 16

    if up_LIMIT1 - value <= angle <= up_LIMIT1 + value:
        checkpoint1=True
    elif angle < up_LIMIT1 - value:
        checkpoint1= False
    elif up_LIMIT1 +value < angle:
        checkpoint1= False
    
    value1=10

    # 골반 - 척추 중- 척추상
    angle1 = getDegree(pelvis, keypoint[18], keypoint[17])

    if up_LIMIT2 - value1 <= angle1 <= up_LIMIT2 + value1:
        checkpoint2= True
    elif angle1 < up_LIMIT2 - value1:
        checkpoint2= False
    elif up_LIMIT2 +value1 < angle1:
        checkpoint2= False
    
    
    if cnt_flag and checkpoint1 and checkpoint2:
        cnt_flag = False
        return True
    elif not (checkpoint1 and checkpoint2):
        cnt_flag = True
        return False


def counting(keypoint):
    if bridge_count(keypoint):
        global CNT
        CNT += 1
        tts.q.queue.clear()
        tts.q.put("성공한 횟수 " + str(CNT))
        return True
    else:
        return False
