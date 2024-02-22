import math
import imageDetect
#from speechRecognition import tts

global message

CNT = 0


def getDegree(key1, key2, key3):
    try:
        x = math.atan((key1[0] - key2[0]) / (key1[1] - key2[1])) - \
            math.atan((key3[0] - key2[0]) / (key3[1] - key2[1]))
        return abs(x*180/math.pi)
    except:
        getDegree(key1, key2, key3)


def setting(exCode):
    global right_first_LIMIT, right_second_LIMIT,right_third_LIMIT, left_first_LIMIT, left_second_LIMIT,left_third_LIMIT,cnt_flag, CNT
    arr = imageDetect.main(exCode)
    #arr[4]가 오른쪽 귀라고 가정, arr[3]가 왼쪽 귀라고 가정
    right_first_LIMIT = getDegree(arr[4],arr[6],arr[12]) #오른쪽 귀-어깨-골반
    right_second_LIMIT = getDegree(arr[6],arr[12],arr[14])#오른쪽 어께-골반-무릎
    right_third_LIMIT = getDegree(arr[12],arr[14],arr[16])#오른쪽 골반-무릎-발목
    left_first_LIMIT = getDegree(arr[3],arr[5],arr[11])#왼쪽 귀-어깨-골반
    left_second_LIMIT = getDegree(arr[5],arr[11],arr[13])#왼쪽 어께-골반-무릎
    left_third_LIMIT = getDegree(arr[11],arr[13],arr[15])#오른쪽 골반-무릎-발목
    cnt_flag = True


def plank_first(keypoint):
    global message
    right_angle = getDegree(keypoint[4],keypoint[6],keypoint[12])
    left_angle = getDegree(keypoint[3],keypoint[5],keypoint[11])
    value = 10

    if right_first_LIMIT - value <= right_angle <= right_first_LIMIT + value:
        return True
    elif right_angle > right_first_LIMIT + value:
       
        message = "고개를 들고 엉덩이를 낮춰서 고개부터 골반까지 일자가 되게 하세요"
        return False
    elif right_angle < right_first_LIMIT - value:
       
        message = "고개를 낮추고 엉덩이를 올려서 고개부터 골반까지 일자가 되게 하세요"
        return False
    
    if left_first_LIMIT - value <= left_angle <= left_first_LIMIT + value:
        return True
    elif left_angle > left_first_LIMIT + value:
       
        message = "고개를 들고 엉덩이를 낮춰서 고개부터 골반까지 일자가 되게 하세요"
        return False
    elif left_angle < left_first_LIMIT - value:
       
        message = "고개를 낮추고 엉덩이를 올려서 고개부터 골반까지 일자가 되게 하세요"
        return False


def plank_second(keypoint):
    global message
    right_angle = getDegree(keypoint[6],keypoint[12],keypoint[14])
    left_angle = getDegree(keypoint[5],keypoint[11],keypoint[13])
    value = 10

    if right_second_LIMIT - value <= right_angle <= right_second_LIMIT + value:
        return True
    elif right_angle > right_second_LIMIT + value:
       
        message = "엉덩이가 너무 위로 올라와있습니다. 척추와 골반이 일자가 되도록 하면서 복부에 힘이 들어가도록 해주세요  "
        return False
    elif right_angle < right_second_LIMIT - value:
       
        message = "엉덩이가 너무 밑으로 내려와있습니다. 척추와 골반이 일자가 되도록 하면서 복부에 힘이 들어가도록 해주세요"
        return False
    
    if left_second_LIMIT - value <= left_angle <= left_second_LIMIT + value:
        return True
    elif left_angle > left_second_LIMIT + value:
       
        message = "엉덩이가 너무 위로 올라와있습니다. 척추와 골반이 일자가 되도록 하면서 복부에 힘이 들어가도록 해주세요  "
        return False
    elif left_angle < left_second_LIMIT - value:
       
        message = "엉덩이가 너무 밑으로 내려와있습니다. 척추와 골반이 일자가 되도록 하면서 복부에 힘이 들어가도록 해주세요"
        return False


def plank_third(keypoint):
    global message
    # keypoint[12] : 오른쪽골반, keypoint[14] : 오른쪽무릎, keypoint[16] : 오른쪽발목
    # keypoint[11] : 왼쪽골반, keypoint[13] : 왼쪽무릎, keypoint[15] : 왼쪽발목
    right_angle = getDegree(keypoint[12], keypoint[14], keypoint[16])
    left_angle = getDegree(keypoint[11], keypoint[13], keypoint[15])
    
    if right_angle <= right_third_LIMIT:
        return True
    elif right_angle > right_third_LIMIT:
       
        message = "무릎이 굽혀져 있습니다. 무릎을 펴주세요"
        return False
    
    if left_angle <= left_third_LIMIT:
        return True
    elif left_angle > left_third_LIMIT:
       
        message = "무릎이 굽혀져 있습니다. 무릎을 펴주세요"
        return False

