%%  =================   Marks of flickering cube demo  ====================
UseParallel = true;
trig11 = 80; % Start trial of flickering cube
trig12 = 90; % End trial of flickering cube
trig01 = 11;  % Start recording stat. cube marker
trig02 = 12;  % End recording stat. cube marker

if UseParallel==true  
    parall_port = digitalio('parallel','LPT1');
    addline(parall_port,0:7,'out');
end    

putvalue(parall_port,trig01);