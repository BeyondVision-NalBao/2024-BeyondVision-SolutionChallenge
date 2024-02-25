import math
import imageDetect
#from speechRecognition import tts
import time
global message

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
    global message
    knee= (keypoint[13]+keypoint[14])/2
    pelvis=(keypoint[11+keypoint[12]])/2
    
    # 무릎-골반-척추 중
    angle = getDegree(knee, pelvis, keypoint[18])
    value = 16

    if up_LIMIT1 - value <= angle <= up_LIMIT1 + value:
        return True
    elif angle < up_LIMIT1 - value:
        message = "엉덩이를 조금 더 들어올려 흉통과 골반 무릎이 일자에 놓여있도록 해주세요"
        return False
    elif up_LIMIT1 +value < angle:
        message = "엉덩이를 조금 내려 흉통과 골반 무릎이 일자에 놓여있도록 해주세요"
        return False


def bridge_up2(keypoint):
    pelvis=(keypoint[11+keypoint[12]])/2
    value=10
    global message

    # 골반 - 척추 중- 척추상
    angle = getDegree(pelvis, keypoint[18], keypoint[17])
    if up_LIMIT2 - value <= angle <= up_LIMIT2 + value:
        return True
    elif angle < up_LIMIT2 - value:
        message = "어깨를 펴서 흉통과 골반 무릎이 일자에 놓여있도록 해주세요"
        return False
    elif up_LIMIT2 +value < angle:
        message = "어깨를 조금 말아 흉통과 골반 무릎이 일자에 놓여있도록 해주세요"
        return False




