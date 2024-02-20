import math
import imageDetect
#from speechRecognition import tts
import time

CNT = 0


def getDegree(key1, key2, key3):
    try:
        x = math.atan((key1[0] - key2[0]) / (key1[1] - key2[1])) - math.atan((key3[0] - key2[0]) / (key3[1] - key2[1]))
        return abs(x*180/math.pi)
    except:
        getDegree(key1, key2, key3)


def setting(exCode):
    global down_LIMIT1, down_LIMIT2, down_LIMIT3, cnt_flag
    global up_LIMIT1, up_LIMIT2,up_LIMIT3
    global ear_up,ear_down,knee_up , pelvis_down, knee_down, pelvis_up, ear_up, ear_down
    up_arr = imageDetect.main(exCode)
    down_arr = imageDetect.main(exCode+0.5)

    # 무릎 골반 평균 setting
    knee_up = (up_arr[13]+up_arr[14])/2
    knee_down = (down_arr[13]+down_arr[14])/2
    pelvis_up = (up_arr[11]+up_arr[12])/2
    pelvis_down = (down_arr[11]+down_arr[12])/2
    ear_up = (up_arr[3]+up_arr[4])/2
    ear_down = (down_arr[3]+down_arr[4])/2
    
    # 위
    # 귀-척추 상- 척추 중
    up_LIMIT1 = getDegree(ear_up, up_arr[17], up_arr[18])
    # 척추 상- 척추 중- 척추 하
    up_LIMIT2 = getDegree(up_arr[17], up_arr[18], up_arr[19])
    # 무릎-골반-척추 중
    up_LIMIT3  = getDegree(knee_up, pelvis_up, up_arr[18])
    
    # 아래
    # 귀-척추 상- 척추 중
    down_LIMIT1 = getDegree(ear_down, down_arr[17], down_arr[18])
    # 척추 상- 척추 중- 척추 하
    down_LIMIT2 = getDegree(down_arr[17], down_arr[18], down_arr[19])
    # 무릎-골반-척추 중
    down_LIMIT3  = getDegree(knee_down, pelvis_down, down_arr[18])

    cnt_flag = True


def zup_down1(keypoint):
    global message
    ear = (keypoint[3]+keypoint[4])/2
    
    # 귀-척추 상- 척추 중
    angle = getDegree(ear, keypoint[17], keypoint[18])
    value = 10

    if down_LIMIT1 - value <= angle <= down_LIMIT1 + value:
        return True
    elif angle < down_LIMIT1 - value:
        message = "고개를 조금만 뒤로 빼주세요"
        return False
    elif down_LIMIT1 +value < angle:
        message = "고개를 조금만 당겨주세요"
        return False


def zup_down2(keypoint):
    global message
    pelvis=(keypoint[11]+keypoint[12])/2
    value=10

    # 척추 상- 척추 중- 척추 하
    angle = getDegree(keypoint[17], keypoint[18], keypoint[19])

    if down_LIMIT2 - value <= angle <= down_LIMIT2 + value:
        return True
    elif angle < down_LIMIT2 - value:
        message = "등을 조금만 펴주세요"
        return False
    elif down_LIMIT2 +value < angle:
        message = "등을 조금만 말아주세요"
        return False
    
def zup_down3(keypoint):
    global message
    pelvis=(keypoint[11]+keypoint[12])/2
    knee=(keypoint[13]+keypoint[14])/2
    value= 20
    
    # 무릎-골반-척추 중
    angle = getDegree(knee, pelvis, keypoint[18])

    if down_LIMIT3 - value <= angle <= down_LIMIT3 + value:
        return True
    elif down_LIMIT3 -value > angle:
        message = "조금 더 일어나 주세요"
        return False
