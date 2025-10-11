%% SETTING PLOT FIGURE
fsa     = 14;             % fontsize axis 14
fsl     = 16;             % fontsize labels 18
fsleg	= 14;		      % fontsize legenda
font    = 'Times';        % tipo di font

%%
if tf <= 60
    fprintf('Durata della simulazione: %.0f secondi.\n', tf)
else
    fprintf('Durata della simulazione: %.0f minuti.\n', tf / 60)
end

%% Coppie ai giunti
tau1 = reshape(tau(1,1,:), 1, []);
tau2 = reshape(tau(2,1,:), 1, []);

figure(1)
subplot(211), plot(tempo, tau1), grid on
xlabel('Tempo [s]', 'fontsize', fsl, 'FontName', font)
ylabel('\tau_1 [Nm]', 'fontsize', fsl, 'FontName', font)
ylim([min(tau1), max(tau1)]), ax = gca; ax.YMinorGrid = 'on'; ax.YMinorTick = 'on';
ax.YTick = linspace(min(ylim), max(ylim), 5); ax.YAxis.TickLabelFormat = '%.0f';

subplot(212), plot(tempo, tau2), grid on
xlabel('Tempo [s]', 'fontsize', fsl, 'FontName', font)
ylabel('\tau_2 [Nm]', 'fontsize', fsl, 'FontName', font)
sgtitle('Coppie ai giunti', 'fontsize', fsl)
ylim([min(tau2), max(tau2)]), ax = gca; ax.YMinorGrid = 'on'; ax.YMinorTick = 'on';
ax.YTick = linspace(min(ylim), max(ylim), 5); ax.YAxis.TickLabelFormat = '%.0f';

%% Variabili di giunto
q1 = reshape(q(1,1,:), 1, []);
q2 = reshape(q(2,1,:), 1, []);

figure(2)
subplot(211), plot(tempo, q1), hold on, plot(tempo, q1ref), hold off
grid on, xlabel('Tempo [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$q_1 [rad]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
legend({'Posizione', 'Riferimento'}, 'Interpreter','latex')	
legend('boxon'), set(legend, 'FontName', font, 'FontSize', fsleg)
legend('Location','best')

subplot(212), plot(tempo, q2), hold on, plot(tempo, q2ref), hold off
grid on, xlabel('Tempo [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$q_2 [rad]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
legend({'Posizione', 'Riferimento'}, 'Interpreter','latex')	
legend('boxon'), set(legend, 'FontName', font, 'FontSize', fsleg)
legend('Location','best')
sgtitle('Variabili di giunto', 'fontsize', fsl)

%% Velocità dei giunti
qd1 = reshape(qd(1,1,:), 1, []);
qd2 = reshape(qd(2,1,:), 1, []);

figure(3)
subplot(211), plot(tempo, qd1), hold on, plot(tempo, qd1ref), hold off
grid on, xlabel('Tempo [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$\dot{q_1} [rad/s]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
legend({"Velocita'", 'Riferimento'}, 'Interpreter','latex')	
legend('boxon'), set(legend, 'FontName', font, 'FontSize', fsleg)
legend('Location','best')

subplot(212), plot(tempo, qd2), hold on, plot(tempo, qd2ref), hold off
grid on, xlabel('Tempo [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$\dot{q_2} [rad/s]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
legend({"Velocita'", 'Riferimento'}, 'Interpreter','latex')	
legend('boxon'), set(legend, 'FontName', font, 'FontSize', fsleg)
legend('Location','best')
sgtitle("Velocita' dei giunti", 'fontsize', fsl)

%% Accelerazioni dei giunti
qdd1 = reshape(qdd(1,1,:), 1, []);
qdd2 = reshape(qdd(2,1,:), 1, []);

figure(4)
subplot(211), plot(tempo, qdd1), hold on, plot(tempo, qdd1ref), hold off
grid on, xlabel('Tempo [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$\ddot{q_1} [rad/s^2]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
legend({'Accelerazione', 'Riferimento'}, 'Interpreter','latex')	
legend('boxon'), set(legend, 'FontName', font, 'FontSize', fsleg)
legend('Location','best'), ylim([min(qdd1), max(qdd1)])
ax = gca; ax.YMinorGrid = 'on'; ax.YMinorTick = 'on';
ax.YTick = linspace(min(ylim), max(ylim), 5); ax.YAxis.TickLabelFormat = '%.0f';

subplot(212), plot(tempo, qdd2), hold on, plot(tempo, qdd2ref), hold off
grid on, xlabel('Tempo [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$\ddot{q_2} [rad/s^2]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
legend({'Accelerazione', 'Riferimento'}, 'Interpreter','latex')	
legend('boxon'), set(legend, 'FontName', font, 'FontSize', fsleg)
legend('Location','best'), ylim([min(qdd2), max(qdd2)])
sgtitle('Accelerazioni dei giunti', 'fontsize', fsl)
ax = gca; ax.YMinorGrid = 'on'; ax.YMinorTick = 'on';
ax.YTick = linspace(min(ylim), max(ylim), 5); ax.YAxis.TickLabelFormat = '%.0f';

%% Norma dell'errore di posizione
figure(5)
plot(tempo, pos_err_norm), grid on
xlabel('Tempo [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$\Vert \tilde{q} \Vert [rad]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
title("Norma dell'errore di posizione", 'fontsize', fsl)

%% Norme dell'errore parametrico
figure(6)
plot(tempo, param_err_norm), grid on
xlabel('Tempo [s]', 'fontsize', fsl, 'FontName', font)
ylabel('||errore parametrico||', 'fontsize', fsl, 'FontName', font)
title("Norma dell'errore parametrico", 'fontsize', fsl)

%% Traiettorie di riferimento
figure(7)
subplot(321), plot(tempo, q1ref), grid on, set(gca, 'fontsize', fsa)
xlabel('Tempo [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$q_1 [rad]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
ax = gca; ax.YTick = linspace(min(q1ref), max(q1ref), 4); ax.YAxis.TickLabelFormat = '%.2f';
ax.XTick = linspace(min(tempo), max(tempo), 5); ax.XAxis.TickLabelFormat = '%.1f';

subplot(323), plot(tempo, qd1ref), grid on, set(gca, 'fontsize', fsa)
xlabel('Tempo [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$\dot{q_1} [rad/s]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
ax = gca; ax.YTick = linspace(min(qd1ref), max(qd1ref), 4); ax.YAxis.TickLabelFormat = '%.2f';
ax.XTick = linspace(min(tempo), max(tempo), 5); ax.XAxis.TickLabelFormat = '%.1f';

subplot(325), plot(tempo, qdd1ref), grid on, set(gca, 'fontsize', fsa)
xlabel('Tempo [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$\ddot{q_1} [rad/s^2]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
ax = gca; ax.YTick = linspace(min(qdd1ref), max(qdd1ref), 4); ax.YAxis.TickLabelFormat = '%.2f';
ax.XTick = linspace(min(tempo), max(tempo), 5); ax.XAxis.TickLabelFormat = '%.1f';

subplot(322), plot(tempo, q2ref), grid on, set(gca, 'fontsize', fsa)
xlabel('Tempo [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$q_2 [rad]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
ax = gca; ax.YTick = linspace(min(q2ref), max(q2ref), 4); ax.YAxis.TickLabelFormat = '%.2f';
ax.XTick = linspace(min(tempo), max(tempo), 5); ax.XAxis.TickLabelFormat = '%.1f';

subplot(324), plot(tempo, qd2ref), grid on, set(gca, 'fontsize', fsa)
xlabel('Tempo [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$\dot{q_2} [rad/s]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
ax = gca; ax.YTick = linspace(min(qd2ref), max(qd2ref), 4); ax.YAxis.TickLabelFormat = '%.2f';
ax.XTick = linspace(min(tempo), max(tempo), 5); ax.XAxis.TickLabelFormat = '%.1f';

subplot(326), plot(tempo, qdd2ref), grid on, set(gca, 'fontsize', fsa)
xlabel('Tempo [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$\ddot{q_2} [rad/s^2]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
ax = gca; ax.YTick = linspace(min(qdd2ref), max(qdd2ref), 4); ax.YAxis.TickLabelFormat = '%.2f';
ax.XTick = linspace(min(tempo), max(tempo), 5); ax.XAxis.TickLabelFormat = '%.1f';

sgtitle('Riferimenti', 'fontsize', fsl)

%% Parametri stimati
pi_hat = squeeze(pi_hat);
delta = pi_t(:, 2:end) - pi_hat';

figure(8)
for i = 1 : 8
    subplot(4, 2, i), plot(tempo, delta(:, i))
    ylabel(strcat('\Delta_', num2str(i)), 'fontsize', fsl, 'FontName', font)
    xlabel('Tempo [s]', 'fontsize', fsl, 'FontName', font), grid on
end
sgtitle('Differenza tra \pi stimato vs \pi vero', 'fontsize', fsl)

%% Norma dell'errore di velocità
figure(9)
plot(tempo, vel_err_norm), grid on
xlabel('Tempo [s]', 'fontsize', fsl, 'FontName', font)
ylabel('$\Vert \tilde{\dot{q}} \Vert [rad/s]$', 'Interpreter', 'latex', 'FontSize', fsl, 'FontName', font)
title("Norma dell'errore di velocita'", 'fontsize', fsl)

%% PER RAPPRESENTARE IL MANIPOLATORE
figure("Color", "w")
hPlot = helperRobotEnvironment(Length1 = a1, Length2 = a1);
hPlot.Theta1 = qi(1); hPlot.Theta2 = qi(2); hPlot.xf = qf;

for k = 1 : nc
    hPlot.Theta1 = q1(k);
    hPlot.Theta2 = q2(k);
    drawnow limitrate
end

%% RISULTATI UTILI
fprintf('Massimo errore di posizione in norma: %.3frad.\n', max(pos_err_norm))
fprintf('Errore di posizione in norma per t=tf: %erad.\n', pos_err_norm(end))
fprintf('Massimo errore di velocità in norma: %.3frad/s.\n', max(vel_err_norm))
fprintf('Errore di velocità in norma per t=tf: %erad/s.\n', vel_err_norm(end))
