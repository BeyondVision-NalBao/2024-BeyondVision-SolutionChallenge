import math
import imageDetect   

CNT = 0


def getDegree(key1, key2, key3):
    try:
        x = math.atan((key1[0] - key2[0]) / (key1[1] - key2[1])) - \
            math.atan((key3[0] - key2[0]) / (key3[1] - key2[1]))
        return abs(x*180/math.pi)
    except:
        getDegree(key1, key2, key3)


def setting(exCode): # 양쪽 팔 - 팔꿈치- 어깨
    global r_LIMIT, l_LIMIT, cnt_flag, CNT
    arr = imageDetect.main(exCode)
    r_LIMIT = getDegree(arr[5], arr[7], arr[9])
    l_LIMIT = getDegree(arr[6], arr[8], arr[10])
    cnt_flag = True


def leftArm_position(keypoint):
    leftarm=getDegree(keypoint[5],keypoint[7],keypoint[9])
    value = 15

    if l_LIMIT - value <= leftarm <= l_LIMIT + value:
        return True
    # elif hip_knee > d_LIMIT + value:
    #     
    #     message = "조금 일어나세요.")
    #     return False
    elif leftarm < l_LIMIT - value:
        
        message = "왼팔을 좀 더 펴주세요"
        return False

def rightArm_position(keypoint):
    rightarm=getDegree(keypoint[5],keypoint[7],keypoint[9])
    value = 15

    if r_LIMIT - value <= rightarm <= r_LIMIT + value:
        return True
    elif rightarm < r_LIMIT - value:
        
        message = "오른팔을 좀 더 펴주세요"
        return False



def postureCorrection(keypoint):
    if rightArm_position(keypoint) and leftArm_position(keypoint):
        return True
    else:
        return False


