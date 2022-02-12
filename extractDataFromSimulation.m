function [f, r, j, a, spe, spa, t] = extractDataFromSimulation(path, op)
% --------------------------- %
% Simulation of the non-linear LTD model through the application of 
% a maxTractiveForce amplitude step.
% INPUT: 
% 1) path:  specify the path of Simulink file
% 2) op  :  type of model
% OUTPUT: 
% Force, Resistance, Jerk, Acceleration, Speed, Space, Time
% --------------------------- %

assert(op > 0 || op < 2, "Wrong value for the type of operation");
assert(path ~= "", "No string entered");

% Open + run Simulink NL 
result = sim(path);

% Extraction of data from Simulink 

if (op == 0)
    f   = result.simResults.signals.values(:,1);
    r   = result.simResults.signals.values(:,2);
    j   = result.simResults.signals.values(:,3);
    a   = result.simResults.signals.values(:,4);
    spe = result.simResults.signals.values(:,5);
    spa = result.simResults.signals.values(:,6);
    t   = result.simResults.time;
else
    f   = result.simResultLin.signals.values(:,1);
    r   = 0;
    j   = result.simResultLin.signals.values(:,5);
    a   = result.simResultLin.signals.values(:,4);
    spe = result.simResultLin.signals.values(:,3);
    spa = result.simResultLin.signals.values(:,2);
    t   = result.simResultLin.time;
end