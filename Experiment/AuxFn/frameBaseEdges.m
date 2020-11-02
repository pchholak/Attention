function frameBaseEdges(col_cube,~,cube_sz,point_n)

cgalign('c','c'); 
[x,y,outline_1,outline_2,~,~,~,~] = define_cubes(point_n(1),point_n(2),cube_sz);
cgpencol([col_cube col_cube col_cube]);
cgdraw(x(outline_1),y(outline_1),x(outline_2),y(outline_2));