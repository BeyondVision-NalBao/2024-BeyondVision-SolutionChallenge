import math
import imageDetect
#from speechRecognition import tts

CNT = 0


def getDegree(key1, key2, key3):
    try:
        x = math.atan((key1[0] - key2[0]) / (key1[1] - key2[1])) - math.atan((key3[0] - key2[0]) / (key3[1] - key2[1]))
        return abs(x*180/math.pi)
    except:
        getDegree(key1, key2, key3)


def setting(exCode):
    global up_left_LIMIT, up_right_LIMIT, cnt_flag
    global down_left_LIMIT1, down_right_LIMIT1, down_left_LIMIT2, down_right_LIMIT2
    up_arr = imageDetect.main(exCode)
    down_arr = imageDetect.main(exCode+0.5)

    # 어께 - 팔꿈치 - 손목
    up_left_LIMIT = getDegree(up_arr[5], up_arr[7], up_arr[9])
    up_right_LIMIT = getDegree(up_arr[6], up_arr[8], up_arr[10])
    # ㄱ : 팔꿈치 - 척추상 - 척추중
    down_left_LIMIT1 = getDegree(down_arr[7], down_arr[17], down_arr[18])
    down_right_LIMIT1 = getDegree(down_arr[8], down_arr[17], down_arr[18])
    # ㄴ : 손목 - 팔꿈치 - 척추상
    down_left_LIMIT2 = getDegree(down_arr[9], down_arr[7], down_arr[17])
    down_right_LIMIT2 = getDegree(down_arr[10], down_arr[8], down_arr[17])

    cnt_flag = True


def pressDown1(keypoint):
    global message
    # keypoint[7] : 왼쪽팔꿈치, keypoint[17] : 척추상, keypoint[18] : 척추중
    # keypoint[8] : 오른쪽팔꿈치, keypoint[17] : 척추상, keypoint[18] : 척추중

    # ㄱ : 팔꿈치 - 척추상 - 척추중
    left_angle_1 = getDegree(keypoint[7], keypoint[17], keypoint[18])
    right_angle_1 = getDegree(keypoint[8], keypoint[17], keypoint[18])
    value = 16

    # 가만히 서있는지 확인.
    if keypoint[9][0] > keypoint[18][0]:
        return False

    if down_left_LIMIT1 - value <= left_angle_1 <= down_left_LIMIT1 + value:
        flag_l = True
    else:
        
        message = "왼쪽 팔을 직각으로 들어주세요."
        flag_l = False

    if down_right_LIMIT1 - value <= right_angle_1 <= down_right_LIMIT1 + value:
        flag_r = True
    else:
        
        message = "오른쪽 팔을 직각으로 들어주세요."
        flag_r = False

    if flag_l and flag_r:
        return True
    else:
        return False


def pressDown2(keypoint):
    global message
    # keypoint[9] : 왼쪽손목, keypoint[7] : 왼쪽팔꿈치, keypoint[17] : 척추상
    # keypoint[10]  : 오른쪽손목, keypoint[8] : 오른쪽팔꿈치, keypoint[17] : 척추상

    # ㄴ : 손목 - 팔꿈치 - 척추상
    left_angle_2 = getDegree(keypoint[9], keypoint[7], keypoint[17])
    right_angle_2 = getDegree(keypoint[10], keypoint[8], keypoint[17])

    if down_right_LIMIT2 <= left_angle_2 <= down_left_LIMIT2:
        flag_l = True
    elif left_angle_2 > down_left_LIMIT2:
        
        message = "왼쪽 팔을 안쪽으로 더 접어주세요."
        flag_l = False
    elif left_angle_2 < down_right_LIMIT2:
        
        message = "왼쪽 팔을 바깥쪽으로 더 펴주세요."
        flag_l = False
    else:
        flag_l = False

    if down_right_LIMIT2 <= right_angle_2 <= down_left_LIMIT2:
        flag_r = True
    elif right_angle_2 > down_left_LIMIT2:
        
        message = "오른쪽 팔을 안쪽으로 더 접어주세요."
        flag_r = False
    elif right_angle_2 < down_right_LIMIT2:
        
        message = "오른쪽 팔을 바깥쪽으로 더 펴세요."
        flag_r = False
    else:
        flag_r = False

    if flag_l and flag_r:
        return True
    else:
        return False


def pressUp(keypoint):
    global message
    # keypoint[5] : 왼쪽어깨, keypoint[7] : 왼쪽팔꿈치, keypoint[9] : 왼쪽손목
    # keypoint[6] : 오른쪽어깨, keypoint[8] : 오른쪽팔꿈치, keypoint[10] : 오른쪽손목

    # 어께 - 팔꿈치 - 손목
    left_angle = getDegree(keypoint[5], keypoint[7], keypoint[9])
    right_angle = getDegree(keypoint[6], keypoint[8], keypoint[10])
    value = 25

    l_flag = False
    r_flag = False

    if up_left_LIMIT - value < left_angle:
        l_flag = True
    else:
        
        message = "왼쪽 팔꿈치를 좀 더 올려주세요!"

    if up_right_LIMIT - value < right_angle:
        r_flag = True
    else:
        
        message = "오른쪽 팔꿈치를 좀 더 올려주세요!"

    if l_flag and r_flag:
        return True


def isDown(keypoint):
    if pressDown1(keypoint) and pressDown2(keypoint):
        return True
    else:
        return False


def postureCorrection(keypoint):
    global message
    if pressUp(keypoint):
        
        message = "숄드 프레스 자세를 잘 잡으셨어요!"
        return True
    else:
        return False


def shoulderPress_count(keypoint):
    # 어께 - 팔꿈치 - 손목
    left_angle = getDegree(keypoint[5], keypoint[7], keypoint[9])
    right_angle = getDegree(keypoint[6], keypoint[8], keypoint[10])
    value = 40
    global cnt_flag

    l_flag = False
    r_flag = False

    if up_left_LIMIT - value < left_angle:
        l_flag = True

    if up_right_LIMIT - value < right_angle:
        r_flag = True

    if cnt_flag and l_flag and r_flag:
        cnt_flag = False
        return True
    elif not (l_flag and r_flag):
        cnt_flag = True
        return False


def counting(keypoint):
    
    if shoulderPress_count(keypoint):
        global CNT
        CNT += 1
        
        message = "성공한 횟수 " + str(CNT)
        return True
    else:
        return False
