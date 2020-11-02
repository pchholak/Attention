function [x,y,outline_1,outline_2,face1_1,face1_2,face2_1,face2_2]=define_cubes(X0,Y0,CUBE_SIZE)

% Author: Juan García-Prieto juangpc@gmail.com

%%debug
% X0=0;
% Y0=0;
% CUBE_SIZE=220;
% LINE_W=10;
% 

x=zeros(1,8);%zeros(1,10)
y=zeros(1,8);%zeros(1,10)

x(1)=X0-CUBE_SIZE/5;
x(2)=X0+CUBE_SIZE*4/5;
x(3)=x(1);
x(4)=x(2);
x(5)=X0-CUBE_SIZE*4/5;
x(6)=X0+CUBE_SIZE/5;
x(7)=x(5);
x(8)=x(6);
x(9)=x(1);
x(10)=x(6);

y(1)=Y0+CUBE_SIZE*4/5;
y(2)=y(1);
y(3)=Y0-CUBE_SIZE/5;
y(4)=y(3);
y(5)=Y0+CUBE_SIZE/5;
y(6)=y(5);
y(7)=Y0-CUBE_SIZE*4/5;
y(8)=y(7);
y(9)=y(5);
y(10)=y(3);

outline_1=[1 1 2 4 7 5];
outline_2=[2 5 4 8 8 7];

face1_1=[3 3 3];
face1_2=[1 4 7];

face2_1=[6 6 6];
face2_2=[2 5 8];

end



























