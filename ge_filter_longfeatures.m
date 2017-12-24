clc;clear;close;

%GE filter parameters
theta = 0:pi/12:pi;
gamma = 0.5;
lambda = 2;
sigma = 0.56*lambda;
m = floor(sigma);
%GE filter equation
for t = 1:size(theta,2)
    for x = -m:m
            for y = -m:m
                x1 = x*cos(theta(t)) + y*sin(theta(t));
                y1 = -x*sin(theta(t)) + y*cos(theta(t));
                g(m+x+1, m+y+1) = (gamma/(2*pi*sigma^2))*exp(-(x1^2 + (gamma^2)*y1^2)/(2*sigma^2))*cos(2*pi*x1/lambda);
            end
    end
    g_new(:,:,t) = g;
end
src = 'E:\OneDrive - Arizona State University\MS\TFSP\Project\Cohn Kahnade dataset\cohn-kanade-images\';
j=1;
E_final = [];
for k=3:length(dir(src))
    E = [];
    srcFiles = dir(strcat(src, 'S', num2str(k-2), '\surprise_new\*.png'));
    if(isempty(srcFiles))
%         xlRange = strcat(xlRange1, num2str(k-2));
%         xlswrite(file,E, sheet, xlRange);
        continue;
    end
    I_1=zeros(96, 96, length(srcFiles));
    I=zeros(96, 96, length(srcFiles));
    for i = 1 : length(srcFiles)
        filename = strcat(src, 'S', num2str(k-2), '\surprise_new\', srcFiles(i).name);
        p = imread(filename);
        I(:,:,i) = p;
        %figure, imshow(I);
    end

    for t = 1:size(theta,2)
        c = 0;
        for i = 1 : length(srcFiles)
            I_1(:,:,i) = sqrt(2)*conv2(I(:,:,i), g_new(:,:,t), 'same');
            c = c + I_1(:,:,i).^2;
            %figure, imshow(I_1(:,:,i));
        end
        
        E = [E;c(:)];
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
save('surprise_ge_E_final_a.mat','E_final', 'a');


% for k=1:length(src)
%        srcFiles = strcat(src, 'S', num2str(k))
% end