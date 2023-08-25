function [refInt, kEnd] = interpolateTrack(ref, N)
% input coordinates (replace with your actual coordinates)
x = ref(1,:);
y = ref(2,:);

% Define the desired number of evenly spaced points
numPoints = 550; %length(ref(1,:));

% Calculate the cumulative distance between consecutive points
distances = cumsum([0, sqrt(diff(x).^2 + diff(y).^2)]);

% Create a range of distances for the desired number of points
evenDistances = linspace(0, distances(end), numPoints);

% Interpolate the x and y coordinates based on the even distances
evenlySpacedX = interp1(distances, x, evenDistances, 'spline');
evenlySpacedY = interp1(distances, y, evenDistances, 'spline');

% % Plot the original and evenly spaced points
% figure(2)
% subplot(2,2,1);
% plot(x, y, 'o', 'MarkerSize', 5);
% title('Original Points');
% xlabel('x');
% ylabel('y');
% 
% subplot(2,2,2);
% plot(evenlySpacedX, evenlySpacedY, 'o', 'MarkerSize', 5);
% title('Evenly Spaced Points');
% xlabel('x');
% ylabel('y');

refInt = [evenlySpacedX; evenlySpacedY];
kEnd = length(refInt(1,:))-N;

end

