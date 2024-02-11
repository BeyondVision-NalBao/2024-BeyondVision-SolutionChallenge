import posenet
import tensorflow as tf
import cv2
import numpy as np

import time
import squat
import shoulderPress
import lateralRaise
import ready
from speechRecognition import tts
np.set_printoptions(threshold=np.inf, linewidth=np.inf)

args = {"model": 101, "scale_factor": 1.0, "notxt": True, "image_dir": './images',
        "output_dir": './output'}
position = ["코", "왼쪽눈", "오른쪽눈", "왼쪽귀", "오른쪽귀", "왼쪽어깨", "오른쪽어깨", "왼쪽팔꿈치", "오른쪽팔꿈치",
            "왼쪽손목", "오른쪽손목", "왼쪽골반부위", "오른쪽골반부위", "왼쪽무릎", "오른쪽무릎", "왼쪽발목", "오른쪽발목"]

# 척추상 : Spine At The Shoulder , 척추중 : Middle Of The Spine , 척추하 : Base Of Spine
spine_position = ["척추상", "척추중", "척추하"]


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


def gen(camera):
    tts.q.queue.clear()
    with tf.compat.v1.Session() as sess:
        model_cfg, model_outputs = posenet.load_model(args['model'], sess)
        output_stride = model_cfg['output_stride']

        start = time.time()
        frame_count = 0
        cnt = 0
        cycle = 3
        init = True
        init2 = False
        init3 = False
        flag_sp = True
        flag_lr = True
        finish = False

        exerciseCode = ready.exerciseCode

        while True:
            cnt += 1
            input_image, display_image, output_scale = posenet.read_cap(
                camera.cap, scale_factor=args['scale_factor'], output_stride=output_stride)

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

            if cnt == 1:
                tts.q.queue.clear()
                tts.q.put("잠시후에 시작합니다. 자리를 잡아주세요.")

            if cnt % cycle == 0:
                if init:
                    if cnt > 30 and ready.isReady(keypoint_coords[0]):
                        init = False
                        init2 = True
                        init3 = True

                elif init2:
                    if exerciseCode == 1 and ready.isSide(keypoint_coords[0]):
                        init2 = False
                        init3 = True
                        squat.setting(exerciseCode)
                        tts.q.put(
                            "스쿼트 자세 설명입니다.. 두 발을 골반 너비로 벌리고, 허벅지와 무릎이 수평이 될때까지 천천히 앉았다 일어서세요. 이때 무릎은 발끝 앞으로 나오지않도록 주의하시고, 허리는 곧게 펴세요.... 스쿼트를 1회 진행하세요.")
                    elif exerciseCode == 2:
                        if flag_sp:
                            if ready.isFront(keypoint_coords[0]):
                                flag_sp = False
                        elif init3:
                            shoulderPress.setting(exerciseCode)
                            tts.q.put(
                                "숄더프레스 자세 설명입니다.. 손이 귀와 수평이 되고, 팔꿈치가 직각이 되도록 위치 시킨후, 이두근이 귀에 닿는 느낌으로 손을 머리위로 들어올리세요. 이후, 천천히 저항을 느끼면서 다시 내려옵니다.... 숄더프레스를 1회 진행하세요.")
                            init3 = False
                        elif shoulderPress.isDown(keypoint_coords[0]):
                            init2 = False
                            init3 = True
                    elif exerciseCode == 3:
                        if flag_lr:
                            if ready.isFront(keypoint_coords[0]):
                                flag_lr = False
                        elif init3:
                            lateralRaise.setting(exerciseCode)
                            tts.q.put(
                                "리터럴 레이즈 자세 설명입니다.. 승모근에 힘을 빼고, 무릎을 살짝 굽힌 상태로, 양쪽으로 팔을 밀어올린다는 느낌으로 양 팔을 어깨 높이까지 들어올리세요. 내릴 때는, 천천히 내려주시고, 이 두 동작을 반복해주세요.... 레터럴 레이즈를 1회 진행하세요.")
                            init3 = False
                        elif lateralRaise.raiseDown(keypoint_coords[0]):
                            init2 = False
                            init3 = True
                elif init3:
                    if exerciseCode == 1:
                        if squat.postureCorrection(keypoint_coords[0]):
                            tts.q.queue.clear()
                            tts.q.put(
                                "스쿼트 자세를 잘 잡으셨어요!,,, 잠시후 카운트를 시작합니다.")
                            tts.q.put(str(ready.countNumber) + "회 반복해주세요.")
                            cnt = 2
                            init3 = False
                    elif exerciseCode == 2:
                        if shoulderPress.postureCorrection(keypoint_coords[0]):
                            tts.q.queue.clear()
                            tts.q.put(
                                "숄더 프레스 자세를 잘 잡으셨어요!,,, 잠시후 카운트를 시작합니다.")
                            tts.q.put(str(ready.countNumber) + "회 반복해주세요.")
                            cnt = 2
                            init3 = False
                    elif exerciseCode == 3:
                        if lateralRaise.postureCorrection(keypoint_coords[0]):
                            tts.q.queue.clear()
                            tts.q.put(
                                "레터럴 레이즈 자세를 잘 잡으셨어요! ,,, 잠시후 카운트를 시작합니다.")
                            tts.q.put(str(ready.countNumber) + "회 반복해주세요.")
                            cnt = 2
                            init3 = False

                else:
                    if exerciseCode == 1:
                        if cnt == 33:
                            tts.q.put("시작해주세요.")
                        elif cnt > 33 and squat.counting(keypoint_coords[0]):
                            if squat.CNT == ready.countNumber:
                                tts.q.put("스쿼트" + str(ready.countNumber) +
                                          " 회를 마쳤습니다. 수고하셨습니다.")
                                squat.CNT = 0
                                finish = True
                    elif exerciseCode == 2:
                        if cnt == 33:
                            tts.q.put("시작해주세요.")
                        elif cnt > 33 and shoulderPress.counting(keypoint_coords[0]):
                            if shoulderPress.CNT == ready.countNumber:
                                tts.q.put(
                                    "숄더프레스" + str(ready.countNumber) + " 회를 마쳤습니다. 수고하셨습니다.")
                                shoulderPress.CNT = 0
                                finish = True
                    elif exerciseCode == 3:
                        if cnt == 33:
                            tts.q.put("시작해주세요.")
                        elif cnt > 33 and lateralRaise.counting(keypoint_coords[0]):
                            if lateralRaise.CNT == ready.countNumber:
                                tts.q.put(
                                    "레터럴레이즈" + str(ready.countNumber) + " 회를 마쳤습니다. 수고하셨습니다.")
                                lateralRaise.CNT = 0
                                finish = True

            # TODO this isn't particularly fast, use GL for drawing and display someday...
            overlay_image = posenet.draw_skel_and_kp(
                display_image, pose_scores, keypoint_scores, keypoint_coords,
                min_pose_score=0.15, min_part_score=0.1)

            overlay_image = cv2.resize(overlay_image, dsize=(
                1240, 920), interpolation=cv2.INTER_AREA)

            overlay_image = cv2.flip(overlay_image, 1)

            frame_count += 1

            if finish == False:
                ret, jpeg = cv2.imencode('.jpg', overlay_image)
                frame = jpeg.tobytes()
                yield (b'--frame\r\n'
                       b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n\r\n')
            else:
                jpeg = cv2.imread('images/finish.png', cv2.IMREAD_COLOR)
                tmp, frame = cv2.imencode('.JPEG', jpeg)
                yield (b'--frame\r\n'
                       b'Content-Type: image/jpeg\r\n\r\n' + frame.tostring() + b'\r\n')
                break
