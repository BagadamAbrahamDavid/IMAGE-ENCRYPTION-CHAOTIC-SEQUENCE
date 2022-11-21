function [key1,key2,key3]=runge_solve();
x=[0.1:0.1:0.7];
x(1)=-x(3)-x(4);
x(2)=2*x(2)+x(3);
x(3)=14*x(1)-14*x(2);
fx4=1/2*(abs(x(4)+1)-(x(4)+1));
x(4)=90*x(1)-95*x(4)-200*fx4;
x(5)=18*x(2)-x(5)+x(1);
x(6)=4*x(5)-4*x(6)+100*x(2);
x(7)=6*x(1)+8*x(3)+17*x(4)-21.5*x(5);

k=randi([1 7],1,3);
rand('state',x(k(1)));
key1=rand(1,1);
rand('state',x(k(2)));
key2=rand(1,1);
rand('state',x(k(3)));
key3=rand(1,1);
