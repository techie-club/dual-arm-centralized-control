%% SETTING PLOT FIGURE
fsa     = 14;             % fontsize axis 14
fsl     = 16;             % fontsize labels 18
fsc     = 14;             % fontsize comments
fsleg	= 14;		      % legend fontsize
font    = 'Times';        % font family

%% PLOT RESULTS

durata = sum(c_history);
if durata <= 60
    fprintf('\nSimulation duration: %.0f seconds.\n', durata)
else
    fprintf('\nSimulation duration: %.0f minutes.\n', durata / 60)
end

%% MANIPULATED VARIABLES
figure(1)
for i = 1 : nu
    subplot(nu, 1, i), stairs(tempo, u_history(:, i)), grid on
    set(gca, 'fontsize', fsa), xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
    ylabel(strcat('\tau_', num2str(i), ' [Nm]'), 'fontsize', fsl, 'FontName', font)
    ylim([min(u_history(:, i)), max(u_history(:, i))]), ax = gca; 
    ax.YMinorGrid = 'on'; ax.YMinorTick = 'on'; ax.YAxis.TickLabelFormat = '%.2f';
end
sgtitle('Inputs over time', 'fontsize', fsl)

%% OUTPUTS
figure(2)
legend_text = {'Output', 'Reference'}; 
for i = 1 : 2
    subplot(2, 1, i), stairs(tempo, y_history(:, i)), hold on
    stairs(tempo, r_history(:, i)), hold off, grid on
    set(gca, 'fontsize', fsa), xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
    ylabel(['$q_{', num2str(i), '}$ [rad]'], ...
        'FontSize', fsl, 'FontName', font, 'Interpreter', 'latex')
    legend(legend_text, 'Interpreter','latex'), legend('boxon')
    set(legend, 'FontName', font, 'FontSize', fsleg), legend('Location','best')
    ax = gca; ax.YMinorGrid = 'on'; ax.YMinorTick = 'on'; ax.YAxis.TickLabelFormat = '%.2f';
end
sgtitle('Outputs vs references over time', 'fontsize', fsl)

figure(3)
for i = 3 : 4
    subplot(2, 1, i-2), stairs(tempo, y_history(:, i)), hold on
    stairs(tempo, r_history(:, i)), hold off, grid on
    set(gca, 'fontsize', fsa), xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
    ylabel(['$\dot{q}_{', num2str(i-2), '}$ [rad/s]'], ...
        'FontSize', fsl, 'FontName', font, 'Interpreter', 'latex')
    legend(legend_text, 'Interpreter','latex'), legend('boxon')
    set(legend, 'FontName', font, 'FontSize', fsleg), legend('Location','best')
    ax = gca; ax.YMinorGrid = 'on'; ax.YMinorTick = 'on'; ax.YAxis.TickLabelFormat = '%.2f';
end
sgtitle('Outputs vs references over time', 'fontsize', fsl)

%% JOINT ACCELERATIONS
xd = [];
for k = 1 : nc
    xd(k, :) = StateFcn(x_history(k, :)', u_history(k, :)');
end
figure(4)
for i = 1 : 2
    subplot(2, 1, i), stairs(tempo, xd(:, i+2)), grid on
    set(gca, 'fontsize', fsa), xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
    ylabel(['$\ddot{q}_{', num2str(i), '}$ [rad/s$^2$]'], ...
        'FontSize', fsl, 'FontName', font, 'Interpreter', 'latex')
    ax = gca; ax.YMinorGrid = 'on'; ax.YMinorTick = 'on'; ax.YAxis.TickLabelFormat = '%.2f';
end
sgtitle('Accelerations over time', 'fontsize', fsl)

%% COST FUNCTION
figure(5)
plot(tempo, v_history), grid on
title('Cost function over time', 'fontsize', fsl)
set(gca, 'fontsize', fsa), xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('V(k)', 'fontsize', fsl, 'FontName', font)

%% COMPUTATION TIME
ts = Tc * ones(length(tempo));
figure(6)
plot(tempo, c_history), hold on, plot(tempo, ts, '--'), hold off, grid on
title('Computation time', 'fontsize', fsl)
set(gca, 'fontsize', fsa), xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
legend_text = {'Computation time', 'Sampling time'}; 
legend(legend_text, 'Interpreter','latex')	
legend('boxon'), set(legend, 'FontName', font, 'FontSize', fsleg)
legend('Location','best')

%% EVALUATION OF OBSTACLE CONSTRAINT
q1_t = y_history(:, 1); q2_t = y_history(:, 2);
qd1_t = r_history(:, 1);  qd2_t = r_history(:, 2);
x = a1 * cos(q1_t) + a2 * cos(q1_t + q2_t);
y = a1 * sin(q1_t) + a2 * sin(q1_t + q2_t);
xref = a1 * cos(qd1_t) + a2 * cos(qd1_t + qd2_t);
yref = a1 * sin(qd1_t) + a2 * sin(qd1_t + qd2_t);
legend_text = {'Obstacle', 'End-effector', 'Reference'};

switch ostacolo

    case {'soffitto'}
        h_x = a1 * sin(q1_t) + a2 * sin(q1_t + q2_t);
        vincolo = lc * ones(length(tempo));
        figure(7); clf; h1 = plot(x, lc * ones(nc, 1), '--'); hold on;
        h2 = plot(x, y); h3 = plot(xref, yref, 'x'); hold off;
        set(gca, 'fontsize', fsa); axis equal; grid on;
        title('Evaluation of the obstacle constraint', 'fontsize', fsl);
        xlabel('x [m]', 'fontsize', fsl, 'FontName', font);
        ylabel('y [m]', 'fontsize', fsl, 'FontName', font);
        legend([h1, h2, h3], legend_text, 'Location', 'best');

    case {'cerchio'}
        h_x = -(a1 * cos(q1_t) + a2 * cos(q1_t + q2_t) - cx).^2 - ...
             (a1 * sin(q1_t) + a2 * sin(q1_t + q2_t) - cy).^2;
        vincolo = -rc^2 * ones(length(tempo));
        ang = 0 : 0.01 : 2 * pi; xp = rc * cos(ang); yp = rc * sin(ang);
        figure(7); clf; h1 = plot(cx + xp, cy + yp, '--'); hold on;
        h2 = plot(x, y); h3 = plot(xref, yref, 'x'); hold off; 
        set(gca, 'fontsize', fsa); axis equal; grid on;
        title('Evaluation of the obstacle constraint', 'fontsize', fsl);
        xlabel('x [m]', 'fontsize', fsl, 'FontName', font);
        ylabel('y [m]', 'fontsize', fsl, 'FontName', font);
        legend([h1, h2, h3], legend_text, 'Location', 'best');
end

figure(8)
plot(tempo, h_x), hold on, plot(tempo, vincolo, '--'), hold off, grid on, 
title('Evaluation of the obstacle constraint', 'fontsize', fsl)
set(gca, 'fontsize', fsa), xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('h(x), lc [m]', 'fontsize', fsl, 'FontName', font)
legend_text = {'h(x)', 'lc'}; legend(legend_text, 'Interpreter','latex')	
legend('boxon'), set(legend, 'FontName', font, 'FontSize', fsleg)
legend('Location','best')

%% POSITION ERROR NORM
pos_err_norm = sqrt((y_history(:, 1) - r_history(:, 1)).^2 + ...
                (y_history(:, 2) - r_history(:, 2)).^2);
figure(9)
plot(tempo, pos_err_norm), grid on
title('Position error norm', 'fontsize', fsl)
set(gca, 'fontsize', fsa), xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$\Vert \tilde{q} \Vert [rad]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)

%% VELOCITY ERROR NORM
vel_err_norm = sqrt((y_history(:, 3) - r_history(:, 3)).^2 + ...
                (y_history(:, 4) - r_history(:, 4)).^2);
figure(10)
plot(tempo, vel_err_norm), grid on
title('Velocity error norm', 'fontsize', fsl)
set(gca, 'fontsize', fsa), xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$\Vert \tilde{\dot{q}} \Vert [rad/s]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)

%% TO REPRESENT THE MANIPULATOR
figure("Color", "w")
hPlot = helperRobotEnvironment(Length1 = a1, Length2 = a1);
hPlot.Theta1 = qi(1); hPlot.Theta2 = qi(2); hPlot.xf = qf;

for k = 1 : nc
    hPlot.Theta1 = y_history(k, 1);
    hPlot.Theta2 = y_history(k, 2);
    drawnow limitrate
end

%% USEFUL RESULTS
fprintf('Maximum position error (norm): %.3frad.\n', max(pos_err_norm))
fprintf('Position error (norm) at t=tf: %erad.\n', pos_err_norm(end))
fprintf('Maximum velocity error (norm): %.3frad/s.\n', max(vel_err_norm))
fprintf('Velocity error (norm) at t=tf: %erad/s.\n', vel_err_norm(end))
fprintf('Maximum cost function value: %.3f.\n', max(v_history))
fprintf('Cost function at t=tf: %e.\n', v_history(end))
for i = 1 : 2
    fprintf('Joint variable n.%d: ', i)
    performance_metrics(tempo, y_history(:, i));
end

function [tas2, OS] = performance_metrics(t, y)
    y_final = mean(y(end-10:end));
    
    y_max = max(y); OS = ((y_max - y_final) / y_final) * 100;
    
    tolerance = 0.02 * abs(y_final);
    idx_tas2 = find(abs(y - y_final) > tolerance, 1, 'last'); 
    tas2 = t(idx_tas2);  

    fprintf('Settling time at 2%%: %.2fs. ', tas2);
    fprintf('Percent overshoot: %.2f%%\n', OS);
end
