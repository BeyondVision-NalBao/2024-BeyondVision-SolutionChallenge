import math
import imageDetect
#from speechRecognition import tts

CNT = 0

global message

def getDegree(key1, key2, key3):
    try:
        x = math.atan((key1[0] - key2[0]) / (key1[1] - key2[1])) - \
            math.atan((key3[0] - key2[0]) / (key3[1] - key2[1]))
        return abs(x*180/math.pi)
    except:
        getDegree(key1, key2, key3)


def setting(exCode):
    global up_left_LIMIT, up_right_LIMIT, cnt_flag
    global up_left_slope_LIMIT, up_right_slope_LIMIT, down_left_slope_LIMIT, down_right_slope_LIMIT
    up_arr = imageDetect.main(exCode)
    down_arr = imageDetect.main(exCode+0.5)

    # 어께 - 팔꿈치 - 손목
    up_left_LIMIT = getDegree(up_arr[5], up_arr[7], up_arr[9])
    up_right_LIMIT = getDegree(up_arr[6], up_arr[8], up_arr[10])

    # 손목 - 어깨 기울기
    up_left_slope_LIMIT = abs(
        (up_arr[5][0]-up_arr[9][0]) / (up_arr[5][1]-up_arr[9][1]))
    up_right_slope_LIMIT = abs(
        (up_arr[6][0]-up_arr[10][0]) / (up_arr[6][1]-up_arr[10][1]))

    down_left_slope_LIMIT = abs(
        (down_arr[9][0]-down_arr[5][0]) / (down_arr[9][1]-down_arr[5][1]))
    down_right_slope_LIMIT = abs(
        (down_arr[10][0]-down_arr[6][0]) / (down_arr[10][1]-down_arr[6][1]))

    cnt_flag = True


def raiseDown(keypoint):
    # keypoint[5] : 왼쪽 어깨, keypoint[7] : 왼쪽 팔꿈치, keypoint[9] : 왼쪽 손목
    # keypoint[6] : 오른쪽 어깨, keypoint[8] : 오른쪽 팔꿈치, keypoint[10] : 오른쪽 손목
    left_slope = abs((keypoint[5][0]-keypoint[9][0]) /
                     (keypoint[5][1]-keypoint[9][1]))
    right_slope = abs((keypoint[6][0]-keypoint[10]
                      [0]) / (keypoint[6][1]-keypoint[10][1]))

    value = 10
    # 가만히 서있는지 확인.
    if keypoint[9][0] > keypoint[18][0]:
        return False

    if(1 <= left_slope <= 20):
        flag_l = True
    else:
        
        message = "왼쪽 팔을 내려주세요."
        flag_l = False

    if(1 <= right_slope <= 20):
        flag_r = True
    else:
        
        message = "오른쪽 팔을 내려주세요."
        flag_r = False

    if flag_l and flag_r:
        return True
    else:
        return False


def raiseUp(keypoint):
    # keypoint[5] : 왼쪽 어깨, keypoint[7] : 왼쪽 팔꿈치, keypoint[9] : 왼쪽 손목
    # keypoint[6] : 오른쪽 어깨, keypoint[8] : 오른쪽 팔꿈치, keypoint[10] : 오른쪽 손목
    left_slope = abs((keypoint[9][0]-keypoint[5][0]) /
                     (keypoint[9][1]-keypoint[5][1]))
    right_slope = abs((keypoint[10][0]-keypoint[6]
                      [0]) / (keypoint[10][1]-keypoint[6][1]))

    value = 30

    # 가만히 서있는지 확인.
    if keypoint[9][0] > keypoint[18][0]:
        return False

    if(0 <= left_slope <= 0.5):
        flag_l = True
    else:
        
        message = "왼쪽 팔을 수직으로 올려주세요."
        flag_l = False

    if(0 <= right_slope <= 0.5):
        flag_r = True
    else:
        
        message = "오른쪽 팔을 수직으로 올려주세요."
        flag_r = False

    if flag_l and flag_r:
        return True
    else:
        return False


def postureCorrection(keypoint):
    if(raiseUp(keypoint)):
        
        message = "레터럴 레이즈 자세를 잘 잡으셨어요!"
        return True
    else:
        return False


def lateralRaise_count(keypoint):
    left_slope = abs((keypoint[9][0]-keypoint[5][0]) /
                     (keypoint[9][1]-keypoint[5][1]))
    right_slope = abs((keypoint[10][0]-keypoint[6]
                      [0]) / (keypoint[10][1]-keypoint[6][1]))

    global cnt_flag

    if(0 <= left_slope <= 0.5):
        flag_l = True
    else:
        flag_l = False

    if(0 <= right_slope <= 0.5):
        flag_r = True
    else:
        flag_r = False

    if cnt_flag and flag_l and flag_r:
        cnt_flag = False
        return True
    elif not (flag_l and flag_r):
        cnt_flag = True
        return False


def counting(keypoint):
    if lateralRaise_count(keypoint):
        global CNT
        CNT += 1
        
        message = "성공한 횟수 " + str(CNT)
        return True
    else:
        return False
