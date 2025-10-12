%% PLOT FIGURE SETTINGS
fsa     = 14;             % axis fontsize
fsl     = 16;             % label fontsize
fsleg	= 14;		      % legend fontsize
font    = 'Times';        % font type

%%
if tf <= 60
    fprintf('Simulation duration: %.0f seconds.\n', tf)
else
    fprintf('Simulation duration: %.0f minutes.\n', tf / 60)
end

%% Joint torques
tau1 = reshape(tau(1,1,:), 1, []);
tau2 = reshape(tau(2,1,:), 1, []);

figure(1)
subplot(211), plot(tempo, tau1), grid on
xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('\tau_1 [Nm]', 'fontsize', fsl, 'FontName', font)
ylim([min(tau1), max(tau1)]), ax = gca; ax.YMinorGrid = 'on'; ax.YMinorTick = 'on';
ax.YTick = linspace(min(ylim), max(ylim), 5); ax.YAxis.TickLabelFormat = '%.0f';

subplot(212), plot(tempo, tau2), grid on
xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('\tau_2 [Nm]', 'fontsize', fsl, 'FontName', font)
sgtitle('Joint torques', 'fontsize', fsl)
ylim([min(tau2), max(tau2)]), ax = gca; ax.YMinorGrid = 'on'; ax.YMinorTick = 'on';
ax.YTick = linspace(min(ylim), max(ylim), 5); ax.YAxis.TickLabelFormat = '%.0f';

%% Joint variables
q1 = reshape(q(1,1,:), 1, []);
q2 = reshape(q(2,1,:), 1, []);

figure(2)
subplot(211), plot(tempo, q1), hold on, plot(tempo, q1ref), hold off
grid on, xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$q_1 [rad]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
legend({'Position', 'Reference'}, 'Interpreter','latex')	
legend('boxon'), set(legend, 'FontName', font, 'FontSize', fsleg)
legend('Location','best')

subplot(212), plot(tempo, q2), hold on, plot(tempo, q2ref), hold off
grid on, xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$q_2 [rad]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
legend({'Position', 'Reference'}, 'Interpreter','latex')	
legend('boxon'), set(legend, 'FontName', font, 'FontSize', fsleg)
legend('Location','best')
sgtitle('Joint variables', 'fontsize', fsl)

%% Joint velocities
qd1 = reshape(qd(1,1,:), 1, []);
qd2 = reshape(qd(2,1,:), 1, []);

figure(3)
subplot(211), plot(tempo, qd1), hold on, plot(tempo, qd1ref), hold off
grid on, xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$\dot{q_1} [rad/s]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
legend({"Velocity", 'Reference'}, 'Interpreter','latex')	
legend('boxon'), set(legend, 'FontName', font, 'FontSize', fsleg)
legend('Location','best')

subplot(212), plot(tempo, qd2), hold on, plot(tempo, qd2ref), hold off
grid on, xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$\dot{q_2} [rad/s]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
legend({"Velocity", 'Reference'}, 'Interpreter','latex')	
legend('boxon'), set(legend, 'FontName', font, 'FontSize', fsleg)
legend('Location','best')
sgtitle("Joint velocities", 'fontsize', fsl)

%% Joint accelerations
qdd1 = reshape(qdd(1,1,:), 1, []);
qdd2 = reshape(qdd(2,1,:), 1, []);

figure(4)
subplot(211), plot(tempo, qdd1), hold on, plot(tempo, qdd1ref), hold off
grid on, xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$\ddot{q_1} [rad/s^2]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
legend({'Acceleration', 'Reference'}, 'Interpreter','latex')	
legend('boxon'), set(legend, 'FontName', font, 'FontSize', fsleg)
legend('Location','best'), ylim([min(qdd1), max(qdd1)])
ax = gca; ax.YMinorGrid = 'on'; ax.YMinorTick = 'on';
ax.YTick = linspace(min(ylim), max(ylim), 5); ax.YAxis.TickLabelFormat = '%.0f';

subplot(212), plot(tempo, qdd2), hold on, plot(tempo, qdd2ref), hold off
grid on, xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$\ddot{q_2} [rad/s^2]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
legend({'Acceleration', 'Reference'}, 'Interpreter','latex')	
legend('boxon'), set(legend, 'FontName', font, 'FontSize', fsleg)
legend('Location','best'), ylim([min(qdd2), max(qdd2)])
sgtitle('Joint accelerations', 'fontsize', fsl)
ax = gca; ax.YMinorGrid = 'on'; ax.YMinorTick = 'on';
ax.YTick = linspace(min(ylim), max(ylim), 5); ax.YAxis.TickLabelFormat = '%.0f';

%% Position error norm
figure(5)
plot(tempo, pos_err_norm), grid on
xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$\Vert \tilde{q} \Vert [rad]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
title("Position error norm", 'fontsize', fsl)

%% Parametric error norms
figure(6)
plot(tempo, param_err_norm), grid on
xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('||parametric error||', 'fontsize', fsl, 'FontName', font)
title("Parametric error norm", 'fontsize', fsl)

%% Reference trajectories
figure(7)
subplot(321), plot(tempo, q1ref), grid on, set(gca, 'fontsize', fsa)
xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$q_1 [rad]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
ax = gca; ax.YTick = linspace(min(q1ref), max(q1ref), 4); ax.YAxis.TickLabelFormat = '%.2f';
ax.XTick = linspace(min(tempo), max(tempo), 5); ax.XAxis.TickLabelFormat = '%.1f';

subplot(323), plot(tempo, qd1ref), grid on, set(gca, 'fontsize', fsa)
xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$\dot{q_1} [rad/s]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
ax = gca; ax.YTick = linspace(min(qd1ref), max(qd1ref), 4); ax.YAxis.TickLabelFormat = '%.2f';
ax.XTick = linspace(min(tempo), max(tempo), 5); ax.XAxis.TickLabelFormat = '%.1f';

subplot(325), plot(tempo, qdd1ref), grid on, set(gca, 'fontsize', fsa)
xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$\ddot{q_1} [rad/s^2]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
ax = gca; ax.YTick = linspace(min(qdd1ref), max(qdd1ref), 4); ax.YAxis.TickLabelFormat = '%.2f';
ax.XTick = linspace(min(tempo), max(tempo), 5); ax.XAxis.TickLabelFormat = '%.1f';

subplot(322), plot(tempo, q2ref), grid on, set(gca, 'fontsize', fsa)
xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$q_2 [rad]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
ax = gca; ax.YTick = linspace(min(q2ref), max(q2ref), 4); ax.YAxis.TickLabelFormat = '%.2f';
ax.XTick = linspace(min(tempo), max(tempo), 5); ax.XAxis.TickLabelFormat = '%.1f';

subplot(324), plot(tempo, qd2ref), grid on, set(gca, 'fontsize', fsa)
xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$\dot{q_2} [rad/s]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
ax = gca; ax.YTick = linspace(min(qd2ref), max(qd2ref), 4); ax.YAxis.TickLabelFormat = '%.2f';
ax.XTick = linspace(min(tempo), max(tempo), 5); ax.XAxis.TickLabelFormat = '%.1f';

subplot(326), plot(tempo, qdd2ref), grid on, set(gca, 'fontsize', fsa)
xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$\ddot{q_2} [rad/s^2]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
ax = gca; ax.YTick = linspace(min(qdd2ref), max(qdd2ref), 4); ax.YAxis.TickLabelFormat = '%.2f';
ax.XTick = linspace(min(tempo), max(tempo), 5); ax.XAxis.TickLabelFormat = '%.1f';

sgtitle('References', 'fontsize', fsl)

%% Estimated parameters
pi_hat = squeeze(pi_hat);
delta = pi_t(:, 2:end) - pi_hat';

figure(8)
for i = 1 : 8
    subplot(4, 2, i), plot(tempo, delta(:, i))
    ylabel(strcat('\Delta_', num2str(i)), 'fontsize', fsl, 'FontName', font)
    xlabel('Time [s]', 'fontsize', fsl, 'FontName', font), grid on
end
sgtitle('Difference between estimated \pi and true \pi', 'fontsize', fsl)

%% Velocity error norm
figure(9)
plot(tempo, vel_err_norm), grid on
xlabel('Time [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$\Vert \tilde{\dot{q}} \Vert [rad/s]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
title("Velocity error norm", 'fontsize', fsl)

%% TO REPRESENT THE MANIPULATOR
figure("Color", "w")
hPlot = helperRobotEnvironment(Length1 = a1, Length2 = a1);
hPlot.Theta1 = qi(1); hPlot.Theta2 = qi(2); hPlot.xf = qf;

for k = 1 : nc
    hPlot.Theta1 = q1(k);
    hPlot.Theta2 = q2(k);
    drawnow limitrate
end

%% USEFUL RESULTS
fprintf('Maximum position error (norm): %.3frad.\n', max(pos_err_norm))
fprintf('Position error (norm) at t=tf: %erad.\n', pos_err_norm(end))
fprintf('Maximum velocity error (norm): %.3frad/s.\n', max(vel_err_norm))
fprintf('Velocity error (norm) at t=tf: %erad/s.\n', vel_err_norm(end))
