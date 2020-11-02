function saveBaseProtocol_directed(strName,WSs,WSe,SCs,SCe,...
    F1,F2,CsL,CeL,CsR,CeR)

tempName = pwd;
mkdir(strName); 
str_Direct_ = pwd; 
s=[str_Direct_ '\' strName '\']; cd(s);
fid = fopen('Base_records_protocol_directed.txt','w');

fprintf(fid,'%s\r\n',['Directed Attention  ' strName]);
fprintf(fid,'%s\r\n','');
fprintf(fid,'%s\r\n','');
        
fprintf(fid,'%s\n',['Start of white screen demonstration:  '...
    num2str(WSs)]);
fprintf(fid,'%s\r\n','');
fprintf(fid,'%s\n',['Finish of white screen demonstration:  '...
    num2str(WSe)]);
   
fprintf(fid,'%s\r\n','');
fprintf(fid,'%s\n',['Start of stationary cube demonstration:  '...
    num2str(SCs)]);
fprintf(fid,'%s\r\n','');
fprintf(fid,'%s\n',['Finish of stationary cube demonstration:  '...
    num2str(SCe)]);
    
fprintf(fid,'%s\r\n','');
fprintf(fid,'%s\n',['Blinking frequency (LEFT):  '...
    num2str(F1)]);

fprintf(fid,'%s\r\n','');
fprintf(fid,'%s\n',['Blinking frequency (RIGHT):  '...
    num2str(F2)]);
fprintf(fid,'%s\r\n','');

fprintf(fid,'%s\n',['Start of presentation of blinking cube (LEFT):  '...
    num2str(CsL)]);
fprintf(fid,'%s\r\n','');

fprintf(fid,'%s\n',['Finish of presentation of blinking cube (LEFT):  '...
    num2str(CeL)]);
fprintf(fid,'%s\r\n','');

fprintf(fid,'%s\n',['Start of presentation of blinking cube (RIGHT):  '...
    num2str(CsR)]);
fprintf(fid,'%s\r\n','');

fprintf(fid,'%s\n',['Finish of presentation of blinking cube (RIGHT):  '...
    num2str(CeR)]);
fprintf(fid,'%s\r\n','');
 
fclose(fid); 
cd(tempName)