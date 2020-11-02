
function saveData(v,nameV,strName,str_Title)
if isempty(v)==0
tempName = cd;

str_Direct_ = cd; 
s=[str_Direct_ '\' strName '\']; cd(s);
fid = fopen([nameV '.txt'],'w');
fprintf(fid,'%s\r\n',str_Title); 
str_f_pr = []; str_lex = ' %12.5f\r\n '; for i=1:length(v),  str_f_pr = [str_f_pr str_lex]; end;
fprintf(fid, str_f_pr, v);
fclose(fid); 
eval ([nameV '=v;']); % redefinition of the variable name and mat-file name to have the same name  
eval (['save ' nameV ' ' nameV ';']);
cd(tempName);
end

