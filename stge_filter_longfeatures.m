clc;clear;close;

%GE filter parameters
theta = 0:pi/12:pi;
%g = size(5,5);
gamma = 0.5;
lambda = 2;
sigma = 0.56*lambda;
m = floor(sigma);
%m = 96;
tau = 2.75;
ut = 1.75;  

%STGE filter equation

src = 'E:\OneDrive - Arizona State University\MS\TFSP\Project\Cohn Kahnade dataset\cohn-kanade-images\';
j=1;
E_final = [];
for k=3:length(dir(src))
    %E = zeros(1, size(theta,2));
    E=[];
    srcFiles = dir(strcat(src, 'S', num2str(k-2), '\surprise_new\*.png'));
    if(isempty(srcFiles))
%         xlRange = strcat(xlRange1, num2str(k-2));
%         xlswrite(file,E, sheet, xlRange);
        disp(strcat('Done with', ' S', num2str(k-2)));
        continue;
    end
    I_1=zeros(96, 96, length(srcFiles));
    I=zeros(96, 96, length(srcFiles));
    for i = 1 : length(srcFiles)
        filename = strcat(src, 'S', num2str(k-2), '\surprise_new\', num2str(i), '.png');
        I(:,:,i) = imread(filename);
    end
    
    time = 0:0.04:0.04*(length(srcFiles)-1);
    g_new1 = zeros(length(-m:m), length(-m:m), length(time));
    g_new = zeros(length(-m:m), length(-m:m), length(time), size(theta,2));
    for th = 1:size(theta,2)
        for t=1:length(time)
            for x = -m:m
                for y = -m:m
                    x1 = x*cos(theta(th)) + y*sin(theta(th));
                    y1 = -x*sin(theta(th)) + y*cos(theta(th));
                    g(m+x+1, m+y+1) = (gamma/(2*pi*sigma^2))*exp(-(x1^2 + (gamma^2)*y1^2)/(2*sigma^2))*cos(2*pi*x1/lambda)...
                        *(1/sqrt(2*pi*tau))*exp(-(time(t)-ut)/(2*(tau^2)));                   
                end
            end
            g_new1(:,:,t) = g;
        end
        g_new(:,:,:,th) = g_new1;
    end
    %E = zeros(size(theta));   
    for th = 1:size(theta,2)
        c=0;
        for i = 1 : length(srcFiles)
            I_1(:,:,i) = sqrt(2)*conv2(I(:,:,i), g_new(:,:,i,th), 'same');
            %figure, imshow(I_1(:,:,i));
            %E(th) = E(th) + sum(sum(I_1(:,:,i).^2));
            c = c + I_1(:,:,i).^2;
            
        end
        E = [E;c(:)];
        %E(th) = sum(sum(I_1(:,:,i).^2));
    end
    %I=0; I_1=0;
    E_final = [E_final;E'];
    disp(strcat('Done with', ' S', num2str(k-2)));
    j = j + 1;
end
a = [];
for i=1:size(E_final,1)
    a = [a;'surprise'];
end
save('surprise_stge.mat','E_final', 'a');

