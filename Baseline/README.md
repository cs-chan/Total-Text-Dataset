Polygon-Faster-RCNN-3 (P3) and Polygon-Faster-RCNN-5 (P5) are two baselines we introduced in our latest IJDAR paper. Both of them are designed based on the Faster-RCNN object detection framework. 
The implemetation is based on the [Tensorflow Object detection API](https://github.com/tensorflow/models/tree/master/research/object_detection).
The major difference between P3 and P5 is that one produces 6-vertex polygon bounding region while P5 produces 10-vertex polygon bounding region.
