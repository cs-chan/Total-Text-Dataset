## Description

These codes are the official evaluation protocol implementation for Total-Text. Two methods are made available: Deteval and Pascal VOC protocols.

IMPORTANT: We recommend the use of the Python Scripts since it comes with the 'Do not care' candidates filtering process. If you prefer to use the Matlab version, make sure you remove your 'Do-not-care' predictions prior to the evaluation process. 

Newly added feature - 'Do not care' candidates filtering is now available in the latest [Python_scripts](https://github.com/cs-chan/Total-Text-Dataset/tree/master/Evaluation_Protocol/Python_scripts) folder.

### Deteval
We recommend tr = 0.7 and tp = 0.6 threshold for a fairer evaluation with polygon ground-truth and detection format.

### Pascal VOC
The conventional 0.5 threshold works fine.
