function [] = carBox(X, w, l)
%Plots the car with wheels

    persistent car wheels
    Lf = l/2; % distance from the center of mass to the front axle
    Lr = l/2; % distance from the center of mass to the rear axle
    x = X(1);
    y = X(2);
    psi = X(3); % vehicle orientation
    delta = X(5); % steering angle
    yaw = psi + atan2(Lr/(Lf+Lr)*tan(delta), 1);

    car1 = [x;y] + [cos(yaw)*l;sin(yaw)*l] + [sin(yaw)*w;-cos(yaw)*w];
    car2 = [x;y] + [cos(yaw)*l;sin(yaw)*l] - [sin(yaw)*w;-cos(yaw)*w];
    car3 = [x;y] - [cos(yaw)*l;sin(yaw)*l] + [sin(yaw)*w;-cos(yaw)*w];
    car4 = [x;y] - [cos(yaw)*l;sin(yaw)*l] - [sin(yaw)*w;-cos(yaw)*w];
    
    wheel_f1 = [x;y] + [cos(yaw)*l;sin(yaw)*l] + [sin(yaw)*w;-cos(yaw)*w] + [cos(yaw+delta); sin(yaw+delta)]*l/3;
    wheel_f2 = [x;y] + [cos(yaw)*l;sin(yaw)*l] + [sin(yaw)*w;-cos(yaw)*w] - [cos(yaw+delta); sin(yaw+delta)]*l/3;
    wheel_r1 = [x;y] - [cos(yaw)*l;sin(yaw)*l] + [sin(yaw)*w;-cos(yaw)*w] + [cos(yaw); sin(yaw)]*l/3;
    wheel_r2 = [x;y] - [cos(yaw)*l;sin(yaw)*l] + [sin(yaw)*w;-cos(yaw)*w] - [cos(yaw); sin(yaw)]*l/3;

    delete(car)
    delete(wheels)

    car = plot([car1(1),car2(1),car4(1),car3(1),car1(1)],[car1(2),car2(2),car4(2),car3(2),car1(2)],'Color', [0 0.4 0.7],'LineWidth',2.5);
    hold on
    wheels = plot([wheel_f1(1), wheel_f2(1)], [wheel_f1(2), wheel_f2(2)], 'k','LineWidth',4.5);
    wheels = [wheels, plot([wheel_r1(1), wheel_r2(1)], [wheel_r1(2), wheel_r2(2)], 'k','LineWidth',4.5)];
    % Adjust positions of left-side wheels
    wheels = [wheels, plot([wheel_f1(1), wheel_f2(1)] - 2*sin(yaw)*w, [wheel_f1(2), wheel_f2(2)] + 2*cos(yaw)*w,'k','LineWidth',4.5)];
    wheels = [wheels, plot([wheel_r1(1), wheel_r2(1)] - 2*sin(yaw)*w, [wheel_r1(2), wheel_r2(2)] + 2*cos(yaw)*w,'k','LineWidth',4.5)];

end
