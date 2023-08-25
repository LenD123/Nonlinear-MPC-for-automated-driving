function [obs, Obs] = generateTrackingObstacles(N, figureOnOff)
% Generates the tracking obstacles
% obs is used for casadi constraints and Obs for plotting
track2 = [];
load track2.mat
width_obstacles = car.width_obstacles;

if figureOnOff == 0
    set(gcf,'visible','off')
else
    set(gcf,'visible','on')
end

Obs = track2.center;
Obs(abs(Obs)>0 )= 0; 

Obs(:, 85) = track2.center(:, 85)-track2.center(:,85)/10;
circle2(Obs(:,85)', width_obstacles/2);

Obs(:, 130) = track2.center(:, 130)+track2.center(:,130)/15;
circle2(Obs(:,130)', width_obstacles/2);

Obs(:,200) = track2.center(:,200)-track2.center(:,200)/20;
circle2(Obs(:,200)', width_obstacles/2);

Obs(:,310) = track2.center(:,310)- track2.center(:,310)/15;
circle2(Obs(:,310)', width_obstacles/2);

Obs(:, 400) = track2.center(:, 400) -track2.center(:,400)/25;
circle2(Obs(:,400)', width_obstacles/2);

Obs(:, 420) = track2.center(:, 420)-track2.center(:,420)/30;
circle2(Obs(:,420)', width_obstacles/2);

Obs(:, 530) = track2.center(:, 530) +  track2.center(:,530)/35;
circle2(Obs(:,530)', width_obstacles/2);

Obs(:, 545) = track2.center(:, 545) - track2.center(:,545)/35;
circle2(Obs(:,545)', width_obstacles/2);

Obs(:, 560) = track2.center(:, 560) + track2.center(:,560)/25;
circle2(Obs(:,560)', width_obstacles/2);

Obs(:, 630) = track2.center(:,630) +track2.center(:,630)/20;
circle2(Obs(:,630)', width_obstacles/2);

Obs(:, 635) = track2.center(:,635);
circle2(Obs(:,635)', width_obstacles/2);

Obs(:, 640) = track2.center(:,640);
circle2(Obs(:,640)', width_obstacles/2);

Obs(:, 652) = track2.center(:,652) -track2.center(:,652)/20;
circle2(Obs(:,652)', width_obstacles/2);

obs = [Obs(:, 85), Obs(:, 130), Obs(:, 200), Obs(:, 310), Obs(:, 400), Obs(:, 420), Obs(:, 530), Obs(:, 545), Obs(:, 560), Obs(:, 630), Obs(:, 635), Obs(:, 640), Obs(:, 652)];
Obs = [repmat(Obs, [1,2]), Obs(:, 1:N+1)];



function h = circle2(xy,r)
x = xy(1);
y = xy(2);
d = r*2;
px = x-r;
py = y-r;
h = rectangle('Position',[px py d d],'Curvature',[1,1], 'LineWidth', 1.5);
daspect([1,1,1])
end

end