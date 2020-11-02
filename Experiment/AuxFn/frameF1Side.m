function frameF1Side(col_cube,cube_sz,point_n)

cgalign('c','c'); 
[x,y,~,~,~,~,~,~] = define_cubes(point_n(1),point_n(2),cube_sz);
cgpencol([col_cube col_cube col_cube]);

coord = [];
coord(1,1) = x(5);
coord(2,1) = x(9);
coord(3,1) = x(3);
coord(4,1) = x(10);
coord(5,1) = x(8);
coord(6,1) = x(7);
coord(1,2) = y(5);
coord(2,2) = y(9);
coord(3,2) = y(3);
coord(4,2) = y(10);
coord(5,2) = y(8);
coord(6,2) = y(7);
cgpolygon(coord(:,1),coord(:,2))