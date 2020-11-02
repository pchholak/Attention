function saveBaseProtocol(strName,WSs,WSe,SCs,SCe,F1,Cs1,Ce1)

tempName = pwd;
mkdir(strName); 
str_Direct_ = pwd; 
s=[str_Direct_ '\' strName '\']; cd(s);
fid = fopen('Base_records_protocol.txt','w');

fprintf(fid,'%s\r\n',['Part 1  ' strName]);
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
fprintf(fid,'%s\n',['Blinking frequency:  '...
    num2str(F1)]);
    
fprintf(fid,'%s\r\n','');
fprintf(fid,'%s\n',['Start of presentation of blinking cube:  '...
    num2str(Cs1)]);
fprintf(fid,'%s\r\n','');
fprintf(fid,'%s\n',['Finish of presentation of blinking cube:  '...
    num2str(Ce1)]);
fprintf(fid,'%s\r\n','');
 
fclose(fid); 
cd(tempName)