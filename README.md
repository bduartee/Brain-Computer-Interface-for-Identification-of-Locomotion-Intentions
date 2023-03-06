# Brain-Computer-Interface-for-Identification-of-Locomotion-Intentions

A brain-computer interface, commonly known as BCI, allows communication between the brain and the computer/machine, using signals collected through electroencephalography (EEG). 

![image](https://user-images.githubusercontent.com/94623508/223188247-e83bbd7d-7c74-4982-a04e-ea1b5278ae87.png)

Acquiring these locomotion data requires some signal processing to eliminate artifacts and noise, and adjust frequencies, followed by data preparation to enable feature extraction, which are characteristics that allow the recognition of patterns, both in time and in frequency. Finally, it is possible to create a classifier, based on an SVM that, at the time of classification, will be able, with the help of different features, to detect locomotion patterns.

The experimental stage allowed obtaining ten distinct EEG signals referring to different displacements, designated by datasets, which must then be treated in order to
obtain a cleaner and more reliable signal for the classification. For this signal processing, the EEGLAB toolbox available in Matlab was used.

![image](https://user-images.githubusercontent.com/94623508/223187049-c9649ce3-2818-4bf1-8c1b-8187078df4c4.png)

The results are:

![image](https://user-images.githubusercontent.com/94623508/223186728-1147ccd8-59d6-49f6-8df4-457806af3cc8.png)
