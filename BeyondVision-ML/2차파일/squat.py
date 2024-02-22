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


def setting(exCode):
    global d_LIMIT, s_LIMIT, LIMIT, cnt_flag, CNT
    arr = imageDetect.main(exCode)
    d_LIMIT = ((arr[11][0]-arr[13][0]) + (arr[12][0]-arr[14][0])) / 2
    s_LIMIT = getDegree(arr[17], arr[18], arr[19])
    LIMIT = abs(getDegree(arr[12], arr[14], arr[16]) +
                getDegree(arr[11], arr[13], arr[15])) / 2
    cnt_flag = True


def squat_down(keypoint):
    global message
    # keypoint[11][0] : 왼쪽 골반 y좌표, keypoint[13][0] : 왼쪽 무릎 y좌표
    # keypoint[12][0] : 오른쪽 골반 y좌표, keypoint[14][0] : 오른쪽 무릎 y좌표
    hip_knee_l = keypoint[11][0] - keypoint[13][0]
    hip_knee_r = keypoint[12][0] - keypoint[14][0]
    hip_knee = (hip_knee_l+hip_knee_r) / 2
    value = 15

    if hip_knee < -65:
        return False

    if d_LIMIT - value <= hip_knee <= d_LIMIT + value:
        return True
    elif hip_knee > d_LIMIT + value:
        message = "조금 일어나세요."
        return False
    elif hip_knee < d_LIMIT - value:
        message = "조금 더 앉으세요"
        return False


def squat_straight(keypoint):
    global message
    # keypoint[17] : 척수상, keypoint[18] : 척수중, keypoint[19] : 척추하
    value = 5
    angle = getDegree(keypoint[17], keypoint[18], keypoint[19])

    if s_LIMIT-value <= angle <= s_LIMIT+value:
        return True
    elif angle < s_LIMIT-value:
        message = "허리를 조금 더 세워주세요."
        return False
    elif angle > s_LIMIT+value:
        message = "허리를 조금 더 구부려주세요."
        return False


def squat_knee_angle(keypoint):
    global message
    # keypoint[12] : 오른쪽골반, keypoint[14] : 오른쪽무릎, keypoint[16] : 오른쪽발목
    # keypoint[11] : 왼쪽골반, keypoint[13] : 왼쪽무릎, keypoint[15] : 왼쪽발목
    right_angle = getDegree(keypoint[12], keypoint[14], keypoint[16])
    left_angle = getDegree(keypoint[11], keypoint[13], keypoint[15])
    angle = abs((right_angle + left_angle) / 2)

    if angle >= LIMIT:
         return True
    else:
         message = "무릎이 발보다 앞으로 더 나와있습니다."
         return False
