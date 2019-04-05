## Description

The groundtruth of the Total-Text dataset can be downloaded through the following links. Two formats are made available:

a) at [this https URL](https://drive.google.com/file/d/1v-pd-74EkZ3dWe6k0qppRtetjdPQ3ms1/view?usp=sharing) for text file format('.txt').

b) at [this https URL](https://drive.google.com/file/d/19quCaJGePvTc3yPZ7MAGNijjKfy77-ke/view?usp=sharing) for Matlab format ('.mat'). Can be load with Matlab, scipy.io.loadmat, etc..


<img src="sample.png" width="100%">

There are two(2) folders:

### Polygon - Our proposed polygon-shaped bounding region
The format is
* Column 1-2 = X-coordinate
* Column 3-4 = Y-coordinate
* Column 5 = Text
* Column 6 = Orientation (c=curve; h=horizontal; m=multi-oriented; #=dont care)

<img src="polygon.png" width="50%">

### Rectangular - Conventional rectangular bounding box
The format is
* Column 1 = X-min
* Column 2 = Y-min
* Column 3 = X-max
* Column 4 = Y-max
* Column 5 = Width
* Column 6 = Height
* Column 7 = Text
* Column 8 = Orientation (c=curve; h=horizontal; m=multi-oriented; #=dont care)
