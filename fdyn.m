function x_next = fdyn(x, u)
% Dynamics of the vehicle
  % states: x, y, psi, v, delta
  % inputs: a, s
  
  h = 0.05; % sampling constant
  psi = x(3); % Orientation
  v = x(4); % Velocity
  delta = x(5); % Steering angle
  a = u(1); % Acceleration
  s = u(2); % Steering rate
  l = car.length_car; %vehcicle length
  
  %Dynamics:
  x_next = x + h*[v * cos(psi + delta); v*sin(psi+delta); v/l * sin(delta); a; s];
end