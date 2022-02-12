function [strColors, strXaxis, strYaxis, strTitle, refSubplot, legendLabel] = stylePlots()
% --------------------------- %
% Definition of the charts' styles to be plotted.
% INPUT: nothing
% OUTPUT:
% 1) color of the axles
% 2) label of the abscissa axles
% 3) label of the axles on the ordinates
% 4) title of the graph
% 5) positioning of the different suplots
% 6) default chart legend
% --------------------------- %

strColors   = ["red" "blue" "magenta" "cyan" "green" "black"];
strXaxis    = ["Time\;(s)" "Time\;(s)" "Time\;(s)" "Time\;(s)" "Time\;(s)" "Time\;(s)"];
strYaxis    = ["Force\;(N)" "Davis's Resistance\;(N)" "Jerk\;(m/s^3)" "Acceleration\;(m/s^2)" "Speed\;(m/s)" "Space\;(m)"];
strTitle    = ["Time$\;$-$\;$Force" "Time$\;$-$\;$Davis's Resistance" "Time$\;$-$\;$Jerk" "Time$\;$-$\;$Acceleration" "Time$\;$-$\;$Speed" "Time$\;$-$\;$Space"];
refSubplot  = [[1 4] [10 13] [12 15] [3 6] [11 14] [2 5]];
legendLabel = ["F(t)" "R(t)" "j(t)" "a(t)" "v(t)" "s(t)"];

end