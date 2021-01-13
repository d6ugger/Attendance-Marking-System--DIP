
global mltable

x=1;
cnt=0;

while x~=0
    cnt=cnt+1;
    filename=strcat('Attendance_record',num2str(cnt));
    filename=strcat(filename,'.xlsx');
    x=isfile(filename);  
end

filename=strcat('Attendance_record',num2str(cnt));
filename=strcat(filename,'.xlsx');

writetable(mltable,filename,'Sheet',1,'Range','D1');
