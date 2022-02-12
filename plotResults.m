function plotResults(path, typeOfModel)
% --------------------------- %
% Printing of the following graphs in a single figure:
% 1) time - applied force
% 2) time - Davis resistance
% 3) time - tear
% 4) time - acceleration
% 5) time - speed
% 6) time - space
% INPUT:
% 1) path:          the path of the Simulink file
% 2) typeOfModel:   linear or nonlinear
% OUTPUT: summary figure
% There's a special case when the parametric analysis is unitary.
% --------------------------- %

plotResultsParametric(path, typeOfModel, "", 1,0);

end