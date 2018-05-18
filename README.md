# Human-Emotion-Analysis-using-EEG-from-DEAP-dataset
Processed the DEAP dataset on basis of 
1) PSD (power spectral density) and 
2)DWT(discrete wavelet transform) features . 
Classifies the EEG ratings based on Arousl and Valence(high /Low)


The matlab files are to process the data feom EEG. (EEG dataset for matlab version)
Keep the matlab files in the DEAP dataset folder directly , where the data is.


Run the process.m to get the Power Spectral Density text files.

Each testFile generated contaians the 4 features- alpha, beta ,delta and theta wave power spectral density ratio(normalized by total psd), the output for valence , arousal and combined(valence+arousal) respectively. 1->low, 2->high

Run the dwt_feature_extraction.m to generate testfiles for dwt analysed wave.
It consists of 3 features : wavelet energy, wavelet entropy and standard deviation. along with the arousla and valce ratings.
Note that, here each wave has been divided into segments of 6 sec (thus 10 total segments)


the folders "psd analysis knn and svm" and "dwt analysis" already contain the processed textfiles and the python code to take in the traaining data from those testfiles and classify. Here
