Polygon-Faster-RCNN-3 (P3) and Polygon-Faster-RCNN-5 (P5) are two baselines we introduced in our latest IJDAR paper. Both of them are designed based on the Faster-RCNN object detection framework. 

The implemetation is based on the [Tensorflow Object detection API](https://github.com/tensorflow/models/tree/master/research/object_detection).

The major difference between P3 and P5 is that one produces 6-vertex polygon bounding region while P5 produces 10-vertex polygon bounding region.

P3 is available at [this share drive](https://drive.google.com/open?id=1kE48CP_mwvINytWeshm-aTdnM2dFmjnv), and
P5 is [here](https://drive.google.com/open?id=11ciMWgrPTYCWIJfU3G1vPt_AY1dLm928).

Run ./train.sh to train the model,
./inference.sh to test the model,
./create_tf_record.sh to create a tfrecord (input required by the Tensorflow Object Detection API) for the Total-Text dataset. 

The directories (image folder, ground truth folder, output) should be altered to your local address for them to work properly.

