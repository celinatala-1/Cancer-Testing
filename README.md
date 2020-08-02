# Cancer-Testing
This program helps pre-screen patients for risk of ovarian cancer. This is accomplished by utilizing linear discriminant analysis to build a linear classifier that can distinguish between data points of those belonging to patients with and without cancer. We utilize the data set spectra.mat, which contains the spectra count of different patients. The data is split into training and testing data, with the first 8000 samples being training and the last as testing. 

### Requirements
* The data set spectra.mat
* MatLab

### Implementation
Open `cancer_testing.m` in MatLab and run. 

### Code
The first step to creating this classifier is to calculate the within-class mean and between-class mean for the two classes (which is those with and without ovarian cancer). We do this because we want to minimize the within-class variance and maximize the betwee-class variance. This way after we project the data onto a one-dimensional linear space, those that belong to the same class will be together and far away from the other class. 

After doing the accurate calculations, we then compute the generalized eigenvectors to find the axis to which we must project our data. After obtaining the one-dimensional interpretation of our data, we iterate through 500 evenly spaced values to serve as our potential thresholds and calculate find the threshold that makes the maximum number of accurate predictions.

We found a threshold of -0.1115, with a success rate of 94.69%. Put into words, this means that our classifier identifies -0.1115 as the threshold between those with and without ovarian cancer, so having a lower spectra count thath -0.1115 may suggest you are at risk for cancer. The success rate of 94.69% means that 94.69% of our data set follows this threshold. 

### Output
We were able to find a relatively high success rate in setting a threshold with our training data. The Matlab program also outputs 4 figures, the histogram and ROC curve for both the training and testing data. The histogram visualizes the projection of our original data set onto one-dimensional linear space. The ROC curve visualizes the percentage of accuracy for all possible values using the threshold we set.

Histogram for Training Data
![Histogram_Train](Photos/Histogram_Training.png)

ROC Curve for Training Data
![ROC_Train](Photos/ROC_Training.png)

Histogram for Testing Data
![His_Test](Photos/Histogram_Testing.png)

ROC Curve for Testing Data
![ROC_Train](Photos/ROC_Testing.png)

