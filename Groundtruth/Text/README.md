## Description

The groundtruth of the Total-Text dataset can be downloaded through the following links:

(http://www.cs-chan.com/source/ICDAR2017/groundtruth_text.zip) - '.mat' Matlab format. Can be load with Matlab, scipy.io.loadmat, etc..

(http://www.cs-chan.com/source/ICDAR2017/txt_format.zip) - '.txt' format.

<img src="sample.png" width="100%">

There are two(2) folders:

### Polygon - Our proposed polygon-shaped bounding region
The format is
* Column 1-2 = X-coordinate
* Column 3-4 = Y-coordinate
* Column 5 - Text
* Column 6 - Orientation (c=curve; h=horizontal; m=multi-oriented; #=dont care)

<img src="polygon.png" width="50%">

### Rectangular - Conventional rectangular bounding box
The format is
* Column 1 = X-min
* Column 2 = Y-min
* Column 3 = X-max
* Column 4 = Y-max
* Column 5 - Width
* Column 6 - Height
* Column 7 - Text
* Column 8 - Orientation (c=curve; h=horizontal; m=multi-oriented; #=dont care)
