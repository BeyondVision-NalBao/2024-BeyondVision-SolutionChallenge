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


def setting(exCode):
    global ear,pelvis,knee,wrist,first_LIMIT, second_LIMIT,cnt_flag, CNT
    arr = imageDetect.main(exCode)
    #arr[4]가 오른쪽 귀라고 가정, arr[3]가 왼쪽 귀라고 가정
    pelvis=(arr[11]+arr[12])/2
    knee=(arr[13],arr[14])/2
    wrist=(arr[9],arr[10])/2
    ear=(arr[3],arr[4])/2
    first_LIMIT = getDegree(arr[18],pelvis,knee) #척추중 - 골반 - 무릎
    second_LIMIT = getDegree(ear,arr[17],arr[18])#귀- 척수상 - 척수중
    cnt_flag = True


def hunbred_first(keypoint):
    first_pelvis=(keypoint[11],keypoint[12])/2
    first_knee=(keypoint[13],keypoint[14]/2)
    first_angle = getDegree(keypoint[18],first_pelvis,first_knee)
    value = 30

    if first_LIMIT - value <= first_angle:
        return True
    elif first_LIMIT - value > first_angle:
        tts.q.queue.clear()
        tts.q.put("다리를 조금만 더 내려서 복부에 힘이 들어가도록 해주세요")
        return False


def hunbred_second(keypoint):
    second_ear=(keypoint[3],keypoint[4])
    second_angle = getDegree(second_ear,keypoint[17],keypoint[18])
    value = 15

    if second_LIMIT - value <= second_angle <= second_LIMIT + value:
        return True
    elif second_angle > second_LIMIT + value:
        tts.q.queue.clear()
        tts.q.put("고개를 너무 많이 드셔서 복부에 힘이 가지 않고 있습니다. 고개를 조금 더 낮추고 복부에 힘이 들어가는것에 집중해보세요 ")
        return False
    elif second_angle < second_LIMIT - value:
        tts.q.queue.clear()
        tts.q.put("고개를 조금 더 들어서 얼굴 정면이 무릎을 향하게 해주세요")
        return False
    


def hunbred_third(keypoint):
    value=5
    if pelvis[0]-value <= wrist[0] <= pelvis[0]+value:
        return True
    elif pelvis[0]-value > wrist[0]:
        tts.q.queue.clear()
        tts.q.put("팔을 살짝만 위로 들어주세요")
        return False
    elif pelvis[0] + value < wrist[0]:
        tts.q.queue.clear()
        tts.q.put("팔을 살짝만 아래로 내려주세요")
        return False


def postureCorrection(keypoint):
    if hunbred_first(keypoint) and hunbred_second(keypoint) and hunbred_third(keypoint):
        # tts.q.put("헌드레드 자세를 잘 잡으셨어요!")
        return True
    else:
        return False
