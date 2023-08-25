%%% NMPC automated driving with obstacle avoidance %%%%
clc; clear; close all;
import casadi.*

%% MPC setup
% States: x, y, psi, v, delta
% Inputs: a, s 

% Prediction horizon
N = 16;

% Generate obstacles
[obs, ~] = generateTrackingObstacles(N, 0);

% State and input dimensions
nx = 5; nu = 2;

% CasADi object 
opti = casadi.Opti();
x = opti.variable(nx, N+1);
u = opti.variable(nu, N);
xt = opti.parameter(nx,1);
ref = opti.parameter(2, N+1);
cost = 0;

% Constraints to a, v, s
v_max = 1;     % maximal velocity
v_min = 0;      % minimal velocity
a_max = 0.6; %maximale accelration
s_max = 1; %maximale steering rate
opti.subject_to( x(:,1) == xt );

% Cost function and constraints
for k=1:N
    opti.subject_to( x(:,k+1) == fdyn(x(:,k),u(:,k)) ); % dynamics
  for j = 1:length(obs)
    opti.subject_to ( norm(x(1:2,k) - obs(:,j), 2) >= (car.width_car/2 + car.width_obstacles) );
  end
    opti.subject_to( x(4,k) <= v_max );
    opti.subject_to( x(4,k) >= v_min );
    opti.subject_to( u(2,k) <= s_max ); 
    opti.subject_to( u(2,k) >= -s_max ); 
    opti.subject_to( u(1,k) <= a_max );
    opti.subject_to( u(1,k) >= -a_max );
    cost = cost + (x(1:2,k)-ref(:,k))'*(x(1:2,k)-ref(:,k)); % cost
end
cost = cost + (x(1:2,N+1)-ref(:,N+1))'*(x(1:2,N+1)-ref(:,N+1)); % terminal cost
opti.minimize( cost );

p_opts = struct('verbose',false);
s_opts = struct('print_level',0);
p_opts.print_time = false;
opti.solver('ipopt',p_opts,s_opts);

%% System simulation
% Road with objects
[Ref, kEnd] = plotTrack(N, 1,1);

% Initialization
x0 = [Ref(1,1); Ref(2,1); 0; 0;0];
x0(3) = atan2( (Ref(2,2)-Ref(2,1)) , (Ref(1,2)-Ref(1,1)));
X = [x0,zeros(nx,kEnd)]; U = zeros(nu,kEnd);
XPred = {};  UPred = {};

for k = 1:kEnd
    % Initial state and reference points
    opti.set_value( xt, X(:, k) )
    opti.set_value( ref, Ref(:, k:k+N) )
    % Solve OCP
    sol = opti.solve();
    % Optimized sequences
    XPred{k} = sol.value( x );
    UPred{k} = sol.value( u );
    % Apply first input
    U(:,k) = UPred{k}(:,1);
    X(:,k+1) = fdyn( X(:,k), U(:,k) );
    
    opti.set_initial( x, [XPred{k}(:,2:end), fdyn(XPred{k}(:,end),[0;0])] )
    opti.set_initial( u, [UPred{k}(:,2:end), [0;0] ] )
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Visualisation
    [pred(k+1), t(:,k+1)] = visuals(X(:,k), XPred{k}, k, 2);
    delete(pred(k))
    delete(t(:,k))
    pause(0.01)
end
delete(pred(k+1))
