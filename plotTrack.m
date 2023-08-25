function [track2center, kEnd] = plotTrack(N, obs, interpolation)
% Plots the race track and gives center position and simulation time kEnd

load track2.mat
if interpolation == 1
[track2center,kEnd] = interpolateTrack(track2.center, N);
else
    track2center = track2.center(:,1:end);
end

track2center = [repmat(track2center, [1,2]), track2center(:, 1:N+1)];
clf;

figure(1)
trackWidth = norm(track2.inner(:,1)-track2.outer(:,1));

set(gcf,'Position',[500 100 800 800])
hold on
plot(track2.outer(1,:),track2.outer(2,:),'k', 'LineWidth', 1)
plot(track2.center(1,:),track2.center(2,:),'k--', 'LineWidth', 0.1)
plot(track2.inner(1,:),track2.inner(2,:),'k', 'LineWidth', 1)

% Plot the original and evenly spaced points
% figure(2)
% subplot(1,2,1);
% plot(track2.center(1,:), track2.center(2,:), 'o', 'MarkerSize', 5);
% title('Original Points');
% xlabel('x');
% ylabel('y');
% 
% subplot(1,2,2);
% plot(track2center(1,:), track2center(2,:), 'o', 'MarkerSize', 5);
% title('Evenly Spaced Points');
% xlabel('x');
% ylabel('y');

kEnd = length(track2center(1,:))-N;

if obs == 1
[~, Obs] = generateTrackingObstacles(N, 1);
end

end