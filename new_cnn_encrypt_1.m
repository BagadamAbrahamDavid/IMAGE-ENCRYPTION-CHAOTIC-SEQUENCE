clc
clear all
close all
cd images
[J,P]=uigetfile('*.*','select the source file');
cd ..
I=imread(strcat(P,J));
I=imresize(I,[128 128]);
figure,imshow(I);title('original Image');
%===== step 1======
[M,N,Z]=size(I);
G=double(reshape(I,[M,N*Z]));
P=double(I(:)');  
% first solve the 7-dmensional CNN with runge kutta method
[k1,k2,k3]=runge_solve;

u=4;a(1)=abs(k1);b(1)=abs(k2);c(1)=abs(k3);
for n=2:length(P)
    a(n)=(u*a(n-1)*(1-a(n-1)));
    b(n)=(u*b(n-1)*(1-b(n-1)));
    c(n)=(u*c(n-1)*(1-c(n-1)));
end
e=round(256*(0.166.*a+0.8.*b+0.03.*c));
e=reshape(e,[M,N]);
yim=0.01.*G+(1-0.01).*e;
figure,imshow(yim,[]);title('Encrypted Image');
%%% if same keys are used
gr=(yim-((1-0.01).*e))./0.01;
figure,imshow(gr,[]);title('Decrypted Image');
figure, subplot(311);imhist(uint8(G));title('original image histogram');
subplot(312);imhist(uint8(yim));title('Encrypted Image histogram');
subplot(313);imhist(uint8(mat2gray(gr).*256));title('Decrypted Image histogram');
 tmp=round(mat2gray(gr).*256);
% sm=sum(G(:)-yim(:))/sum(G(:)-tmp(:))
CC=corr2(G,tmp)
% if different keys are used
k3=k3+0.1;
u=4;a(1)=abs(k1);b(1)=abs(k2);c(1)=abs(k3);
for n=2:length(P)
    a(n)=(u*a(n-1)*(1-a(n-1)));
    b(n)=(u*b(n-1)*(1-b(n-1)));
    c(n)=(u*c(n-1)*(1-c(n-1)));
end
e=round(256*(0.166.*a+0.8.*b+0.03.*c));
e=reshape(e,[M,N]);
gr=(yim-((1-0.01).*e))./0.01;
figure,imshow(gr,[]);title('Decrypted Image with different key');


