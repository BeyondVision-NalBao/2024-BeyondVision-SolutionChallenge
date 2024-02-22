import posenet
import tensorflow as tf
import cv2
import numpy as np

import time
import stretching4
import stretching5
import stretching10
import squat
import shoulderPress
import lateralRaise
import hundred
import plank
import zup
import front_raise
import bridge
import ready as ready

import api_Flask.output as output

np.set_printoptions(threshold=np.inf, linewidth=np.inf)

args = {"model": 101, "scale_factor": 1.0, "notxt": True, "image_dir": './images',
        "output_dir": './output'}
position = ["코", "왼쪽눈", "오른쪽눈", "왼쪽귀", "오른쪽귀", "왼쪽어깨", "오른쪽어깨", "왼쪽팔꿈치", "오른쪽팔꿈치",
            "왼쪽손목", "오른쪽손목", "왼쪽골반부위", "오른쪽골반부위", "왼쪽무릎", "오른쪽무릎", "왼쪽발목", "오른쪽발목"]

# 척추상 : Spine At The Shoulder , 척추중 : Middle Of The Spine , 척추하 : Base Of Spine
spine_position = ["척추상", "척추중", "척추하"]
global message


def getAverage(pos, n):
    x, y = 0, 0

    for i in range(n):
        x += pos[i][0]
        y += pos[i][1]

    return [x/n, y/n]


class VideoCamera(object):
    def __init__(self):
        self.cap = cv2.VideoCapture(0)

    def __del__(self):
        self.cap.release()
        
init = True
init2 = False
init3 = False
up = True
cnt = 0
cnt_1 = 0

def gen(camera):
    global message,START,END, init, init2, init3, up , cnt, cnt_1

    if ready.cnt_1==ready.countNumber:
        message = "운동이 끝났습니다"
        finish = True
        output.exercise_output(ready.member_id, ready.WorkOutName, ready.countNumber, ready.cnt_1*5)
        return message

    ready.cnt_1 +=1
    with tf.compat.v1.Session() as sess:
        model_cfg, model_outputs = posenet.load_model(args['model'], sess)
        output_stride = model_cfg['output_stride']
        
        exerciseCode = ready.exerciseCode

        input_image, display_image, output_scale = posenet.read_cap(
            camera, scale_factor=args['scale_factor'], output_stride=output_stride)

        heatmaps_result, offsets_result, displacement_fwd_result, displacement_bwd_result = sess.run(
            model_outputs,
            feed_dict={'image:0': input_image}
        )

        pose_scores, keypoint_scores, keypoint_coords = posenet.decode_multi.decode_multiple_poses(
            heatmaps_result.squeeze(axis=0),
            offsets_result.squeeze(axis=0),
            displacement_fwd_result.squeeze(axis=0),
            displacement_bwd_result.squeeze(axis=0),
            output_stride=output_stride,
            max_pose_detections=10,
            min_pose_score=0.15)

        # 0:코, 1:왼쪽눈, 2:오른쪽눈, 3:왼쪽귀, 4:오른쪽귀", 5:왼쪽어깨, 6:오른쪽어깨
        # 7:왼쪽팔꿈치, 8:오른쪽팔꿈치, 9:왼쪽손목, 10:오른쪽손목, 11:왼쪽골반부위, 12:오른쪽골반부위
        # 13:왼쪽무릎, 14:오른쪽무릎, 15:왼쪽발목, 16:오른쪽발목
        # 17:척추상 = 5/6평균, 18:척추중 = 5/6/11/12평균 19:척추하 = 11/12평균

        spineTop = getAverage(
            [keypoint_coords[0][5], keypoint_coords[0][6]], 2)
        spineMiddle = getAverage(
            [keypoint_coords[0][5], keypoint_coords[0][6], keypoint_coords[0][11], keypoint_coords[0][12]], 4)
        spineBottom = getAverage(
            [keypoint_coords[0][11], keypoint_coords[0][12]], 2)

        spine_pos = [spineTop, spineMiddle, spineBottom]

        for i in range(3):
            tmp = np.array([[spine_pos[i]], [[0.0, 0.0]], [[0.0, 0.0]], [[0.0, 0.0]], [[0.0, 0.0]], [[
                0.0, 0.0]], [[0.0, 0.0]], [[0.0, 0.0]], [[0.0, 0.0]], [[0.0, 0.0]]])
            keypoint_coords = np.concatenate(
                (keypoint_coords, tmp), axis=1)
            keypoint_scores = np.concatenate(
                (keypoint_scores, np.array([[1], [0.00000000e+00], [0.00000000e+00], [0.00000000e+00], [0.00000000e+00], [0.00000000e+00], [0.00000000e+00], [0.00000000e+00], [0.00000000e+00], [0.00000000e+00]])), axis=1)

        keypoint_coords *= output_scale
        position.extend(spine_position)

        if init ==True:
            if ready.isReady(keypoint_coords[0]):
                if exerciseCode == 1 and ready.isSide(keypoint_coords[0]):
                    init = False
                    init2 = True
                    return ready.message
                elif exerciseCode == 2 and ready.isFront(keypoint_coords[0]):
                    init = False
                    init2 = True
                    return ready.message
                elif exerciseCode == 3 and ready.isSide(keypoint_coords[0]):
                    init = False
                    init2 = True
                    return ready.message
                elif exerciseCode == 4 and ready.isSide(keypoint_coords[0]):
                    init = False
                    init2 = True
                    return ready.message
                elif exerciseCode == 5 and ready.isSide(keypoint_coords[0]):
                    init = False
                    init2 = True
                    return ready.message
                elif exerciseCode == 6 and ready.isFront(keypoint_coords[0]):
                    init = False
                    init2 = True
                    return ready.message
                elif exerciseCode == 7 and ready.isSide(keypoint_coords[0]):
                    init = False
                    init2 = True
                    return ready.message
                elif exerciseCode == 8 and ready.isSide(keypoint_coords[0]):
                    init = False
                    init2 = True
                    return ready.message
                elif exerciseCode == 9 and ready.isFront(keypoint_coords[0]):
                    init = False
                    init2 = True
                    return ready.message
                elif exerciseCode == 10 and ready.isFront(keypoint_coords[0]):
                    init = False
                    init2 = True
                    return ready.message
                elif exerciseCode == 11 and ready.isSide(keypoint_coords[0]):
                    init = False
                    init2 = True
                    return ready.message
                else:
                    return ready.message
            else: 
                return ready.message

        if init2 == True:
            if exerciseCode == 1:
                if squat.squat_knee_angle(keypoint_coords[0]):
                    if squat.squat_down(keypoint_coords[0]):
                        if squat.squat_straight(keypoint_coords[0]):
                            message = "자세가 좋습니다 "
                            ready.cnt += 1
                        else: return squat.message
                    else: return squat.message
                else: return squat.message
            elif exerciseCode == 2:
                if shoulderPress.pressDown1(keypoint_coords[0]):
                    if shoulderPress.pressDown2(keypoint_coords[0]):
                        message = "자세가 좋습니다"
                        ready.cnt += 1  
                    else: return shoulderPress.message 
                else: return shoulderPress.message
            elif exerciseCode == 3:
                if lateralRaise.raiseUp(keypoint_coords[0]):
                    message = "자세가 좋습니다"
                    ready.cnt += 1  
                else : return lateralRaise.message
            elif exerciseCode == 4:
                if hundred.hundred_first(keypoint_coords[0]):
                    if hundred.hunbred_secon(keypoint_coords[0]):
                        if hundred.hundred_third:
                            message = "자세를 유지해주세요!"
                        else: return hundred.message
                    else: return hundred.message
                else: return hundred.message
            elif exerciseCode ==5: 
                if plank.plank_first(keypoint_coords[0]):
                    if plank.plank_second(keypoint_coords[0]):
                        if plank.plank_third(keypoint_coords[0]):
                            message = "자세를 유지해주세요!"
                        else: return plank.message
                    else: return plank.message
                else: return plank.message
            elif exerciseCode == 6:
                if front_raise.raiseup:
                    message = "자세가 좋습니다"
                    ready.cnt += 1
                else: return front_raise.message
            elif exerciseCode == 7:
                if zup.zup_down1(keypoint_coords[0]):
                    if zup.zup_down2(keypoint_coords[0]):
                        if zup.zup_down3(keypoint_coords[0]):
                            message = "자세를 유지해주세요!"
                        else: return zup.message
                    else: return zup.message
                else: return zup.message
            elif exerciseCode == 8:
                if bridge.bridge_up1(keypoint_coords[0]):
                    if bridge.bridge_up2(keypoint_coords[0]):
                        message ="자세가 좋습니다"
                        ready.cnt += 1
                    else: return bridge.message
                else: return bridge.message
            elif exerciseCode == 9:
                if stretching4.leftArm_position(keypoint_coords[0]):
                    if stretching4.rightArm_position(keypoint_coords[0]):
                        message ="3초간 유지합니다"
                    else: return stretching4.message
                else: return stretching4.message
            elif exerciseCode == 10:
                if stretching5.leftArm_position(keypoint_coords[0]):
                    if stretching5.rightArm_position(keypoint_coords[0]):
                        if stretching5.check_backbone(keypoint_coords[0]):
                            message ="3초간 유지합니다"
                        else: return stretching5.message
                    else: return stretching5.message
                else: return stretching5.message
            elif exerciseCode ==11:
                if stretching10.right_down(keypoint_coords[0]):
                    if stretching10.right_leg_straight(keypoint_coords[0]):
                        message ="3초간 유지합니다"
                    else: return stretching10.message
                else: return stretching10.message

        # 여기에 count종료 코드 써야 함
        # TODO this isn't particularly fast, use GL for drawing and display someday...
        overlay_image = posenet.draw_skel_and_kp(
            display_image, pose_scores, keypoint_scores, keypoint_coords,
            min_pose_score=0.15, min_part_score=0.1)

        overlay_image = cv2.resize(overlay_image, dsize=(
            1240, 920), interpolation=cv2.INTER_AREA)

        overlay_image = cv2.flip(overlay_image, 1)
        
    return message
