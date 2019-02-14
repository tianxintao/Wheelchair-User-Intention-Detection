% Reading the radius of curvature calculated previously, and store the data
% in time and radius
fig = openfig('radius_01_30_small1.fig');
title("Radius of Curvature(unfiltered)");
xlabel("Time/s")
ylabel("Radius of curvature/m")
axObjs = fig.Children;
dataObjs = axObjs.Children;
time = dataObjs(1).XData;
radius = dataObjs(1).YData;

% Combine the sensor reading on two wheels and chair wrt. the same
% timestamp
leftWheelData = csvread('./SmallTurnData/01_30_small1_left.csv');
rightWheelData = csvread('./SmallTurnData/01_30_small1_right.csv');
chairData = csvread('./SmallTurnData/01_30_small1_chair.csv');
tStart = max([leftWheelData(1,1),rightWheelData(1,1),chairData(1,1)]);
tEnd = min([max(leftWheelData(:,1)),max(rightWheelData(:,1)),max(chairData(:,1))]);
leftWheelData = leftWheelData(1+(tStart - leftWheelData(1,1))/0.1:1+(tEnd - leftWheelData(1,1))/0.1,:);
rightWheelData = rightWheelData(1+(tStart - rightWheelData(1,1))/0.1:round(1+(tEnd - rightWheelData(1,1))/0.1),:);
chairData = chairData(1+(tStart - chairData(1,1))/0.1:1+(tEnd - chairData(1,1))/0.1,:);

% Define the threshold alpha and beta
thresholdAlpha = 0.1;
thresholdBeta = 0.35;
notMovingData = [];
straightData = [];
turningData = [];

figure;
hold on;

for t = 1:1:1+(tEnd-tStart)/0.1
    
    leftWheelAngSpeed = abs(leftWheelData(t,7));
    rightWheelAngSpeed = abs(rightWheelData(t,7));
    % Angular speed on both wheels are less than the threshold,
    % corresponds to remain still
    if(leftWheelAngSpeed < 0.1 && rightWheelAngSpeed < 0.1)
        notMovingData = [notMovingData,[time(t);radius(t)]];
    else
        if(t >= 3)
            L2Norm = (radius(t) - radius(t-1))^2+ (radius(t-1) - radius(t-2))^2;
            % Sum of squared distance larger than threshold, wheelchair is
            % going straight
            if(L2Norm > thresholdBeta)
                straightData = [straightData,[time(t);radius(t)]];
                
            % Less than the threshold, useful information
            else
                turningData = [turningData,[time(t);radius(t)]];
                
            end
            
        end
    end
    

end

% Make the plot
intentionFromVideo = rightWheelData(:,11);
plot(notMovingData(1,:),notMovingData(2,:),'r*','DisplayName','Wheel chair not moving');
plot(straightData(1,:),straightData(2,:),'b*','DisplayName','Straight Line');
plot(turningData(1,:),turningData(2,:),'g*','DisplayName','Turning');
plot(time,15*intentionFromVideo,'co','DisplayName','Intention defined from video');
legend
title("Radius of curvature");
xlabel("Time/s")
ylabel("Radius of curvature/m")
