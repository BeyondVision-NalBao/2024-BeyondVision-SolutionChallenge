import tensorflow as tf
import cv2
import time
import argparse
import os
import numpy as np

import posenet

global message

# parser = argparse.ArgumentParser()
# parser.add_argument('--model', type=int, default=101)
# parser.add_argument('--scale_factor', type=float, default=1.0)
# parser.add_argument('--notxt', action='store_true')
# parser.add_argument('--image_dir', type=str, default='./images')
# parser.add_argument('--output_dir', type=str, default='./output')
# args = parser.parse_args()

args = {"model": 101, "scale_factor": 1.0, "notxt": True, "image_dir": '../images',
        "output_dir": './output'}


def getAverage(pos, n):
    x, y = 0, 0

    for i in range(n):
        x += pos[i][0]
        y += pos[i][1]

    return [x/n, y/n]


def main(exerciseCode):
    keypointList = []

    with tf.compat.v1.Session() as sess:
        model_cfg, model_outputs = posenet.load_model(args['model'], sess)
        output_stride = model_cfg['output_stride']

        if args['output_dir']:
            if not os.path.exists(args['output_dir']):
                os.makedirs(args['output_dir'])

        filenames = [
            f.path for f in os.scandir(args['image_dir']) if f.is_file() and f.path.endswith(('.png', '.jpg'))]

        exercise = {1: 'squat', 2: 'press_up',
                    2.5: 'press_down', 3: 'raise_up', 3.5: 'raise_down',
                    4: 'hundred', 5: 'plank', 6: 'front_up', 6.5: 'front_down',
                    7: 'zup_up', 7.5: 'zup_down',8: 'bridge_up', 8.5: 'bridge_down',
                    9:'stretching1', 10:'stretching2', 11:'stretching3'}
        f = r"../images\\" + exercise[exerciseCode] + '.jpg'
        start = time.time()

        input_image, draw_image, output_scale = posenet.read_imgfile(
            f, scale_factor=args['scale_factor'], output_stride=output_stride)

        heatmaps_result, offsets_result, displacement_fwd_result, displacement_bwd_result = sess.run(
            model_outputs,
            feed_dict={'image:0': input_image}
        )

        pose_scores, keypoint_scores, keypoint_coords = posenet.decode_multiple_poses(
            heatmaps_result.squeeze(axis=0),
            offsets_result.squeeze(axis=0),
            displacement_fwd_result.squeeze(axis=0),
            displacement_bwd_result.squeeze(axis=0),
            output_stride=output_stride,
            max_pose_detections=10,
            min_pose_score=0.25)

        keypoint_coords *= output_scale

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

        if args['output_dir']:
            draw_image = posenet.draw_skel_and_kp(
                draw_image, pose_scores, keypoint_scores, keypoint_coords,
                min_pose_score=0.25, min_part_score=0.25)

            cv2.imwrite(os.path.join(args['output_dir'],
                        os.path.relpath(f, args['image_dir'])), draw_image)

        for pi in range(len(pose_scores)):
            if pose_scores[pi] == 0.:
                break
            for ki, (s, c) in enumerate(zip(keypoint_scores[pi, :], keypoint_coords[pi, :, :])):
                keypointList.append(c)

        return keypointList


if __name__ == "__main__":
    main()
