function compare2models(pathL, pathNL)
% --------------------------- %
% Comparison between linear and non-linear model LTD.
% INPUT
% 1) pathL: path of linear Simulink model
% 2) pathNL: path of NON linear Simulink model
% OUTPUT
% comparison between the results of these two models for jerk, 
% acceleration, velocity and space through one single figure.
% --------------------------- %


    % Definition of plots' style 
[strColors, strXaxis, strYaxis, strTitle, refSubplot, legendLabel] = stylePlots();

% Run + Extrack data from NL ModeL

[force, resistance, jerk, acceleration, speed, space, t] = extractDataFromSimulation(pathNL, 0);

% Update data from X-Y axles
xAxis      = {[t] [t] [t] [t] [t] [t]};
yAxis      = { [force] [resistance] [jerk] [acceleration] [speed] [space]};

[forceLin, resistanceLin, jerkLin, accelerationLin, speedLin, spaceLin, timeLin] = extractDataFromSimulation(pathL, 1);

% Update data from X-Y axles
xAxisLin =  {[timeLin] [timeLin] [timeLin] [timeLin] [timeLin] [timeLin]};
yAxisLin =  {[jerkLin] [accelerationLin] [speedLin] [spaceLin]};


% Definition of the figure to plot
f3 = figure('Name','Differences between linear and nonlinear model','NumberTitle','off');
for i = 1:2
    subplot(5,3,[refSubplot(2*i-1) refSubplot(2*i)]); 
    plot(xAxis{1,1}, yAxis{1,i}, strColors(i), 'LineWidth', 1.3);
    xlabel("$\mathrm{"+strXaxis(1)+"}$", 'interpreter', 'latex');
    ylabel("$\mathrm{"+strYaxis(i)+"}$", 'interpreter','latex');
    axis padded;
    grid on;
    hold all;
    title(strTitle(i), 'interpreter','latex');
    legend("$\mathrm{"+legendLabel(i)+"}$", 'Location','best', 'interpreter', 'latex');  
end

for i = 3:6
    subplot(5,3,[refSubplot(2*i-1) refSubplot(2*i)]); 
    plot(xAxisLin{1,1}, yAxisLin{1,i-2}, xAxis{1,1}, yAxis{1,i}, strColors(i), 'LineWidth', 1.3);
    xlabel("$\mathrm{"+strXaxis(1)+"}$", 'interpreter', 'latex');
    ylabel("$\mathrm{"+strYaxis(i)+"}$", 'interpreter','latex');
    axis padded;
    grid on;
    hold all;
    title(strTitle(i), 'interpreter','latex');
    legend("$\mathrm{"+legendLabel(i)+"\;Linear}$", "$\mathrm{"+legendLabel(i)+"\;Nonlinear}$", 'Location','best', 'interpreter', 'latex');  
end

end