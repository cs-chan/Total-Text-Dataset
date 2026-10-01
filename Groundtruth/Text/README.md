## Description

Updates:
New training groundtruth of Total-Text is now available, they are refined with the following attributes:
1) Polygon bounding region with fixed number of vertex (10 vertex),
2) The first point of the polygon bounding region is annotated according to the reading sequence of the text (i.e., top left corner of the annotated text).

However, there is no need for a new version of the test set groundtruth because 

       1) there is no need of standardising the length of the groundtruth vertices for testing purpose, it was proposed to facilitate training only, and
       2) a new version of groundtruth would make the previous benchmarks irrelevant.

Do contact us if you think there is a valid reason to require the new groundtruth for the test set, we shall discuss about it.

More information can be found in our [IJDAR journal](http://web.fsktm.um.edu.my/~cschan/doc/IJDAR2019.pdf) (as referred to in the main page). 

The groundtruth of the Total-Text dataset can be downloaded through the following links. 

Latest refined version:
 - at [this https URL](https://drive.google.com/open?id=1-XrQBoU9as1PXaB_0dUrDTJgvGFFOnDE)

Legacy version:
- at [this https URL](https://drive.google.com/file/d/1v-pd-74EkZ3dWe6k0qppRtetjdPQ3ms1/view?usp=sharing) for text file format('.txt').

- at [this https URL](https://drive.google.com/file/d/19quCaJGePvTc3yPZ7MAGNijjKfy77-ke/view?usp=sharing) for Matlab format ('.mat'). Can be load with Matlab, scipy.io.loadmat, etc..


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
