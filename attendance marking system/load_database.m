%% loading the database of images
global img_database

img_database=load_dataset();

function image_database=load_dataset()
img_dataset=zeros(10304,40);
for i=1:4
        cd(strcat('s',num2str(i)));
        for j=1:10
            image=imread(strcat(num2str(j),'.pgm'));
            img_dataset(:,(i-1)*10+j)=reshape(image,size(image,1)*size(image,2),1);
        end
        cd ..
end
image_database=uint8(img_dataset);
end