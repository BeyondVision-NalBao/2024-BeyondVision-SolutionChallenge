import math
import imageDetect
from speechRecognition import tts

CNT = 0


def getDegree(key1, key2, key3):
    try:
        x = math.atan((key1[0] - key2[0]) / (key1[1] - key2[1])) - \
            math.atan((key3[0] - key2[0]) / (key3[1] - key2[1]))
        return abs(x*180/math.pi)
    except:
        getDegree(key1, key2, key3)


def setting(exCode): #손목 무릎 y좌표, 골반- 무릎- 발목
    global knee_LIMIT_l, knee_LIMIT_r, pelvis_LIMIT_r, pelvis_LIMIT_l, CNT
    arr = imageDetect.main(exCode)
    knee_LIMIT_r = ((arr[13][0]+arr[15][0])/2)-arr[9][0]
    knee_LIMIT_l = ((arr[14][0]+arr[16][0])/2)-arr[10][0]
    pelvis_LIMIT_r= getDegree(arr[12], arr[14], arr[16])
    pelvis_LIMIT_l= getDegree(arr[11], arr[13], arr[15])
    cnt_flag = True


def right_down(keypoint):
    knee_r =  ((keypoint[13][0]+keypoint[15][0])/2)-keypoint[9][0]

    if knee_r <= knee_LIMIT_r:
        return True
    # elif hip_knee > d_LIMIT + value:
    #     
    #     message = "조금 일어나세요.")
    #     return False
    elif knee_r > knee_LIMIT_r:
        
        message = "조금 더 숙여주세요"
        return False


def left_down(keypoint):
    knee_l =  ((keypoint[14][0]+keypoint[16][0])/2)-keypoint[10][0]

    if knee_l <= knee_LIMIT_l:
        return True
    # elif hip_knee > d_LIMIT + value:
    #     
    #     message = "조금 일어나세요.")
    #     return False
    elif knee_l > knee_LIMIT_l:
        
        message = "조금 더 숙여주세요"
        return False


def left_leg_straight(keypoint):
    pelvis_l= getDegree(keypoint[11], keypoint[13], keypoint[15])
    value=10

    if pelvis_LIMIT_l - value <= pelvis_l :
        return True
    elif pelvis_l <= pelvis_LIMIT_l - value:
        message = "무릎을 좀 더 펴주세요."
        return False
    
def right_leg_straight(keypoint):
    pelvis_r= getDegree(keypoint[12], keypoint[14], keypoint[16])
    value=10

    if pelvis_LIMIT_r - value <= pelvis_r :
        return True
    elif pelvis_r <= pelvis_LIMIT_r - value:
        message = "무릎을 좀 더 펴주세요."
        return False



def isDown(keypoint):
    if right_down(keypoint) and left_down(keypoint):
        # message = "스쿼트 자세를 잘 잡으셨어요!")
        return True
    else:
        return False
    
def isStraight(keypoint):
    if right_leg_straight(keypoint) and left_leg_straight(keypoint) :
        # message = "스쿼트 자세를 잘 잡으셨어요!")
        return True
    else:
        return False


def postureCorrection(keypoint):
    if isDown(keypoint) and isStraight(keypoint):
        # message = "스쿼트 자세를 잘 잡으셨어요!")
        return True
    else:
        return False
