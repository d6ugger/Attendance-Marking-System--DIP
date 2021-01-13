Instructions:

Run Auto_Attend.mlapp

Step1: Load Database
Step2: Create Attendance Record (it takes some seconds)
Step3: Save
Step4: Get Record

Brief:
New snapshots (test data) are stored under 'classroom' folder.
For recognition, trained feature set (by PCA algorithm) is stored under s1,s2, s3, s4 folders for each student.
Preprocessed (i.e. extracted, grayscaled and then, cropped) images for single day attendance are buffered in 'cropped_faces' folder temporarily and then auto-deleted.

'main.m' script calls 'face_detection.m' script which further calls 'face_recognition.m' script in loop for different days attendance. 
