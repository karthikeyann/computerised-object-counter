clc;
clear all;
t= 0:3999;
Fs=8000;
lower=0.05;
upper=0.100;
sound =   2*sin(2*pi*t*1000/Fs);
count=0;    %when you restart the program, reload the old value here
sel=0;

while(1)
y=wavrecord(1000,8000);
y=y(50:end,1)-mean(y(50:end,1));
power=sum(y.*y)
if(power<lower)
    sel=1;
else if(power > upper && sel==1)
        count=count+1;
        sel=0;
        %clc;
        str = [ '    No of Visitors  ==>  '  num2str(count)];
        disp(str);
        wavplay(sound,8000);   %makes abeep sound for 0.5 second
    end;
end;
end; %end while
