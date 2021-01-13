clear all
clc
close all

cd('classroom\');
img=imread('5.jpg');
img=imrotate(img,-90,'bilinear');
imwrite(img,'5.jpg');
cd ..;

location='s2\*';
ds=imageDatastore(location);

face_detector=vision.CascadeObjectDetector;
face_detector.MergeThreshold=7;

cnt=1;
cd('s2\');

while hasdata(ds)
    img=read(ds);
    [M,N]=size(img);
    
    if M<N
        img=imrotate(img,-90,'bilinear');
    end
    
    if M~=112 && N~=92
        img=imresize(img,[112,92]);
    end
    
    bounding_boxes=face_detector(img);
    face_img=insertObjectAnnotation(img,'rectangle',bounding_boxes,'Face','LineWidth',3);
    
    if ~isempty(bounding_boxes)
        for i = 1 : size(bounding_boxes, 1) 
            J = imcrop(img, bounding_boxes(i, :));
            J=imresize(J,[112,92]);
            imwrite(J,strcat(num2str(cnt),'.pgm'));
            figure,imshow(J);
            cnt=cnt+1;
        end
    else
        cnt=cnt+1;
    end
    
end
cd ..