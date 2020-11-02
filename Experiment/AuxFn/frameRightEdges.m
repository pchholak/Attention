function frameRightEdges(col_face_i,line_wd,cube_sz,point_n)

cgalign('c','c'); 
[x,y,~,~,~,~,face2_1,face2_2] = define_cubes(point_n(1),point_n(2),cube_sz);
cgpenwid(line_wd);

cgpencol([col_face_i col_face_i col_face_i]);
cgdraw(x(face2_1),y(face2_1),x(face2_2),y(face2_2));