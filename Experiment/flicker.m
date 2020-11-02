clear
cgshut

%% Given
Name = 'Test'; % Subject
SaveProtocol = false;
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
freq = 60/9;
nrep = 3;
freq_dem = repmat(freq, 1, nrep);
N = length(freq_dem);
base_int = 0.25;        
change_int = 0.25;      % base_int + change_int*sine_mod(t)

% Times 
time_cube = 10; % Time of the trial time series
time_p = 5; % Time between subsequent cube demonstrations
time_stat_cube = 10; % Time for stationary cube demonstration  
time_message = 10; % Time to show messages

%% Initialize Cogent and add AuxFn to path
cgloadlib
cgvers
cogstd('spriority','high')
home = pwd; aux_path = [pwd '\AuxFn\'];
addpath(aux_path)

%% Initialize Parallel port configuration (if true)
trig11 = 80; % Start trial of flickering cube
trig12 = 90; % End trial of flickering cube
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
freq1 = [];
cube_start1 = [];
cube_end1 = [];

%% ========================== Stationary cube =============================
cgopen(X_PX,Y_PX,0,0,0)
cgflip([0 0 0]);

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

%% ============ Demonstartion of cube with one blinking face ==============
Message2(ks*3,time_message)
cgflip([0 0 0]);

for j = 1:N
    f = freq_dem(j);

    t = 1/Fs:1/Fs:time_cube;
    colour_t = base_int + change_int*sin(2*pi*f*t);
    
    freq1 = [freq1 f];
    cube_start1 = [cube_start1 getTimeSec];
    if UseParallel==true  
        putvalue(parall_port,trig11);
    end
    for i=1:length(t)
        cgpencol(base_int,base_int,base_int);
        cgrect(0,0,X_PX,Y_PX) 
       
        frameCenterSide(colour_t(i),CUBE_SIZE,[X0,Y0])  
        frameF1Side(colour_t(i),CUBE_SIZE,[X0,Y0])
        frameF2Side(base_int,CUBE_SIZE,[X0,Y0])
        frameStateSide(base_int,CUBE_SIZE,[X0,Y0])

        frameRightEdges(1,LINE_W,CUBE_SIZE,[X0,Y0]);
        frameLeftEdges(1,LINE_W,CUBE_SIZE,[X0,Y0]);
        frameBaseEdges(1,LINE_W,CUBE_SIZE,[X0,Y0]);

        cgpencol([1 0 0])
        cgellipse(Xpnt,Ypnt,R_point,R_point,'f') 
    
        cgflip 
    end 
    if UseParallel==true  
        putvalue(parall_port,trig12);
    end
    cube_end1 = [cube_end1 getTimeSec];

    cgpencol(base_int,base_int,base_int);
    cgrect(0,0,X_PX,Y_PX) 
    white_src_start = [white_src_start getTimeSec];
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

saveBaseProtocol(strName,white_src_start,white_src_end,...
    state_cube_start,state_cube_end,freq1,cube_start1,cube_end1)

end