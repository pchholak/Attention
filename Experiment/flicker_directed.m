clear
cgshut

%% Given
Name = 'Test'; % Subject
SaveProtocol = true;
UseParallel = false;

% Cogent display settings
Fs = 60; 
X_PX = 1920; Y_PX = 1080; ks = Y_PX/X_PX;

% Cube dimensions
X0 = 0; Y0 = 0; 
CUBE_SIZE = fix(800*ks); 
LINE_W = fix(10*ks); 
R_point = 10; 
Xpnt = 0; Ypnt = 0; 

% Stimulation 
freq = [60/9; 60/7];
nrep = 12;
freq_dem = repmat(freq, 1, nrep);
fr1 = freq_dem(1,:); fr2 = freq_dem(2,:);
N = length(fr1);
base_int = 0.25;        
change_int = 0.25;      % base_int + change_int*sine_mod(t)

% Times 
time_cube = 5; % Time of the trial time series
time_p = 5; % Time between subsequent cube demonstrations
time_rest = 30; % Time between subsequent cube orientations
time_stat_cube = 120; % Time for stationary cube demonstration  
time_message = 10; % Time to show messages

%% Initialize Cogent and add AuxFn to path
cgloadlib
cgvers
cogstd('spriority','high')
home = pwd; aux_path = [pwd '\AuxFn\'];
addpath(aux_path)

%% Initialize Parallel port configuration (if true)
trig11 = 80; % Start trial of flickering cube (left)
trig12 = 90; % End trial of flickering cube (left)
trig21 = 60; % Start trial of flickering cube (right)
trig22 = 70; % End trial of flickering cube (right)
trig01 = 11;  % Start recording stat. cube marker
trig02 = 12;  % End recording stat. cube marker
if UseParallel==true  
    parall_port = digitalio('parallel','LPT1');
    addline(parall_port,0:7,'out');
end

%% ======================= Empty arrays predefined ========================
white_src_start = [];
white_src_end = [];
state_cube_start = [];
state_cube_end = [];
freqL = [];
freqR = [];
cube_startL = [];
cube_endL = [];
cube_startR = [];
cube_endR = [];

%% ========================== Stationary cube =============================
cgopen(X_PX,Y_PX,0,0,0)
Message1(ks*3,time_message)
cgflip([0 0 0]);

cgpencol(base_int,base_int,base_int);
cgrect(0,0,X_PX,Y_PX) 

frameCenterSide(base_int,CUBE_SIZE,[X0,Y0])  
frameF1Side(base_int,CUBE_SIZE,[X0,Y0])
frameF2Side(base_int,CUBE_SIZE,[X0,Y0])
frameStateSide(base_int,CUBE_SIZE,[X0,Y0])

frameRightEdges(1,LINE_W,CUBE_SIZE,[X0,Y0]);
frameLeftEdges(1,LINE_W,CUBE_SIZE,[X0,Y0]);
frameBaseEdges(1,LINE_W,CUBE_SIZE,[X0,Y0]);

cgpencol([1 0 0])
cgellipse(Xpnt,Ypnt,R_point,R_point,'f') 

state_cube_start = [state_cube_start getTimeSec]; % Clock start
if UseParallel==true  
    putvalue(parall_port,trig01);
end
cgflip 
pause(time_stat_cube)
if UseParallel==true  
    putvalue(parall_port,trig02);
end
state_cube_end = [state_cube_end getTimeSec]; % Clock end

%% Rest
cgpencol(base_int,base_int,base_int);
cgrect(0,0,X_PX,Y_PX) 
white_src_start = [white_src_start getTimeSec];
cgflip([0 0 0])
pause(time_rest)
white_src_end = [white_src_end getTimeSec];

%% ======== Demonstartion of cube with two blinking faces (LEFT) ==========
MessageL(ks*3,time_message)
cgflip([0 0 0])
for q=1:N
    f1 = fr1(q);
    f2 = fr2(q);
    
    t = 1/Fs:1/Fs:time_cube;
        
    colour1_t=base_int+change_int*sin(2*pi*f1*t);
    colour2_t=base_int+change_int*sin(2*pi*f2*t);
    
    freqL = [freqL f1];
    freqR = [freqR f2];
    
    cube_startL = [cube_startL getTimeSec]; % Clock start
    if UseParallel==true  
        putvalue(parall_port,trig11); % TRIGGER 80
    end
    for i=1:length(t)
        cgpencol(base_int,base_int,base_int);
        cgrect(0,0,X_PX,Y_PX) 
       
        frameCenterSide((colour1_t(i)+colour2_t(i))/2,CUBE_SIZE,[X0,Y0])  
        frameF1Side(colour1_t(i),CUBE_SIZE,[X0,Y0])
        frameF2Side(colour2_t(i),CUBE_SIZE,[X0,Y0])
        frameStateSide(base_int,CUBE_SIZE,[X0,Y0])

        frameRightEdges(1,LINE_W,CUBE_SIZE,[X0,Y0]);
        frameLeftEdges(1,LINE_W,CUBE_SIZE,[X0,Y0]);
        frameBaseEdges(1,LINE_W,CUBE_SIZE,[X0,Y0]);

        cgpencol([1 0 0])
        cgellipse(Xpnt,Ypnt,R_point,R_point,'f') 
    
        cgflip 
    end
    if UseParallel==true  
        putvalue(parall_port,trig12); % TRIGGER 90
    end
    cube_endL = [cube_endL getTimeSec]; % Clock end
    
    white_src_start = [white_src_start getTimeSec];
    cgpencol(base_int,base_int,base_int);
    cgrect(0,0,X_PX,Y_PX) 
    cgflip([0 0 0])
    pause(time_p)
    white_src_end = [white_src_end getTimeSec];
end

%% Rest
cgpencol(base_int,base_int,base_int);
cgrect(0,0,X_PX,Y_PX) 
white_src_start = [white_src_start getTimeSec];
cgflip([0 0 0])
pause(time_rest)
white_src_end = [white_src_end getTimeSec];

%% ======== Demonstartion of cube with two blinking faces (LEFT) ==========
MessageR(ks*3,time_message)
cgflip([0 0 0])
for q=1:N
    f1 = fr1(q);
    f2 = fr2(q);
    
    t = 1/Fs:1/Fs:time_cube;
        
    colour1_t=base_int+change_int*sin(2*pi*f1*t);
    colour2_t=base_int+change_int*sin(2*pi*f2*t);
    
    freqL = [freqL f1];
    freqR = [freqR f2];
    
    cube_startR = [cube_startR getTimeSec]; % Clock start
    if UseParallel==true  
        putvalue(parall_port,trig21); % TRIGGER 60
    end
    for i=1:length(t)
        cgpencol(base_int,base_int,base_int);
        cgrect(0,0,X_PX,Y_PX) 
       
        frameCenterSide((colour1_t(i)+colour2_t(i))/2,CUBE_SIZE,[X0,Y0])  
        frameF1Side(colour1_t(i),CUBE_SIZE,[X0,Y0])
        frameF2Side(colour2_t(i),CUBE_SIZE,[X0,Y0])
        frameStateSide(base_int,CUBE_SIZE,[X0,Y0])

        frameRightEdges(1,LINE_W,CUBE_SIZE,[X0,Y0]);
        frameLeftEdges(1,LINE_W,CUBE_SIZE,[X0,Y0]);
        frameBaseEdges(1,LINE_W,CUBE_SIZE,[X0,Y0]);

        cgpencol([1 0 0])
        cgellipse(Xpnt,Ypnt,R_point,R_point,'f') 
    
        cgflip 
    end
    if UseParallel==true  
        putvalue(parall_port,trig22); % TRIGGER 70
    end
    cube_endR = [cube_endR getTimeSec]; % Clock end
    
    white_src_start = [white_src_start getTimeSec];
    cgpencol(base_int,base_int,base_int);
    cgrect(0,0,X_PX,Y_PX) 
    cgflip([0 0 0])
    pause(time_p)
    white_src_end = [white_src_end getTimeSec];
end

cgshut
 
%% ======================== Save-Base-Protocol ============================
if SaveProtocol==true

C = clock;  Dstr = date;
strName = [Name '_' Dstr '_' num2str(C(4)) 'h_' ...
    num2str(C(5)) 'm_' num2str(C(6)) 's'];

saveBaseProtocol_directed(strName,white_src_start,white_src_end,...
    state_cube_start,state_cube_end,fr1,fr2,cube_startL,cube_endL,...
    cube_startR,cube_endR)

end