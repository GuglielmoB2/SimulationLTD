function plotResultsParametric(path, typeOfModel, nameParameter, numberOfTrial, rangeOfValuesParameter)
% --------------------------- %
% Printing of the following graphs in a single figure:
% 1) time - applied force
% 2) time - Davis resistance
% 3) time - jerk
% 4) time - acceleration
% 5) time - speed
% 6) time - space
% INPUT:
% 1) path:                           describe  the path of Simulink file
% 2) typeOfModel:                    linear or nonlinear
% 2) nameParameter:                  string 
% 3) numberOfTrial:                  if == 1 there is no parametric analisys, otherwise  == 0
% 4) rangeOfValuesParameter:         vector containing the values of the parameter have to be modified
% OUTPUT: summary figure
% --------------------------- %

if (typeOfModel < 0 || typeOfModel > 2)
    fprintf("Wrong parameters for numberOfTrial\n");
    return;
end
% Only use for parametric analysis
if (numberOfTrial <= 0 || numberOfTrial > 6)
    fprintf("Wrong parameters for numberOfTrial\n");
    return;
elseif (numberOfTrial == 1)
    if(typeOfModel == 0)
        f1 = figure('Name','Results of NL Dynamics','NumberTitle','off');
    else
        f1 = figure('Name','Results of Linear Dynamics','NumberTitle','off');
    end
else
    plotStyle   = {'-o','-p','-d','-s','-^', 'p'};
    f2 = figure('Name','Results of NL Dynamics parametrics','NumberTitle','off');
    % Save the state of parameter
    valueTemp = evalin("base", nameParameter); 
end

% Definition of plots' style 

[strColors, strXaxis, strYaxis, strTitle, refSubplot, legendLabel] = stylePlots();

for j = 1:numberOfTrial
     if(numberOfTrial > 1)
         assignin('base', nameParameter, rangeOfValuesParameter(j));
         legendParameter{j} = "$\mathrm{" + nameParameter + "\;=\;" + rangeOfValuesParameter(j) + "}$";  % Make legend caption for this curve.
     end
     [force, resistance, jerk, acceleration, speed, space, t] = extractDataFromSimulation(path, typeOfModel);
     % Update data from X-Y axles
     xAxis      = {[t] [t] [t] [t] [t] [t]};
     yAxis      = { [force] [resistance] [jerk] [acceleration] [speed] [space]};
for i = 1:6
    subplot(5,3,[refSubplot(2*i-1) refSubplot(2*i)]); 
    hold on;
    if(numberOfTrial > 1)
       plot(xAxis{1,1}, yAxis{1,i},strcat(strColors(i),plotStyle(j)), 'LineWidth', 0.7, "MarkerFaceColor", strColors(i), 'MarkerIndices',1:10:length(yAxis{1,i}), "MarkerSize",4);      
    else
        plot(xAxis{1,1}, yAxis{1,i}, strColors(i), 'LineWidth', 1.3);
    end
    xlabel("$\mathrm{"+strXaxis(1)+"}$", 'interpreter', 'latex');
    ylabel("$\mathrm{"+strYaxis(i)+"}$", 'interpreter','latex');
    axis padded;
    grid on;
    hold all;
    title(strTitle(i), 'interpreter','latex');
    if (numberOfTrial == 1)
        legend("$\mathrm{"+legendLabel(i)+"}$", 'Location','best', 'interpreter', 'latex');
    else
       legend(legendParameter, 'Location','best', 'interpreter','latex');
    end
end

if (numberOfTrial > 1)
   % Restore state 
    assignin('base', nameParameter, valueTemp);
end
end
