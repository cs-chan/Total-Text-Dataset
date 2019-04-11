from os import listdir
from scipy import io
import numpy as np
from polygon_fast import iou
from polygon_fast import iod


"""
Input format: y0,x0, ..... yn,xn. Each detection is separated by the end of line token ('\n')'
"""

input_dir = '' #detection directory goes here
gt_dir = '' #gt directory goes here
fid_path = '' #output text file directory goes here

allInputs = listdir(input_dir)

def input_reading_mod(input_dir, input):
    """This helper convert input"""
    with open('%s/%s' %(input_dir, input), 'r') as input_fid:
        pred = input_fid.readlines()
    det = [x.strip('\n') for x in pred]
    return det


def gt_reading_mod(gt_dir, gt_id):
    gt_id = gt_id.split('.')[0]
    gt = io.loadmat('%s/poly_gt_%s.mat' %(gt_dir, gt_id))
    gt = gt['polygt']
    return gt

def detection_filtering(detections, groundtruths, threshold=0.5):
    for gt_id, gt in enumerate(groundtruths):
        if (gt[5] == '#') and (gt[1].shape[1] > 1):
            gt_x = map(int, np.squeeze(gt[1]))
            gt_y = map(int, np.squeeze(gt[3]))
            for det_id, detection in enumerate(detections):
                detection = detection.split(',')
                detection = map(int, detection)
                det_y = detection[0::2]
                det_x = detection[1::2]
                det_gt_iou = iod(det_x, det_y, gt_x, gt_y)
                if det_gt_iou > threshold:
                    detections[det_id] = []

            detections[:] = [item for item in detections if item != []]
    return detections

global_tp = 0
global_fp = 0
global_fn = 0
global_num_of_gt = 0
global_num_of_det = 0

for input_id in allInputs:
    if (input_id != '.DS_Store'):
        print(input_id)
        detections = input_reading_mod(input_dir, input_id)
        groundtruths = gt_reading_mod(gt_dir, input_id)
        detections = detection_filtering(detections, groundtruths) #filtering detections overlaps with DC area
        dc_id = np.where(groundtruths[:, 5] == '#')
        groundtruths = np.delete(groundtruths, (dc_id), (0))

        global_num_of_gt = global_num_of_gt + groundtruths.shape[0]
        global_num_of_det = global_num_of_det + len(detections)
        iou_table = np.zeros((len(detections), groundtruths.shape[0]))
        det_flag = np.zeros((len(detections), 1))
        gt_flag = np.zeros((groundtruths.shape[0], 1))
        tp = 0
        fp = 0
        fn = 0

        if len(detections) > 0:
            for det_id, detection in enumerate(detections):
                detection = detection.split(',')
                detection = map(int, detection)
                det_y = detection[0::2]
                det_x = detection[1::2]
                if len(groundtruths) > 0:
                    for gt_id, gt in enumerate(groundtruths):
                        gt_x = map(int, np.squeeze(gt[1]))
                        gt_y = map(int, np.squeeze(gt[3]))
                        iou_table[det_id, gt_id] = iou(det_x, det_y, gt_x, gt_y)

                    best_matched_gt_id = np.argmax(iou_table[det_id, :]) #identified the best matched detection candidates with current groundtruth
                    if (iou_table[det_id, best_matched_gt_id] >= 0.5):
                        if gt_flag[best_matched_gt_id] == 0: ### if the gt is already matched previously, it should be a false positive
                            tp = tp + 1.0
                            global_tp = global_tp + 1.0
                            gt_flag[best_matched_gt_id] = 1
                        else:
                            fp = fp + 1.0
                            global_fp = global_fp + 1.0
                    else:
                        fp = fp + 1.0
                        global_fp = global_fp + 1.0

        try:
            local_precision = tp / (tp + fp)
        except ZeroDivisionError:
            local_precision = 0

        try:
            local_recall = tp / groundtruths.shape[0]
        except ZeroDivisionError:
            local_recall = 0

        fid = open(fid_path, 'a')
        temp = ('%s______/Precision:_%s_______/Recall:_%s\n' %(input_id, str(local_precision), str(local_recall)))
        fid.write(temp)
        fid.close()
            
global_precision = global_tp / global_num_of_det
global_recall = global_tp / global_num_of_gt
f_score = 2*global_precision*global_recall/(global_precision+global_recall)

fid = open(fid_path, 'a')
temp = ('Precision:_%s_______/Recall:_%s\n' %(str(global_precision), str(global_recall)))
fid.write(temp)
fid.close()
