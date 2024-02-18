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


def leg_position(keypoint):
    right_leg = keypoint[6][1]-keypoint[16][1]
    left_leg = keypoint[5][1]-keypoint[15][1]
    value=10
    
    if right_leg<leg_right_up_LIMIT:
        if leg_right_up_LIMIT - value >= right_leg:
            right_leg_check = True
        elif leg_right_up_LIMIT - value < right_leg:
            
            message = "오른쪽 발을 조금만 안으로 모아주세요"
            right_leg_check = False
    elif right_leg >= leg_right_up_LIMIT:
        if leg_right_up_LIMIT + value <= right_leg:
            right_leg_check = True
        elif leg_right_up_LIMIT + value > right_leg:
            
            message = "오른쪽 발을 조금만 밖으로 빼주세요"
            right_leg_check = False
            
    if left_leg<leg_left_up_LIMIT:
        if leg_left_up_LIMIT - value <= left_leg:
            left_leg_check = True
        elif leg_left_up_LIMIT - value > left_leg:
            
            message = "왼쪽 발을 조금만 안으로 모아주세요"
            left_leg_check = False
    elif left_leg >= leg_left_up_LIMIT:
        if leg_left_up_LIMIT + value >= left_leg:
            left_leg_check = True
        elif leg_left_up_LIMIT + value < left_leg:
            
            message = "왼쪽 발을 조금만 밖으로 빼주세요"
            left_leg_check = False
            
    if left_leg_check and right_leg_check:
        return True
    else: return False
        
    
def raiseup(keypoint):
    # 손목- 어께
    left = keypoint[5][0]-keypoint[9][0]
    right = keypoint[6][0]-keypoint[10][0]
    value = 10
    
    # 오른쪽
    if right > up_right_LIMIT:
        if up_right_LIMIT + value >= right:
            right_arm_check = True
        elif up_right_LIMIT + value < right:
            
            message = "오른팔을 조금만 내려 어깨와 손목이 같은 높이가 되도록 해주세요"
            right_arm_check = False
    elif right < up_right_LIMIT:
        if up_right_LIMIT - value <= right:
            right_arm_check = True
        elif up_right_LIMIT - value > right:
            
            message = "오른팔을 조금만 더 올려서 팔 근육에 더 자극이 오도록 해주세요"
            right_arm_check = False
    
    # 왼쪽
    if left > up_left_LIMIT:
        if up_left_LIMIT + value >= left:
            left_arm_check = True
        elif up_left_LIMIT + value < left:
            
            message = "오른팔을 조금만 내려 어깨와 손목이 같은 높이가 되도록 해주세요"
            left_arm_check = False
    elif left < up_left_LIMIT:
        if up_left_LIMIT - value <= left:
            left_arm_check = True
        elif up_left_LIMIT - value > left:
            
            message = "오른팔을 조금만 더 올려서 팔 근육에 더 자극이 오도록 해주세요"
            left_arm_check = False
            
    if right_arm_check and left_arm_check:
        return True
    else:
        return False


def raisesDown(keypoint):
    # 손목- 골반
    left = abs(keypoint[5][0]-keypoint[11][0])
    right = abs(keypoint[6][0]-keypoint[12][0])
    value = 20
    
    # 오른쪽
    if right > down_right_LIMIT + value:
        
        message = "오른팔을 완전히 내려주세요"
        right_arm_check = False
    else: right_arm_check=True
    
    # 왼쪽
    if left > down_left_LIMIT + value:
        
        message = "왼팔을 완전히 내려주세요"
        left_arm_check = False
    
    if left_arm_check and right_arm_check:
        return True
    else: return False



def front_raise_count(keypoint): #이거 계산 또 해야하는거냐? 아오 귀찮아
    #팔을 들었으면 count로 check
    left = keypoint[5][0]-keypoint[9][0]
    right = keypoint[6][0]-keypoint[10][0]
    value = 10
    global cnt_flag

    l_flag = False
    r_flag = False

    if up_right_LIMIT - value <= right <= up_right_LIMIT + value:
        r_flag = True

    if up_left_LIMIT - value <= left <= up_left_LIMIT + value:
        l_flag = True

    if cnt_flag and l_flag and r_flag:
        cnt_flag = False
        return True
    elif not (l_flag and r_flag):
        cnt_flag = True
        return False


def counting(keypoint):
    if front_raise_count(keypoint):
        global CNT
        CNT += 1
        
        message = "성공한 횟수 " + str(CNT)
        return True
    else:
        return False
