# Statistical Shape Analysis of Elastic Graphs

<p align="center">
<img src="/readme/geodesic_BAN_top_sparse.gif" align="middle" width="400">
</p>

This repository contains code to statistically analyze elastic graphical shapes.

## Get Started

`demo2DMatching.m`

`demo2DEGStatisticalAnalysis.m`

Please also read `doc\elastic_graph_data_structure.pdf` to understand the EG data structure. 

## Brain Artery Data

The orignal data could be downloaded [here](https://projecteuclid.org/journals/annals-of-applied-statistics/volume-10/issue-1/Persistent-homology-analysis-of-brain-artery-trees/10.1214/15-AOAS886.full?tab=ArticleLinkSupplemental). The data is stored in point cloud. We converted it into EG format and cut it into four components: top, bottom, left, right as mentioned in the paper. The processed data could be downloaded [here](https://www.dropbox.com/s/kx5v4com9chtcac/BAN.zip?dl=0).

`demoBAN.m`

## Reference
```
@inproceedings{guo2020representations,
  title={Representations, metrics and statistics for shape analysis of elastic graphs},
  author={Guo, Xiaoyang and Srivastava, Anuj},
  booktitle={Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition Workshops},
  pages={832--833},
  year={2020}
}

@article{guo2020statistical,
  title={Statistical shape analysis of brain arterial networks (BAN)},
  author={Guo, Xiaoyang and Bal, Aditi Basu and Needham, Tom and Srivastava, Anuj},
  journal={arXiv preprint arXiv:2007.04793},
  year={2020}
}
```
