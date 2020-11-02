function frameCenterSide(col_cube,cube_sz,point_n)

cgalign('c','c'); 
[x,y,~,~,~,~,~,~] = define_cubes(point_n(1),point_n(2),cube_sz);
cgpencol([col_cube col_cube col_cube]);
cgrect(0,0,x(6)-x(9),y(6)-y(10))