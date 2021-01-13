
%%%%%%%%%%%%%%%%%%% face detection %%%%%%%%%%%%%%%%%%%%%%%

global count
location='classroom\*';
ds1=imageDatastore(location);

while hasdata(ds1)
    img=read(ds1);

    face_detector=vision.CascadeObjectDetector;
    face_detector.MergeThreshold=8;
    bounding_boxes=face_detector(img);

    face_img=insertObjectAnnotation(img,'rectangle',bounding_boxes,'Face','LineWidth',3);
    imshow(face_img);
    title(strcat("Classroom on day ",num2str(count)));

    cd('cropped_faces\');
    cnt=1;
    for i = 1 : size(bounding_boxes, 1) 
        J = imcrop(img, bounding_boxes(i, :));
        J=imresize(J,[112,92]);
        imwrite(J,strcat(num2str(cnt),'.pgm'));
        cnt=cnt+1;
    end
    cd ..;
    
    face_recognition;
    
    delete('cropped_faces\*');
    count=count+1;
end
