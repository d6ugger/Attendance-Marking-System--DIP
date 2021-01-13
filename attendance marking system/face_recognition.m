
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% face recognition %%%%%%%%%%%%%%%%%%%%%%%%%%%

Attendance=[0;0;0;0];
global mltable
global count
global img_database

K=20; % total number of eigenfaces for each image

%% computing the average face vector

temp_matrix=uint8(ones(1,size(img_database,2)));
avg_face=uint8(mean(img_database,2));
average=uint8(single(avg_face)*single(temp_matrix));
A=img_database-average;  % average face vector of all images

%% computing the eigenvectors and eigenvalues to get eigenfaces

% using linear algebra we know that covariance matrix C'=AAt but as N^2>>>M
% calculating eigenvectors for C would not be computionally efficient so we
% instead compute C=AtA and then map the eigenvectors from C to C'

AtA=single(transpose(A))*single(A); 
[V,D]=eig(AtA); % V-matrix of eigenvectors of C
U=single(A)*V; %mapping back to C'
U=U(:,end:-1:end-(K-1));
img_eigenfaces=zeros(size(img_database,2),K);

for i=1:size(img_database,2)
    img_eigenfaces(i,:)=single(A(:,i)).'*U;  
end

%% testing the algorithm
location='cropped_faces\*.pgm';
ds=imageDatastore(location);

% getting the image to be recognized
while hasdata(ds)
    unknown_img=read(ds);
    unknown_img=reshape(unknown_img,10304,1);
    %img_database=img_database(:,[1:ind-1 ind+1:end]);

    %computing the eigenface of the unknown image
    centered_face=unknown_img-avg_face;
    eigenface=single(centered_face).'*U;
    distance=[];

    %%computing the "distance" of every image from the unknown image using
    %matrix 2-norm
    for i=1:size(img_database,2)
        distance=[distance,double(norm(img_eigenfaces(i,:)-eigenface,2))];
    end

    [img,ind]=min(distance); %getting the min distance i.e the image which is similar to the unknown image
    
    if ind>=1 && ind<=10
        Attendance(3,:)=1;
    else if ind>10 && ind<=20
            Attendance(1,:)=1;
        else if ind>20 && ind<=30
                Attendance(4,:)=1
            else 
                Attendance(2,:)=1;
            end
        end
    end
end

if count==1
    mltable.Monday=Attendance;
else if count==2
        mltable.Tuesday=Attendance;
    else if count==3
            mltable.Wednesday=Attendance;
        else if count==4
                mltable.Thursday=Attendance;
            else if count==5
                    mltable.Friday=Attendance;
                end
            end
        end
    end
end

