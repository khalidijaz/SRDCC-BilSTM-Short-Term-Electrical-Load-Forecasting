# SRDCC-BilSTM-Short-Term-Electrical-Load-Forecasting
This project presents a novel Short Receptive Field based Dilated Causal
Convolutional Network Integrated with Bidirectional LSTM (SRDCC-BiLSTM) for Short-term electrical load forecasting. The presented model is compared with various statistical,machine learning and deep learning methods.
This repository contains the codes related to this project

Download the ZIP folder from Github repository and extract it.
# For Jupter Notebook Files:
1. Place the extracted folder in the directory of Jupyter notebook.
2. After accessing the Jupyter interface, click on the extracted folder
3. After accessing the folder, five sub-folders will be found. The “Data” folder consists of Electrical Load Dataset.
4. Choose the desired "Multi-step DL Models" OR "Single-Step DL Models" to excute/run for forecasting purpose.
5. Choose the relevant algorithm's folder and open the FILES (.ipynb) present in that folder.
6. Run the program
7. Accuracy / Error results are also presented in Jupyter files.

# For MATLAB Files:
1. Open MATLAB program
2. Choose the desired model from "Machine Learning Models" OR "Statistical Models" to excute/run for forecasting purpose.
3. Choose the relevant algorithm's folder and open/import ALL the FILES (.m and .mat) present in that folder.
4. RUN the program
5. Accuracy / Error results of that algorithm will be displayed

# Citation
If you find the codes useful in your research, please consider citing:

@article{JAVED2022117689,
title = {A novel short receptive field based dilated causal convolutional network integrated with Bidirectional LSTM for short-term load forecasting},
journal = {Expert Systems with Applications},
volume = {205},
pages = {117689},
year = {2022},
issn = {0957-4174},
doi = {https://doi.org/10.1016/j.eswa.2022.117689},
url = {https://www.sciencedirect.com/science/article/pii/S0957417422009848},
author = {Umar Javed and Khalid Ijaz and Muhammad Jawad and Ikramullah Khosa and Ejaz {Ahmad Ansari} and Khurram {Shabih Zaidi} and Muhammad {Nadeem Rafiq} and Noman Shabbir},
keywords = {Data analysis, Load forecasting, Learning (artificial intelligence), Machine learning, Power engineering computing, Time series analysis},
abstract = {The Short-Term Load Forecasting (STLF) is a pre-eminent task for reliable power generation and electrical load dispatching in the power system. Numerous machine-learning and deep-learning forecasting algorithms have been presented in literature for performing an accurate electrical load forecast. However, the complicated structure of machine-learning and deep-learning multi-layer and with increased filter size architectures provoke the overfitting issue, which degrades the performance of STLF engines in the presence of highly diversified weather and temporal variations. This paper proposes a novel two-stage Encoder-Decoder (ED) network with improved generalization capability and forecasting accuracy. The proposed architecture is based on Short Receptive field based Dilated Causal Convolutional (SRDCC) network in the first stage and Bi-directional Long Short-Term Memory (BiLSTM) network in the second stage. Using real valued data, the proposed ED architecture is quantitatively and qualitatively analyzed in comparison with state-of-the-art machine-learning and hybrid deep-learning STLF models. The evaluation matrix used for the comparison consists of six evaluation parameters. The extensive experimentation for multi-step ahead STLF validates the efficiency of the proposed technique in terms of accuracy in comparison with other employed models. The CNN-LSTM revealed to have best performance among all other implemented parametric and non-parametric forecasting models; however, the proposed ED architecture proves to be 35% more accurate compared to CNN-LSTM and have the tendency to capture the local trends in an electrical load pattern more accurately. Moreover, a detailed comparative analysis on the computational complexity of the proposed ED architecture is also conducted to show the real implementation prospect.}
}


