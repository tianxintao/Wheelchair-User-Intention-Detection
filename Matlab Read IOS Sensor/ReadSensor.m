m = mobiledev;
m.AccelerationSensorEnabled = 1;
m.AngularVelocitySensorEnabled = 1;
m.MagneticSensorEnabled = 1;
m.OrientationSensorEnabled = 1;
m.PositionSensorEnabled = 1;
m.Logging = 1;
%% Only run line 1 once
% prevAccCount = 0;
% prevAngCount = 0;
% prevMagCount = 0;
% prevOriCount = 0;
% prevPosCount = 0;

% while (1)
%     [a, t_a] = accellog(m);
%     [av,t_av] = angvellog(m);
%     [mf,t_mf] = magfieldlog(m);
%     [o,t_o] = orientlog(m);
%     [p,t_p] = poslog(m);
%     
%     
%     % plot acceleration
%     [row,col] = size(a);
% %     title("Measuring Acceleration on x,y,z axis");
%     
%     if(row > prevAccCount)
%         for i = (prevAccCount+1):row
%             ax = a(i,1);
%             ay = a(i,2);
%             az = a(i,3);
% %             figure(1);
% % 
% %             plot(t_a(i),ax,'b*');
% %             plot(t_a(i),ay,'r*');
% %             plot(t_a(i),az,'g*');
% %             legend("x axis","y axis","z axis");
%         end
%         prevAccCount = row;
%     end 
%     
%     
%     
%     % plot angular velocity
%     [row,col] = size(av);
%     
%     if(row > prevAngCount)
%         for i = (prevAngCount+1):row
%             avx = av(i,1);
%             avy = av(i,2);
%             avz = av(i,3);
%             figure(1);
% 
%             plot(t_av(i),avx,'b*');
%             plot(t_av(i),avy,'r*');
%             plot(t_av(i),avz,'g*');
%             legend("x axis","y axis","z axis");
% 
%         end
%         prevAngCount = row;
%     end 
%     
%     
%     % orientation
%     [row,col] = size(o);
%     
%     if(row > prevOriCount)
%         for i = (prevOriCount+1):row
%             ox = o(i,1);
%             oy = o(i,2);
%             oz = o(i,3);
%             t = t_o(i);
%         end
%         prevOriCount = row;
%     end 
%     
%     
%     
%     
% end

%% Save the data to csv for acceleration, angular velocity and orientation
[a, t_a] = accellog(m);
[av,t_av] = angvellog(m);
[mf,t_mf] = magfieldlog(m);
[o,t_o] = orientlog(m);
[p,t_p] = poslog(m);

[row1,~] = size(t_a);
[row2,~] = size(t_av);
[row3,~] = size(t_o);
len = min([row1,row2,row3]);
arrOutput = horzcat(t_a(1:len,:),a(1:len,:),av(1:len,:),o(1:len,:));
headers = {'Time','Acceleration X','Acceleration Y','Acceleration Z','Angular Velocity X','Angular Velocity Y','Angular Velocity Z','Yaw','Pitch','Roll'}
csvwrite_with_headers('Nov_11_16_myFile.csv',arrOutput,headers)
m.InitialTimestamp
% csvwrite('myFile.csv',arrOutput);



