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
        message = "제자리에 서있어주세요"
        return False

    if down_left_LIMIT1 - value <= left_angle_1 <= down_left_LIMIT1 + value:
        flag_l = True
    else:
        flag_l = False

    if down_right_LIMIT1 - value <= right_angle_1 <= down_right_LIMIT1 + value:
        flag_r = True
    else:
        flag_r = False

    if flag_l and flag_r:
        return True
    elif flag_l == True and flag_r == False:
        message = "오른쪽 팔을 직각으로 들어주세요."
        return False
    elif flag_l == False and flag_r == True:
        message = "왼쪽 팔을 직각으로 들어주세요."
        return False
    else:
        message = "양 쪽 팔을 좀 더 직각으로 들어주세요"
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
        message1 = "왼쪽 팔을 안쪽으로 더 접어주세요."
        flag_l = False
    elif left_angle_2 < down_right_LIMIT2:
        message1 = "왼쪽 팔을 바깥쪽으로 더 펴주세요."
        flag_l = False
    else:
        flag_l = False

    if down_right_LIMIT2 <= right_angle_2 <= down_left_LIMIT2:
        flag_r = True
    elif right_angle_2 > down_left_LIMIT2:
        message2 = "오른쪽 팔을 안쪽으로 더 접어주세요."
        flag_r = False
    elif right_angle_2 < down_right_LIMIT2:
        message2 = "오른쪽 팔을 바깥쪽으로 더 펴세요."
        flag_r = False
    else:
        flag_r = False

    if flag_l and flag_r:
        return True
    elif flag_l == True and flag_r == False:
        message = message2
        return False
    elif flag_l == False and flag_r == True:
        message = message1
        return False
    elif flag_l == False and flag_r == True: 
        message = message1 + message2   
        return False



