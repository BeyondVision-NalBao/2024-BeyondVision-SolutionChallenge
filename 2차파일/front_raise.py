import math
import imageDetect
#from speechRecognition import tts
global message
CNT = 0


def getDegree(key1, key2, key3):
    try:
        x = math.atan((key1[0] - key2[0]) / (key1[1] - key2[1])) - math.atan((key3[0] - key2[0]) / (key3[1] - key2[1]))
        return abs(x*180/math.pi)
    except:
        getDegree(key1, key2, key3)


def setting(exCode):
    global up_left_LIMIT,up_right_LIMIT,down_left_LIMIT,down_right_LIMIT,cnt_flag
    global leg_left_up_LIMIT,leg_left_down_LIMIT,leg_right_up_LIMIT,leg_right_down_LIMIT
    up_arr = imageDetect.main(exCode)
    down_arr = imageDetect.main(exCode+0.5)

    # 해당운동은 앵글보다는 y또는 x좌표에 더 신경을 써야 할것 같다
    # 손목-어깨 (y좌표)
    up_left_LIMIT = up_arr[5][0]-up_arr[9][0]
    up_right_LIMIT = up_arr[6][0]-up_arr[10][0]
    
    # 손목-골반 (y좌표)
    down_left_LIMIT = abs(down_arr[5][0]-down_arr[11][0])
    down_right_LIMIT = abs(down_arr[6][0]-down_arr[12][0])
    
    # 다리를 어께 넓이만큼 벌렸는지 (x좌표)
    leg_left_up_LIMIT = up_arr[5][1]-up_arr[15][1]
    leg_right_up_LIMIT = up_arr[6][1]-up_arr[16][1]
    
    #한번만 해도 될것 같아서 걍 이건 패스함
    #leg_left_down_LIMIT = down_arr[5][1]-down_arr[15][1]
    #leg_right_down_LIMIT = down_arr[6][1]-down_arr[16][1]

    cnt_flag = True
        
    
def raiseup(keypoint):
    global message
    # 손목- 어께
    left = keypoint[5][0]-keypoint[9][0]
    right = keypoint[6][0]-keypoint[10][0]
    value = 10
    
    # 오른쪽
    if right > up_right_LIMIT:
        if up_right_LIMIT + value >= right:
            right_arm_check = True
        elif up_right_LIMIT + value < right:
            message1 = "오른팔을 조금만 내려 어깨와 손목이 같은 높이가 되도록 해주세요"
            right_arm_check = False
    elif right < up_right_LIMIT:
        if up_right_LIMIT - value <= right:
            right_arm_check = True
        elif up_right_LIMIT - value > right:
            message1 = "오른팔을 조금만 더 올려서 팔 근육에 더 자극이 오도록 해주세요"
            right_arm_check = False
    
    # 왼쪽
    if left > up_left_LIMIT:
        if up_left_LIMIT + value >= left:
            left_arm_check = True
        elif up_left_LIMIT + value < left:
            message2 = "오른팔을 조금만 내려 어깨와 손목이 같은 높이가 되도록 해주세요"
            left_arm_check = False
    elif left < up_left_LIMIT:
        if up_left_LIMIT - value <= left:
            left_arm_check = True
        elif up_left_LIMIT - value > left:
            message2 = "오른팔을 조금만 더 올려서 팔 근육에 더 자극이 오도록 해주세요"
            left_arm_check = False
            
    if right_arm_check and left_arm_check:
        return True
    elif right_arm_check == True and left_arm_check == False:
        message = message2
        return False
    elif right_arm_check == False and left_arm_check == True:
        message = message1
        return False
    elif right_arm_check == False and left_arm_check == False:
        message = message1 + message2
        return False
