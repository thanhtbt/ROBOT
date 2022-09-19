# ROBOT: A Robust Online Algorithm for Tensor Tracking With Missing Data Under Tensor-Train Format

Robust tensor tracking or robust adaptive tensor decomposition of streaming tensors is crucial when observations are corrupted by sparse outliers and missing data. In this paper, we introduce a novel tensor tracking algorithm for factorizing incomplete streaming tensors with sparse outliers under tensortrain (TT) format, called ROBOT. The proposed algorithm consists of two main stages: online outlier rejection and tracking of TT-cores. In the former stage, outliers affecting the data streams are efficiently
detected by an ADMM solver. In the latter stage, we propose an effective recursive least-squares solver to incrementally update TT-cores at each time t. Several numerical experiments on both simulated and real data are presented to verify the effectiveness of the proposed algorithm.

## Dependencies 
+ Our MATLAB code requires the [Tensor Toolbox](http://www.tensortoolbox.org/) which is already attached to this repository.
+ MATLAB 2019a

## Demo
+ Run demo_xyz.m for synthetic data

## Some Results

+ Effect of the noise level
![NOISE](https://user-images.githubusercontent.com/26319211/175334813-1c56b84d-06a8-4b47-b472-9df6faeee86f.PNG)

+ Effect of the time-varying factor
![TIME-VARYING](https://user-images.githubusercontent.com/26319211/175335112-34940dfb-6134-4669-aba9-d9e4b8249f6d.PNG)

+ Effect of the missing data
![MISSING](https://user-images.githubusercontent.com/26319211/175335183-3f247e69-fbf0-4bed-8def-558f7592fe64.PNG)

+ Effect of sparse outliers
![outlier](https://user-images.githubusercontent.com/26319211/175335240-8c75b4fc-07ef-4f2d-a294-6615cd708ea0.PNG)


## Reference

This code is free and open source for research purposes. If you use this code, please acknowledge the following paper.

[1] L.T. Thanh, K. Abed-Meraim, N.L. Trung, A. Hafiance. "[*Robust Tensor Tracking With Missing Data Under Tensor-Train Formats*](https://drive.google.com/file/d/1HgngRD2d_7yYxxP_unwK7wHJNec3vaxY/v)". **Proc. 30th EUSIPCO**, 2022. [[PDF](https://drive.google.com/file/d/1HgngRD2d_7yYxxP_unwK7wHJNec3vaxY/view)].
