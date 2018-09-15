# Human-Emotion-Analysis-using-EEG-from-DEAP-dataset
Processed the DEAP dataset on basis of 
1) PSD (power spectral density) and 
2)DWT(discrete wavelet transform) features . 
Classifies the EEG ratings based on Arousal and Valence(high /Low)

Find the DEAP dataset here: (you  need to seek permission  by sending a mail to the authorized personell to download it)
http://www.eecs.qmul.ac.uk/mmv/datasets/deap/

The matlab files are there to process the data from EEG. (EEG dataset for matlab version)
Keep the matlab files in the DEAP dataset folder directly , where the data is.

Run the process.m to get the Power Spectral Density text files

Each testFile generated contains the 4 features- alpha, beta ,delta and theta wave power spectral density ratio(normalized by total psd), the output for valence , arousal and combined(valence+arousal) respectively. 1->low, 2->high

You can read about brain waves here (overview):
https://mentalhealthdaily.com/2014/04/15/5-types-of-brain-waves-frequencies-gamma-beta-alpha-theta-delta/

You can see the chart for arousal and valence states and their meanings here:
https://www.researchgate.net/figure/Arousal-valence-based-emotional-states_fig3_307587787

You will not get a good accuracy using psd features and KNN/SVM as they are mainly just a measure of human presence  of mind. 

DWT analysis helps us to get the time based features apart from frequency based psd. 

Run the dwt_feature_extraction.m to generate testfiles for dwt analysed wave.
It consists of 3 features : wavelet energy, wavelet entropy and standard deviation. along with the arousla and valce ratings.

Note that, here each wave has been divided into segments of 6 sec (thus 10 total segments)


the folders "psd analysis knn and svm" and "dwt analysis" already contain the processed textfiles and the python code to take in the training data from those testfiles and classify.
Run the ipynb files for classification with KNN and SVM.


References:

1.Kairui Guo, Henry Candra, Hairong Yu,Huiqi Li, Hung T. Nguyen and Steven W. Su,EEG-based Emotion Classification Using Innovative Features and Combined SVM and HMM Classifier. IEEE conference 2017
https://ieeexplore.ieee.org/document/8036868/

2.DEAP: A Database for Emotion Analysis using Physiological Signals -Sander Koelstra, Student Member, IEEE, Christian M¨uhl, Mohammad Soleymani, Student Member, IEEE,
Jong-Seok Lee, Member, IEEE, Ashkan Yazdani, Touradj Ebrahimi, Member, IEEE,
Thierry Pun, Member, IEEE, Anton Nijholt, Member, IEEE, Ioannis Patras, Member, IEEE
https://ieeexplore.ieee.org/document/5871728/

3.https://www.sciencedirect.com/science/article/pii/S0165027000003563


