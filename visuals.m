function [pred, t] = visuals(X, XPred, k, exercise)

if exercise == 1 %parken

    figure(1)
    hold on
    velstr = sprintf('Geschwindigkeit: %.01f',X(4));
    steerstr = sprintf('Lenkwinkel: %.1f°', X(5)*180/pi);
    t(1) = text(0.4, 1, velstr);
    t(2) = text(0.4, 0.9, steerstr);
    drawnow()
    pred = plot(XPred(1,:), XPred(2,:), 'r-', 'linewidth',1.5);
    plot(X, k)
    carBox(X, car.width_car, car.length_car)
    hold on
    
elseif exercise == 2 %tracking und obstacles

    figure(1)
    hold on
    velstr = sprintf('Geschwindigkeit: %.01f',X(4));
    steerstr = sprintf('Lenkwinkel: %.1f°', X(5)*180/pi);
    t(1) = text(1.2, 1.8, velstr);
    t(2) = text(1.2, 1.7, steerstr);
    pred = plot(XPred(1,:), XPred(2,:), 'r-', 'linewidth',1.5);
    carBox(X, car.width_car, car.length_car)
    hold on

    
end
end

