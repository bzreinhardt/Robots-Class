function[dataStore] = sonarPredictTest(CreatePort,SonarPort,BeaconPort,tagNum,maxTime)
% ODOMTEST: commands robot to drive in a curve until it hits a wall, then
% back up, turn 30 degrees and continue
% 
%   dataStore = odomTest(CreatePort,SonarPort,BeaconPort,tagNum,maxTime) 
% 
%   INPUTS
%       CreatePort  Create port object (get from running RoombaInit)
%       SonarPort   Sonar port object (get from running RoombaInit)
%       BeaconPort  Camera port object (get from running RoombaInit)
%       tagNum      robot number for overhead localization
%       maxTime     max time to run program (in seconds)
% 
%   OUTPUTS
%       dataStore   struct containing logged data

% 
%   NOTE: Assume differential-drive robot whose wheels turn at a constant 
%         rate between sensor readings.
% 
%   Cornell University
%   MAE 5180: Autonomous Mobile Robots

% Set unspecified inputs
if nargin < 1
    disp('ERROR: TCP/IP port object not provided.');
    return;
elseif nargin < 2
    SonarPort = CreatePort;
    BeaconPort = CreatePort;
    tagNum = CreatePort;
    maxTime = 500;
elseif nargin < 3
    BeaconPort = CreatePort;
    tagNum = CreatePort;
    maxTime = 500;
elseif nargin < 4
    tagNum = CreatePort;
    maxTime = 500;
elseif nargin < 5
    maxTime = 500;
end

% declare dataStore as a global variable so it can be accessed from the
% workspace even if the program is stopped
global dataStore;

% initialize datalog struct (customize according to needs)
dataStore = struct('truthPose', [],...
                   'odometry', [], ...
                   'lidar', [], ...
                   'sonar', [], ...
                   'bump', [], ...
                   'beacon', []);


% Variable used to keep track of whether the overhead localization "lost"
% the robot (number of consecutive times the robot was not identified).
% If the robot doesn't know where it is we want to stop it for
% safety reasons.
noRobotCount = 0;

%set up constraints
 maxDuration= 1200;  % Max time to allow the program to run (s)
 maxDistSansBump= 5; % Max distance to travel without obstacles (m)
maxFwdVel= 0.5;     % Max allowable forward velocity with no angular 
                        % velocity at the time (m/s)
    maxVelIncr= 0.005;  % Max incrementation of forward velocity (m/s)
    maxOdomAng= pi/4;   % Max angle to move around a circle before 
                        % increasing the turning radius (rad)
     robotRadius = 0.2;                   
                        
% Initiallize loop variables
tic
start = 'start'
distSansBump= 0;    % Distance traveled without hitting obstacles (m)
angTurned= 0;       % Angle turned since turning radius increase (rad)
v_x = 1; v_y = 0;% Forward velocity (m/s)

maxV = 0.4;
    %robotDiam = 0.258;
    robotRadius = 0.13;
    epsilon = 2;
bumped = 0;
while toc < maxTime
    
    % READ & STORE SENSOR DATA
    [noRobotCount,dataStore]=readStoreSensorData(CreatePort,SonarPort,BeaconPort,tagNum,noRobotCount,dataStore);
    
    % CONTROL FUNCTION (send robot commands)
    
    % Check for and react to bump sensor readings
    [BumpRight, BumpLeft, WheDropRight, WheDropLeft, WheDropCaster, ...
        BumpFront] = BumpsWheelDropsSensorsRoomba(CreatePort);
    if BumpRight || BumpLeft || BumpFront;
        bumped = 1;
    end
    
    % along curve if 
    [px, py, pt] = OverheadLocalizationCreate(CreatePort);
   
    [ v, w ] = feedbackLin( v_x, v_y, pt, epsilon);
    
    % if overhead localization loses the robot for too long, stop it
    if noRobotCount >= 3
        SetFwdVelAngVelCreate(CreatePort, 0,0);
    elseif bumped
        
         SetFwdVelAngVelCreate(CreatePort, -0.3, 0 );
    else
        [cmdV, cmdW] = limitCmds(v, w, maxV,robotRadius);
        SetFwdVelAngVelCreate(CreatePort, cmdV, cmdW );
    end
    
    pause(0.1);
end

% set forward and angular velocity to zero (stop robot) before exiting the function
SetFwdVelAngVelCreate(CreatePort, 0,0 );

end

function bumped= bumpCheckReact(serPort)
% Check bump sensors and steer the robot away from obstacles if necessary
%
% Input:
% serPort - Serial port object, used for communicating over bluetooth
%
% Output:
% bumped - Boolean, true if bump sensor is activated

    % Check bump sensors (ignore wheel drop sensors)
    [BumpRight, BumpLeft, WheDropRight, WheDropLeft, WheDropCaster, ...
        BumpFront] = BumpsWheelDropsSensorsRoomba(serPort);
    bumped= BumpRight || BumpLeft || BumpFront;
    
    
    
    v = -0.3;
    w = 0;
    % Halt forward motion and turn only if bumped
    if bumped
        
        %back up for 0.25m
        [cmdV, cmdW] = limitCmds(v, w, maxV,robotRadius);
        SetFwdVelAngVelCreate(CreatePort, cmdV, cmdW );
        pause(0.1);
    end
end

function w= v2w(v)
% Calculate the maximum allowable angular velocity from the linear velocity
%
% Input:
% v - Forward velocity of Create (m/s)
%
% Output:
% w - Angular velocity of Create (rad/s)
    
    % Robot constants
    maxWheelVel= 0.5;   % Max linear velocity of each drive wheel (m/s)
    robotRadius= 0.2;   % Radius of the robot (m)
    
    % Max velocity combinations obey rule v+wr <= v_max
    w= (maxWheelVel-v)/robotRadius;
end
