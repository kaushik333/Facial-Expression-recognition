# Facial-Expression-recognition
Facial Expression recognition using Spatio-temporal Gabor filters

The Cohn-Kanade dataset is used to test out the algorithm proposed. It is a dataset consisting of videos of facial expressions of different people
for different expressions. 

viola_jones_(happy/sad/surprise).m are just 3 matlab files of the same implementations with different paths to different folders for face recognition. 
They perform face recognition and return a 96x96 cropped version version of only the face. This is then used to extract features using the 
Gabor filters. 

ge_filter_longfeatures.m is used to extract the Gabor features from the videos in the dataset. 
stge_filter_longfeatures.m used to extract the Spatio-temporal Gabor features from the videos in the dataset. 
stge_filter_vel_longfeatures.m used to extract the Spatio-temporal Gabor features with velocity tuning from the videos in the dataset. 

svm_perform.m is used to perform svm classification on the 3 classes of expressions i.e. happy, sad and surprise. Finally, the trained model is stored
as a .mat file. The in-built cross-validation accuracy function of Matlab is used to test the efficacy of the algorithm.

Face expression recognition.pdf is the main paper that is referred. The other two papers are used as reference for the equations for the gabor 
filters which is used to code them in matlab. 
