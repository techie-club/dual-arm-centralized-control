classdef helperRobotEnvironment < matlab.graphics.chartcontainer.ChartContainer & ...
        matlab.graphics.chartcontainer.mixin.Legend

    % HELPERROBOTENVIRONMENT Helper class for plotting a two-link robot
    % manipulator.
    %
    % Copyright 2023 The MathWorks, Inc.

    properties
        Theta1 = 0          % Joint angle of link 1
        Theta2 = 0          % Joint angle of link 2
        Length1 = 0.5        % Length of link 1
        Length2 = 0.5        % Length of link 2
        Width = 0.02        % Width of the links
        xf                  % Desired position
    end

    properties (Hidden)
        N = 100             % Number of vertices
        VerticesLink1       % Vertices of link 1
        VerticesLink2       % Vertices of link 2
        Pin1                % Pin 1 object
        Pin2                % Pin 2 object
    end

    properties(Access = private,Transient,NonCopyable)
        % Patch Object Properties
        Link1Object  (1,1) matlab.graphics.primitive.Patch
        Link2Object  (1,1) matlab.graphics.primitive.Patch
        Link1Object_ (1,1) matlab.graphics.primitive.Patch
        Link2Object_ (1,1) matlab.graphics.primitive.Patch
    end

    methods(Access = protected)
        function setup(obj)
            % Setup the plot
            % Get the axes
            ax = getAxes(obj);

            % Get 'lines' colormap
            cmap = lines(3);

            % Generate vertices for the base
            vBase = helperRobotEnvironment.getVerticesBase(.03, .04, obj.N);
            vBase = helperRobotEnvironment.Rot_z(-pi/2)*[vBase repmat([0 1], 2*obj.N, 1)].';

            % Set plot properties
            hold(ax,'on');
            box(ax,'on');

            % Add robot's base patch to the plot
            patch('Parent', ax, 'Vertices', vBase(1:2,:).', 'Faces', 1:2*obj.N, 'FaceColor', cmap(3,:), 'EdgeColor', cmap(3,:), 'FaceAlpha', 0.35, 'LineWidth', 1, 'DisplayName', 'Base');

            % Create Patch objects for robot links 1 and 2 (use xf)
            obj.Link1Object_ = patch('Parent', ax, 'Vertices', nan(2*obj.N,2), 'Faces', 1:2*obj.N, 'FaceColor', 'w', 'EdgeColor', 'k', 'FaceAlpha', 0.35, 'EdgeAlpha', 0.2, 'LineWidth', 1, 'DisplayName', 'Link 1-2 (Desired pos)');
            obj.Link2Object_ = patch('Parent', ax, 'Vertices', nan(2*obj.N,2), 'Faces', 1:2*obj.N, 'FaceColor', 'w', 'EdgeColor', 'k', 'FaceAlpha', 0.35, 'EdgeAlpha', 0.2, 'LineWidth', 1, 'DisplayName', 'Link 1-2 (Desired pos)');

            % Create Patch objects for robot links 1 and 2
            obj.Link1Object = patch('Parent', ax, 'Vertices', nan(2*obj.N,2), 'Faces', 1:2*obj.N, 'FaceColor', cmap(1,:), 'EdgeColor', cmap(1,:), 'FaceAlpha', 0.35, 'LineWidth', 1, 'DisplayName', 'Link 1');
            obj.Link2Object = patch('Parent', ax, 'Vertices', nan(2*obj.N,2), 'Faces', 1:2*obj.N, 'FaceColor', cmap(2,:), 'EdgeColor', cmap(2,:), 'FaceAlpha', 0.35, 'LineWidth', 1, 'DisplayName', 'Link 2');

            % Create Pin1 and Pin2 
            obj.Pin1 = rectangle("Parent", ax, "Position", [-1 -1 2 2]*.01, "Curvature", 1, 'FaceColor', cmap(1,:), 'EdgeColor', cmap(1,:), 'LineWidth', 1);
            obj.Pin2 = rectangle("Parent", ax, "Position", [-1 -1 2 2]*.01, "Curvature", 1, 'FaceColor', cmap(1,:), 'EdgeColor', cmap(1,:), 'LineWidth', 1);

            % Set additional figure settings
            lm = (obj.Length1 + obj.Length2)*1.1;
            axis(ax,'equal')
            set(ax, 'Xlim', [-lm lm]);
            hold(ax,'off')

            % Make legend visible
            obj.LegendVisible = 'on';
            
            obj.LegendVisible = 'off';
            set(ax, 'XTick', [], 'YTick', []);
        end

        function update(obj)
            % Updates the plot of a two-link robot based on the current
            % configuration of the robot.

            % Define rotation about z-axis function handle
            Rot_z = @(a) helperRobotEnvironment.Rot_z(a);
            % Define translation along x-axis function handle
            Trans_x = @(x) helperRobotEnvironment.Trans_x(x);

            % Get vertices of the link's geometry
            verticesLink1 = [helperRobotEnvironment.getVerticesLink(obj.Width, obj.Length1, obj.N) repmat([0 1], obj.N*2, 1)];
            verticesLink2 = [helperRobotEnvironment.getVerticesBase(obj.Width, obj.Length2, obj.N) repmat([0 1], obj.N*2, 1)];

            % Apply transformations 
            verticesLink1 = Rot_z(obj.Theta1)*verticesLink1.';
            verticesLink2 = Rot_z(obj.Theta1)*Trans_x(obj.Length1)*Rot_z(obj.Theta2)*verticesLink2.';

            % Update object vertices
            obj.Link1Object.Vertices = verticesLink1(1:2, :).';
            obj.Link2Object.Vertices = verticesLink2(1:2, :).';

            % Calculate and update pin 2 position
            pinPos = Rot_z(obj.Theta1)*Trans_x(obj.Length1);
            obj.Pin2.Position(1) = pinPos(1,4) - 0.01;
            obj.Pin2.Position(2) = pinPos(2,4) - 0.01;

            % Check if target configuration is provided
            if ~isempty(obj.xf)
                % Get vertices of the link's geometry
                verticesLink1 = [helperRobotEnvironment.getVerticesLink(obj.Width, obj.Length1, obj.N) repmat([0 1], obj.N*2, 1)];
                verticesLink2 = [helperRobotEnvironment.getVerticesBase(obj.Width, obj.Length2, obj.N) repmat([0 1], obj.N*2, 1)];

                % Apply transformations for target configuration
                verticesLink1 = Rot_z(obj.xf(1))*verticesLink1.';
                verticesLink2 = Rot_z(obj.xf(1))*Trans_x(obj.Length1)*Rot_z(obj.xf(2))*verticesLink2.';

                % Update object vertices for target configuration
                obj.Link1Object_.Vertices = verticesLink1(1:2, :).';
                obj.Link2Object_.Vertices = verticesLink2(1:2, :).';
            end
        end
    end

    methods (Static)
        function V = getVerticesLink(R, L, N)
            % Compute angles for the first and second half of the link
            angle1 = .5*linspace( pi, 3*pi, N);
            angle2 = .5*linspace(-pi, 1*pi, N);

            % Compute x and y-coordinates of the vertices
            x = [R*cos(angle1), R*cos(angle2)+L];
            y = [R*sin(angle1), R*sin(angle2)];

            % Combine x and y coordinates to form vertices matrix
            V = [x; y].';
        end

        function V = getVerticesBase(R,L,N)
            % Compute angles for the first and second half of the link
            angle1 = .5*linspace(pi,3*pi,N);
            angle2 = .5*linspace(-pi,pi,2);
            angle2 = repmat(angle2,1,N/2);

            % Compute x and y-coordinates of the vertices
            x = [R*cos(angle1), sort(R*cos(angle2))+L];
            y = [R*sin(angle1), sort(R*sin(angle2))];

            % Combine x and y coordinates to form vertices matrix
            V = [x; y].';
        end

        function out = Trans_x(a)
            % Translation matrix from y axes
            out = [eye(3) [a; 0; 0]; [0 0 0 1]];
        end

        function out = Rot_z(alpha)
            % Basic rotation matrix about the z-axes
            out = [...
                cos(alpha) -sin(alpha) 0 0; ...
                sin(alpha) cos(alpha) 0 0; ...
                0 0 1 0; ...
                0 0 0 1];
        end

        function simulinkPlot(x, xf, pvstate)
            % Wrapper function for Robot Environment in Simulink

            persistent hPlotSim

            if isempty(hPlotSim) || ~isvalid(hPlotSim)
                figure;
                hPlotSim = helperRobotEnvironment(Length1 = pvstate(1), Length2 = pvstate(5));
                
                % Set Initial angular position and desired state.
                hPlotSim.xf = xf;
            end

            hPlotSim.Theta1 = x(1);
            hPlotSim.Theta2 = x(2);
            drawnow limitrate
        end
    end
end