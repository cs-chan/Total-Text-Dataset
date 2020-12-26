# Total-Text-Dataset (Official site)
Updated on April 29, 2020 (Detection leaderboard is updated - highlighted E2E methods. Thank you [shine-lcy](https://github.com/shine-lcy).)

Updated on March 19, 2020 (Query on the new groundtruth of test set)

Updated on Sept. 08, 2019 (New [training groundtruth](https://github.com/cs-chan/Total-Text-Dataset/tree/master/Groundtruth/Text) of Total-Text is now available)

Updated on Sept. 07, 2019 (Updated [Guided Annotation toolbox](https://github.com/cs-chan/Total-Text-Dataset/tree/master/Annotation_tools) for scene text image annotation)

Updated on Sept. 07, 2019 (Updated [baseline](https://github.com/cs-chan/Total-Text-Dataset/tree/master/Baseline) as to our IJDAR)

Updated on August 01, 2019 (Extended version with new baseline + annotation tool is accepted at [IJDAR](https://link.springer.com/article/10.1007/s10032-019-00334-z))

Updated on May 30, 2019 (Important announcement on Total-Text vs. ArT dataset)

Updated on April 02, 2019 (Updated table ranking with default vs. our proposed DetEval)

Updated on March 31, 2019 (Faster version DetEval.py, support Python3. Thank you [princewang1994](https://github.com/princewang1994).)

Updated on March 14, 2019 (Updated table ranking with evaluation protocol info.)

Updated on November 26, 2018 (Table ranking is included for reference.)

Updated on August 24, 2018 (Newly added [Guided Annotation toolbox](https://github.com/cs-chan/Total-Text-Dataset/tree/master/Annotation_tools) folder.)

Updated on May 15, 2018 (Added groundtruth in '.txt' format.)

Updated on May 14, 2018 (Added feature - 'Do not care' candidates filtering is now available in the latest python scripts.)

Updated on April 03, 2018 (Added pixel level groundtruth)

Updated on November 04, 2017 (Added text level groundtruth)

Released on October 27, 2017

# News
- We received some questions in regard to the new groundtruth for the test set of Total-Text. Here is an update. We do not           release a new version of the test set groundtruth because 

       1) there is no need of standardising the length of the groundtruth vertices for testing purpose, it was proposed to facilitate training only, and
       2) a new version of groundtruth would make the previous benchmarks irrelevant.

Do contact us if you think there is a valid reason to require the new groundtruth for the test set, we shall discuss about it.

- TOTAL-TEXT is a word-level based English curve text dataset. If you are interested in text-line based dataset with both English and Chinese instances, we highly recommend you to refer [SCUT-CTW1500](https://github.com/Yuliang-Liu/Curve-Text-Detector). In addition, a Robust Reading Challenge on Arbitrary-Shaped Text ([RRC-ArT](http://rrc.cvc.uab.es/?ch=14)), which is extended from Total-Text and SCUT-CTW1500, was held at ICDAR2019 to stimulate more innovative ideas on the arbitrary-shaped text reading task. Congratulations to all winners and challengers. The technical report of ArT can be found on at [this https URL](https://arxiv.org/abs/1909.07145).

# Important Announcement
Total-Text and SCUT-CTW1500 are now part of the training set of the largest curved text dataset - [ArT (Arbitrary-Shaped Text dataset)](http://rrc.cvc.uab.es/?ch=14). In order to retain the validity of future benchmarking on Total-Text datasets, the **test-set images** of Total-Text should be removed (with the corresponding ID provided [HERE](https://github.com/cs-chan/Total-Text-Dataset/blob/master/Total_Text_ID_vs_ArT_ID.list)) from the ArT dataset shall one intend to leverage the extra training data from the ArT dataset. We count on the trust of the research community to perform such removal operation to attain the fairness of the benchmarking.

## Table Ranking

- The results from recent papers on Total-Text dataset are listed below where P=Precision, R=Recall & F=F-score.
- If your result is missing or incorrect, please do not hesisate to contact us.
- The baseline scores are based on our proposed <a href="http://cs-chan.com/doc/IJDAR2019.pdf">[Poly-FRCNN-3]</a> in [this folder](https://github.com/cs-chan/Total-Text-Dataset/tree/master/Baseline).
- <sup>*</sup>Pascal VOC IoU metric; <a href="https://arxiv.org/abs/1712.02170"><sup>**</sup>Polygon Regression</a>

### Detection Leaderboard
<table>
    <thead align="center">
       <tr>
           <th rowspan=2>Method</th>
           <th colspan=3>Reported <br>on paper</th>
           <th colspan=3>DetEval <br> (tp=0.4, tr=0.8) <br>(Default)</th>
           <th colspan=3>DetEval <br>(tp=0.6, tr=0.7) <br>(New Proposal) </th>
           <th rowspan=2>Published at</th>
        </tr>
        <tr>
            <th>P</th>
            <th>R</th>
            <th>F</th>
            <th>P</th>
            <th>R</th>
            <th>F</th>
            <th>P</th>
            <th>R</th>
            <th>F</th>
        </tr>
    </thead>
    <tbody align="center">
        <tr>
           <td><b>Our Baseline</b></td>
           <td><b>78.0</b></td>
           <td><b>68.0</b></td>
           <td><b>73.0</b></td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td><b>78.0</b></td>
           <td><b>68.0</b></td>
           <td><b>73.0</b></td>
           <td><b>IJDAR2020</b></td>
        </tr>
        <tr>
           <td><sup>#</sup><i>ASTS_Weakly-ResNet101 (E2E) <a href="https://ieeexplore.ieee.org/document/9056856">[paper]</a></i></td>
           <td><i>-</i></td>
           <td><i>-</i></td>
           <td><i>87.3</i></td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td><i>TIP2020</i></td>
        </tr>
        <tr>
           <td ><sup>#</sup><i>Boundary (E2E) <a href="https://arxiv.org/abs/1911.09550">[paper]</a></i></td>
           <td><i>88.9</i></td>
           <td><i>85.0</i></td>
           <td><i>87.0</i></td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td><i>AAAI2020</i></td>
        </tr>
        <tr>
           <td>PolyPRNet <a href="https://openaccess.thecvf.com/content/ACCV2020/html/Shi_Accurate_Arbitrary-Shaped_Scene_Text_Detection_via_Iterative_Polynomial_Parameter_Regression_ACCV_2020_paper.html">[paper]</a></td>
           <td><i>88.1</i></td>
           <td><i>85.3</i></td>
           <td><i>86.7</i></td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td><i>ACCV2020</i></td>
        </tr>
        <tr>
           <td><sup>#</sup><i>Qin et al. (E2E) <a href="http://openaccess.thecvf.com/content_ICCV_2019/papers/Qin_Towards_Unconstrained_End-to-End_Text_Spotting_ICCV_2019_paper.pdf">[paper]</a></i></td>
           <td><i>87.8</i></td>
           <td><i>85.0</i></td>
           <td><i>86.4</i></td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td><i>ICCV2019</i></td>
        </tr>
        <tr>
           <td>ContourNet <a href="https://arxiv.org/abs/2004.04940">[paper]</a></td>
           <td>86.9</td>
           <td>83.9</td>
           <td>85.4</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>CVPR2020</td>
        </tr>   
        <tr>
           <td><sup>#</sup><i>Text Perceptron (E2E) <a href="https://arxiv.org/abs/2002.06820">[paper]</a></i></td>
           <td><i>88.8</i></td>
           <td><i>81.8</i></td>
           <td><i>85.2</i></td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td><i>AAAI2020</i></td>
           </tr>       
        <tr>
           <td>PAN-640 <a href="https://arxiv.org/abs/1908.05900">[paper]</a></td>
           <td>89.3</td>
           <td>81.0</td>
           <td>85.0</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>ICCV2019</td>
        </tr>   
        <tr>
           <td>DB-ResNet50 (800) <a href="https://arxiv.org/abs/1911.08947">[paper]</a></td>
           <td>87.1</td>
           <td>82.5</td>
           <td>84.7</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>AAAI2020</td>
        </tr>
        <tr>
           <td>TextCohesion <a href="https://arxiv.org/abs/1904.12640">[paper]</a></td>
           <td>88.1</td>
           <td>81.4</td>
           <td>84.6</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>arXiv:1904</td>
        </tr>
           <tr>
           <td>Feng et al. <a href="http://159.226.21.68/bitstream/173211/41453/1/发表版.pdf">[paper]</a></td>
           <td>87.3</td>
           <td>81.1</td>
           <td>84.1</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>IJCV2020</td>
        </tr>
           <tr>
           <td>ReLaText <a href="https://arxiv.org/abs/2003.06999">[paper]</a></td>
           <td>84.8</td>
           <td>83.1</td>
           <td>84.0</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>arXiv:2003</td>
        </tr>
        <tr>
           <td>CRAFT <a href="https://arxiv.org/abs/1904.01941">[paper]</a></td>
           <td>87.6</td>
           <td>79.9</td>
           <td>83.6</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>CVPR2019</td>
        </tr>
        <tr>
           <td>LOMO MS <a href="https://arxiv.org/abs/1904.06535">[paper]</a></td>
           <td>87.6</td>
           <td>79.3</td>
           <td>83.3</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>CVPR2019</td>
        </tr>
        <tr>
           <td>SPCNet <a href="https://arxiv.org/abs/1811.08605">[paper]</a></td>
           <td>83.0</td>
           <td>82.8</td>
           <td>82.9</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>AAAI2019</td>
        </tr>
        <tr>
           <td><sup>#</sup><i>ABCNet (E2E) <a href="https://arxiv.org/abs/2002.10200">[paper]</a></i></td>
           <td><i>85.4</i></td>
           <td><i>80.1</i></td>
           <td><i>82.7</i></td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td><i>CVPR2020</i></td>
        </tr>
        <tr>
           <td>ICG <a href="https://www.sciencedirect.com/science/article/abs/pii/S0031320319302511">[paper]</a></td>
           <td>82.1</td>
           <td>80.9</td>
           <td>81.5</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>PR2019</td>
        </tr>
        <tr>
           <td>FTSN <a href="https://arxiv.org/abs/1709.03272">[paper]</a></td>
           <td><sup>*</sup>84.7</td>
           <td><sup>*</sup>78.0</td>
           <td><sup>*</sup>81.3</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>ICPR2018</td>
        </tr> 
        <tr>
           <td>PSENet-1s <a href="https://arxiv.org/abs/1903.12473">[paper]</a></td>
           <td>84.02</td>
           <td>77.96</td>
           <td>80.87</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>CVPR2019</td>
        </tr>
        <tr>
            <td><sup>1</sup>TextField <a href="https://arxiv.org/abs/1812.01393">[paper]</a></td>
           <td>81.2</td>
           <td>79.9</td>
           <td>80.6</td>
           <td>76.1</td>
           <td>75.1</td>
           <td>75.6</td>
           <td>83.0</td>
           <td>82.0</td>
           <td>82.5</td>
           <td>TIP2019</td>
        </tr>
        <tr>
           <td><sup>#</sup><i>TextDragon (E2E) <a href="http://openaccess.thecvf.com/content_ICCV_2019/papers/Feng_TextDragon_An_End-to-End_Framework_for_Arbitrary_Shaped_Text_Spotting_ICCV_2019_paper.pdf">[paper]</a></i></td>
           <td><i>85.6</i></td>
           <td><i>75.7</i></td>
           <td><i>80.3</i></td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td><i>ICCV2019</i></td>
        </tr>
        <tr>
           <td>CSE <a href="https://arxiv.org/abs/1903.08836">[paper]</a></td>
           <td>81.4<br>(<sup>**</sup>80.9)</td>
           <td>79.7<br>(<sup>**</sup>80.3)</td>
           <td>80.2<br>(<sup>**</sup>80.6)</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>CVPR2019</td>
        </tr>
        <tr>
           <td>MSR <a href="https://arxiv.org/abs/1901.02596">[paper]</a></td>
           <td>85.2</td>
           <td>73.0</td>
           <td>78.6</td>
           <td>82.7</td>
           <td>68.3</td>
           <td>74.9</td>
           <td>81.4</td>
           <td>72.5</td>
           <td>76.7</td>
           <td>arXiv:1901</td>
        </tr>
        <tr>
           <td>ATTR <a href="http://openaccess.thecvf.com/content_CVPR_2019/papers/Wang_Arbitrary_Shape_Scene_Text_Detection_With_Adaptive_Text_Region_Representation_CVPR_2019_paper.pdf">[paper]</a></td>
           <td>80.9</td>
           <td>76.2</td>
           <td>78.5</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>CVPR2019</td>
        </tr>
        <tr>
           <td>TextSnake <a href="http://openaccess.thecvf.com/content_ECCV_2018/papers/Shangbang_Long_TextSnake_A_Flexible_ECCV_2018_paper.pdf">[paper]</a></td>
           <td>82.7</td>
           <td>74.5</td>
           <td>78.4</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>ECCV2018</td>
        </tr>
        <tr>
           <td><sup>1</sup>CTD <a href="https://www.sciencedirect.com/science/article/pii/S0031320319300664">[paper]</a></td>
           <td>74.0</td>
           <td>71.0</td>
           <td>73.0</td>
           <td>60.7</td>
           <td>58.8</td>
           <td>59.8</td>
           <td>76.5</td>
           <td>73.8</td>
           <td>75.2</td>
           <td>PR2019</td>
        </tr>
        <tr>
           <td><sup>#</sup><i>TextNet (E2E) <a href="https://arxiv.org/abs/1812.09900">[paper]</a></i></td>
           <td><i>68.2</i></td>
           <td><i>59.5</i></td>
           <td><i>63.5</i></td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td><i>ACCV2018</i></td>
        </tr>
        <tr>
           <td><sup>#,2</sup><i>Mask TextSpotter (E2E) <a href="http://openaccess.thecvf.com/content_ECCV_2018/papers/Pengyuan_Lyu_Mask_TextSpotter_An_ECCV_2018_paper.pdf">[paper]</a></i></td>
           <td><i>69.0</i></td>
           <td><i>55.0</i></td>
           <td><i>61.3</i></td>
           <td><i>68.9</i></td>
           <td><i>62.5</i></td>
           <td><i>65.5</i></td>
           <td><i>82.5</i></td>
           <td><i>75.2</i></td>
           <td><i>78.6</i></td>
           <td><i>ECCV2018</i></td>
        </tr>
        <tr>
           <td>CENet <a href="https://arxiv.org/abs/1901.00363">[paper]</a></td>
           <td>59.9</td>
           <td>54.4</td>
           <td>57.0</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>ACCV2018</td>
        </tr>
        <tr>
           <td><sup>#</sup><i>Textboxes (E2E) <a href="https://arxiv.org/abs/1611.06779">[paper]</a></i></td>
           <td><i>62.1</i></td>
           <td><i>45.5</i></td>
           <td><i>52.5</i></td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td><i>AAAI2017</i></td>
        </tr>
        <tr>
           <td>EAST <a href="https://arxiv.org/abs/1704.03155">[paper]</a></td>
           <td>50.0</td>
           <td>36.2</td>
           <td>42.0</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>CVPR2017</td>
        </tr>
        <tr>
           <td>SegLink <a href="https://arxiv.org/abs/1703.06520">[paper]</a></td>
           <td>30.3</td>
           <td>23.8</td>
           <td>26.7</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>-</td>
           <td>CVPR2017</td>
        </tr>
    </tbody>
</table>

Note:

<sup>#</sup> Framework that does end-to-end training (i.e. detection + recognition).

<sup>1</sup>For the results of TextField and CTD, the improved versions of their original paper were used, and this explains why the performance is better.

<sup>2</sup>For Mask-TextSpotter, the relatively poor performance reported in their paper was due to a bug in the input reading module (which was fixed recently). The authors were informed about this issue.

### End-to-end Recognition Leaderboard <br> (None refers to recognition without any lexicon; Full lexicon contains all words in test set.)

<table>
    <thead align="center">
       <tr>
            <th>Method</th>
            <th>Backbone</th>
            <th>None (%)</th>
            <th>Full (%)</th>
            <th>FPS</th>
            <th>Published at</th>
        </tr>
    </thead>
    <tbody align="center">
           <tr>
              <td>MANGO <a href="https://arxiv.org/abs/2012.04350">[paper]</a></td>
              <td>ResNet50-FPN</td>
              <td>72.9</td>
              <td>83.6</td>
              <td>4.3</td>
              <td>AAAI2021</td>
       </tr>
       <tr>
              <td>Text Perceptron <a href="https://arxiv.org/abs/2002.06820">[paper]</a></td>
              <td>ResNet50-FPN</td>
              <td>69.7</td>
              <td>78.3</td>
              <td>-</td>
              <td>AAAI2020</td>
       </tr>
       <tr>
              <td>ABCNet-MS <a href="https://arxiv.org/abs/2002.10200">[paper]</a></td>
              <td>ResNet50-FPN</td>
              <td>69.5</td>
              <td>78.4</td>
              <td>6.9</td>
              <td>CVPR2020</td>
       </tr>
       <tr>
              <td>CharNet H-88 MS <a href="https://arxiv.org/abs/1910.07954">[paper]</a></td>
              <td>ResNet50-Hourglass57</td>
              <td>69.2</td>
              <td>-</td>
              <td>1.2</td>
              <td>ICCV2019</td>
       </tr>
       <tr>
              <td>Qin et al. <a href="http://openaccess.thecvf.com/content_ICCV_2019/papers/Qin_Towards_Unconstrained_End-to-End_Text_Spotting_ICCV_2019_paper.pdf">[paper]</a></td>
              <td>ResNet50-MSF</td>
              <td>67.8</td>
              <td>-</td>
              <td>-</td>
              <td>ICCV2019</td>
       </tr>
       <tr>
              <td align="center">ASTS_Weakly <a href="https://ieeexplore.ieee.org/document/9056856">[paper]</a></td>
              <td align="center">ResNet101-FPN</td>
              <td align="center">65.3</td>
              <td align="center">84.2</td>
              <td align="center">2.5</td>
              <td align="center">TIP2020</td>
       </tr>
       <tr>
              <td>Boundary <a href="https://arxiv.org/abs/1911.09550">[paper]</a></td>
              <td>ResNet50-FPN</td>
              <td>65.0</td>
              <td>76.1</td>
              <td>-</td>
              <td>AAAI2020</td>
       </tr>
       <tr>
              <td>ABCNet <a href="https://arxiv.org/abs/2002.10200">[paper]</a></td>
              <td>ResNet50-FPN</td>
              <td>64.2</td>
              <td>75.7</td>
              <td>17.9</td>
              <td>CVPR2020</td>
       </tr>
       <tr>
              <td>CAPNet <a href="https://arxiv.org/abs/2002.03509">[paper]</a></td>
              <td>ResNet50-FPN</td>
              <td>62.7</td>
              <td>-</td>
              <td>-</td>
              <td>ICASSP2020</td>
       </tr>
               <tr>
              <td align="center">Feng et al. <a href="http://159.226.21.68/bitstream/173211/41453/1/发表版.pdf">[paper]</a></td>
              <td align="center">VGG</td>
              <td align="center">55.8</td>
              <td align="center">79.2</td>
              <td align="center">-</td>
              <td align="center">IJCV2020</td>
       </tr>
       <tr>
              <td>TextNet <a href="https://arxiv.org/abs/1812.09900">[paper]</a></td>
              <td>ResNet50-SAM</td>
              <td>54.0</td>
              <td>-</td>
              <td>2.7</td>
              <td>ACCV2018</td>
       </tr>
       <tr>
              <td>Mask TextSpotter <a href="http://openaccess.thecvf.com/content_ECCV_2018/papers/Pengyuan_Lyu_Mask_TextSpotter_An_ECCV_2018_paper.pdf">[paper]</a></td>
              <td>ResNet50-FPN</td>
              <td>52.9</td>
              <td>71.8</td>
              <td>4.8</td>
              <td>ECCV2018</td>
       </tr>
       <tr>
              <td>TextDragon <a href="http://openaccess.thecvf.com/content_ICCV_2019/html/Feng_TextDragon_An_End-to-End_Framework_for_Arbitrary_Shaped_Text_Spotting_ICCV_2019_paper.html">[paper]</a></td>
              <td>VGG16</td>
              <td>48.8</td>
              <td>74.8</td>
              <td>-</td>
              <td>ICCV2019</td>
       </tr>
       <tr>
              <td>Textboxes <a href="https://arxiv.org/abs/1611.06779">[paper]</a></td>
              <td>ResNet50-FPN</td>
              <td>36.3</td>
              <td>48.9</td>
              <td>1.4</td>
              <td>AAAI2017</td>
       </tr>
    </tbody>
</table>


## Description

In order to facilitate a new text detection research, we introduce Total-Text dataset [(IJDAR)](http://cs-chan.com/doc/IJDAR2019.pdf)[(ICDAR-17 paper)](https://arxiv.org/abs/1710.10400) [(presentation slides)](http://cs-chan.com/doc/TT_Slide.pdf), which is more comprehensive than the existing text datasets. The Total-Text consists of 1555 images with more than 3 different text orientations: Horizontal, Multi-Oriented, and Curved, one of a kind.

<img src="ttstatistics.png" width="100%">
<img src="ICDAR17.gif" width="50%">

## Citation
If you find this dataset useful for your research, please cite
```
@article{CK2019,
  author    = {Chee Kheng Ch’ng and
               Chee Seng Chan and
               Chenglin Liu},
  title     = {Total-Text: Towards Orientation Robustness in Scene Text Detection},
  journal   = {International Journal on Document Analysis and Recognition (IJDAR)},
  volume    = {23},
  pages     = {31-52},
  year      = {2020},
  doi       = {10.1007/s10032-019-00334-z},
}
```

## Feedback
Suggestions and opinions of this dataset (both positive and negative) are greatly welcome. Please contact the authors by sending email to
`chngcheekheng at gmail.com` or `cs.chan at um.edu.my`.

## License and Copyright
The project is open source under BSD-3 license (see the ``` LICENSE ``` file).

For commercial purpose usage, please contact Dr. Chee Seng Chan at `cs.chan at um.edu.my`

&#169;2017-2020 Center of Image and Signal Processing, Faculty of Computer Science and Information Technology, University of Malaya.


