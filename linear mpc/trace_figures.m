%% PLOT FIGURE SETTINGS
fsa     = 14;             % axis fontsize
fsl     = 16;             % label fontsize
fsc     = 14;             % comment fontsize
fsleg	= 14;	      % legend fontsize
font    = 'Times';        % font type

%% PLOT RESULTS

duration = sum(c_history);
if duration <= 60
    fprintf('\nSimulation duration: %.0f seconds.\n', duration)
else
    fprintf('\nSimulation duration: %.0f minutes.\n', duration / 60)
end

%% CONTROL INPUTS
figure(1)
for i = 1 : nu
    subplot(nu, 1, i), stairs(tempo, u_history(:, i)), grid on
    set(gca, 'fontsize', fsa), xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
    ylabel(strcat('\tau_', num2str(i), ' [Nm]'), 'fontsize', fsl, 'FontName', font)
    ylim([min(u_history(:, i)), max(u_history(:, i))]), ax = gca; 
    ax.YMinorGrid = 'on'; ax.YMinorTick = 'on'; 
    ax.YTick = linspace(min(ylim), max(ylim), 5); ax.YAxis.TickLabelFormat = '%.2f';
end
sgtitle('Control inputs over time', 'fontsize', fsl)

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
    ylim([min(y_history(:, i)), max(y_history(:, i))]), ax = gca; 
    ax.YMinorGrid = 'on'; ax.YMinorTick = 'on'; 
    ax.YTick = linspace(min(ylim), max(ylim), 5); ax.YAxis.TickLabelFormat = '%.2f';
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
    ylim([min(y_history(:, i)), max(y_history(:, i))]), ax = gca; 
    ax.YMinorGrid = 'on'; ax.YMinorTick = 'on'; 
    ax.YTick = linspace(min(ylim), max(ylim), 5); ax.YAxis.TickLabelFormat = '%.2f';
end
sgtitle('Outputs vs references over time', 'fontsize', fsl)

%% JOINT ACCELERATIONS
xd = [];
for k = 1 : nc
    xd(k, :) = StateFcn(x_history(k, :)', u_history(k, :)');
end
figure(4)
legend_text = {'$\ddot{q}$', 'r'}; 
for i = 1 : 2
    subplot(2, 1, i), stairs(tempo, xd(:, i+2)), hold on
    stairs(tempo, qdd(i, :)), hold off, grid on
    set(gca, 'fontsize', fsa), xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
    ylabel(['$\ddot{q}_{', num2str(i), '}$ [rad/s$^2$]'], ...
        'FontSize', fsl, 'FontName', font, 'Interpreter', 'latex')
    legend(legend_text, 'Interpreter','latex'), legend('boxon')
    set(legend, 'FontName', font, 'FontSize', fsleg), legend('Location','best')
    ylim([min(xd(:, i+2)), max(xd(:, i+2))]), ax = gca; ax.YMinorGrid = 'on'; 
    ax.YMinorTick = 'on'; ax.YTick = linspace(min(ylim), max(ylim), 5); 
    ax.YAxis.TickLabelFormat = '%.2f';
end
sgtitle('Accelerations vs references over time', 'fontsize', fsl)

%% COST FUNCTION
figure(5)
plot(tempo, v_history), grid on
title("Cost function over time", 'fontsize', fsl)
set(gca, 'fontsize', fsa), xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('V(k)', 'fontsize', fsl, 'FontName', font)

%% COMPUTATION TIME
ts = Tc * ones(length(tempo));
figure(6)
plot(tempo, c_history), hold on, plot(tempo, ts, '--'), hold off, grid on
title("Computation time", 'fontsize', fsl)
set(gca, 'fontsize', fsa), xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
legend_text = {'Computation time', 'Sampling time'}; 
legend(legend_text, 'Interpreter','latex')	
legend('boxon'), set(legend, 'FontName', font, 'FontSize', fsleg)
legend('Location','best')

%% REFERENCE TRAJECTORIES
figure(7)
subplot(321), plot(tempo, q1), grid on, set(gca, 'fontsize', fsa)
xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$q_1 [rad]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
ax = gca; ax.YTick = linspace(min(q1), max(q1), 4); ax.YAxis.TickLabelFormat = '%.2f';
ax.XTick = linspace(min(tempo), max(tempo), 5);ax.XAxis.TickLabelFormat = '%.1f';

subplot(323), plot(tempo, qd1), grid on, set(gca, 'fontsize', fsa)
xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$\dot{q_1} [rad/s]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
ax = gca; ax.YTick = linspace(min(qd1), max(qd1), 4); ax.YAxis.TickLabelFormat = '%.2f';
ax.XTick = linspace(min(tempo), max(tempo), 5); ax.XAxis.TickLabelFormat = '%.1f';

subplot(325), plot(tempo, qdd1), grid on, set(gca, 'fontsize', fsa)
xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$\ddot{q_1} [rad/s^2]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
ax = gca; ax.YTick = linspace(min(qdd1), max(qdd1), 4); ax.YAxis.TickLabelFormat = '%.2f';
ax.XTick = linspace(min(tempo), max(tempo), 5); ax.XAxis.TickLabelFormat = '%.1f';

subplot(322), plot(tempo, q2), grid on, set(gca, 'fontsize', fsa)
xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$q_2 [rad]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
ax = gca; ax.YTick = linspace(min(q2), max(q2), 4); ax.YAxis.TickLabelFormat = '%.2f';
ax.XTick = linspace(min(tempo), max(tempo), 5); ax.XAxis.TickLabelFormat = '%.1f';

subplot(324), plot(tempo, qd2), grid on, set(gca, 'fontsize', fsa)
xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$\dot{q_2} [rad/s]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
ax = gca; ax.YTick = linspace(min(qd2), max(qd2), 4); ax.YAxis.TickLabelFormat = '%.2f';
ax.XTick = linspace(min(tempo), max(tempo), 5); ax.XAxis.TickLabelFormat = '%.1f';

subplot(326), plot(tempo, qdd2), grid on, set(gca, 'fontsize', fsa)
xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$\ddot{q_2} [rad/s^2]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
ax = gca; ax.YTick = linspace(min(qdd2), max(qdd2), 4); ax.YAxis.TickLabelFormat = '%.2f';
ax.XTick = linspace(min(tempo), max(tempo), 5); ax.XAxis.TickLabelFormat = '%.1f';

sgtitle('References', 'fontsize', fsl)

%% POSITION ERROR NORM
pos_err_norm = sqrt((y_history(:, 1) - r_history(:, 1)).^2 + ...
                (y_history(:, 2) - r_history(:, 2)).^2);
figure(8)
plot(tempo, pos_err_norm), grid on
title("Position error norm", 'fontsize', fsl)
set(gca, 'fontsize', fsa), xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$\Vert \tilde{q} \Vert [rad]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)

%% VELOCITY ERROR NORM
vel_err_norm = sqrt((y_history(:, 3) - r_history(:, 3)).^2 + ...
                (y_history(:, 4) - r_history(:, 4)).^2);
figure(9)
plot(tempo, vel_err_norm), grid on
title("Velocity error norm", 'fontsize', fsl)
set(gca, 'fontsize', fsa), xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$\Vert \tilde{\dot{q}} \Vert [rad/s]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)

%% TO REPRESENT THE MANIPULATOR
figure("Color", "w")
hPlot = helperRobotEnvironment(Length1 = a1, Length2 = a1);
hPlot.Theta1 = x0(1); hPlot.Theta2 = x0(2); hPlot.xf = [pi/2 pi/2]';

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
fprintf('Maximum cost function: %.4f.\n', max(v_history))
fprintf('Cost function at t=tf: %e.\n', v_history(end))