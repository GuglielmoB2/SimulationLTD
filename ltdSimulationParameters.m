%% Info 
% Developed by Guglielmo B.
% University of Salerno, Italy
% 2022

%% Cleaning all variables
clc
clear
close all

%% Definition of parameters (vehicle and track)

% Vehicle
load                = 64;                                  % seats per railcar               [adim]
weight              = 70;                                  % average mass of the single passenger [kg]
nP                  = 6;                                   % number of vehicle axles              [adim]
M                   = 54.5;                                % mass of empty railcar                [tonn] 
m                   = M * 10^3 + (load * weight);          % total mass                           [kg]
wP                  = m/nP;                                % mass per axle                   [tonn]
ageTrain            = 0.85;                                % update Davis's formula               [adim]
alpha               = m / 10^3 * ageTrain;                 % effective mass per railcar           [tonn] 
accelerationLimit   = 0.37;                                % maximum acceleration of the vehicle  [m/s^2]
decelerationLimit   = 1.18;                                % minimum acceleration of the vehicle  [m/s^2]
speedLimit          = 55.88;                               % maximum speed allowed                [m/s]
maxTractiveEffort   = 100 * 10 ^3;                         % maximum tractive effort of the train [N]
maxBrakingForce     = 44 * 10^3;                           % minimum braking effort of the train  [N]

% Track
Ka                  = 0.07;                                % drag coefficient                     [adim]
theta               = 4e-4;                                % track gradient                       [adim]

% tractive effort for equilibrium: (0.6+20/wP+20*theta)*4.4482*ageTrain*m/1000
%% Definition of simulation's parameters

% Timing
tStart = 0;
tFinal = 200;

%% Simulation of the linearized system at equilibrium

% Recall:
% x_dot = Ax + Bu
% y     = Cx + Du 

% Define A,B,C and D matrix
A = [0       1;            
     0     -1/100 * alpha/M];       
   
B = [0; 
     1/M];

C = [0 1];
D = 0;

% System's state

% Recall: 
% $x_{1}(t)$              space; 
% $x_{2}(t)=\dot{x_1(t)}$ speed; 

x_1 = 0;                % central in the origin of the reference system
x_2 = 0;                % stationary vehicle
x_0 = [x_1 x_2]';

% Building system
sys  = ss(A,B,C,D);

%% Simulation of the linear model

plotResults('LinearModelNoFeedback', 1);

%% Simulation of linear model with controller
% Select path for linearized model 
pathL = 'LinearModel.slx';


% Building controll using state feedback 
pole = [-2 -5];
K = place(A,B,pole);

plotResults(pathL, 1);




%% Simulation of the NL (Non Linear) system developed in Simulink

plotResults('NoLinearModel', 0);


% Alternative form
%plotNLresultsParametric( ... );
%%  Show of the results obtained by the linear model and the non-linear model


pathNL = 'NoLinearModel.slx';

compare2models('LinearModelNoFeedback', pathNL);

%% Parametric analisys on NL results

%   1. Selection of parameter.
        % --> peopleWeight
nameParameter = "nP";

%   2. Definition of number of trial (max 6)
numberOfTrial = 3;

%   3. Stabilization of the range
% rangeOfValuesParameter
rangeOfValuesParameter = linspace(4e-4, 36e-4, numberOfTrial);

plotResultsParametric('NoLinearModel.slx', 0, nameParameter, numberOfTrial, rangeOfValuesParameter);

