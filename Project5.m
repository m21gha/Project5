classdef Project5
%This is the main class for project 5: 3D reconsutrction using RGB-D camera
%and EM sensor created by
%Megha Martin - 14273674
%Pavlin Rodrigues - 13958044
%Bhupesh Guddi - 13877446


%#ok<*NASGU>
%#ok<*NOPRT>
%#ok<*TRYNC>  
 methods
      function self = Project5()
          self.calibration()
          
                  
        end
  end


    methods (Static)
        function calibration(self)

            %calibration bag
            bag1 = rosbag('CalibNew_360.bag');
            
            %Selecting image raw topic
            rgbRawTopics = select(bag1,'Topic', '/camera/color/image_raw');

            %read in TSV file
            emSensor = readtable('/Documents/Sensors and Control/Group Project/bags/forCali_GroundTruth_new360.txt');
            %selecting the Rz	Ry	Rx	Tx	Ty	Tz data
            emSensorData = emSensor(:,13:18);
            %time
            emSensorTime = emSensor(:,10);

            % Initialize a cell array to store synchronized data
            %synchronizedData = cell(height(rgbRawTopics.MessageList), 2);
            synchronizedData = cell(height(emSensorTime), 2);

                % Iterate through messages on the image topic
                for i = 1:70
                    msg = readMessages(rgbRawTopics, i);
                
                    % Extract timestamp from the image message
                    %imageTimestamp = msg{1}.Header.Stamp.Sec + msg{1}.Header.Stamp.Nsec * 1e-9;
                    imageTimestamp = emSensorTime{i,1};
    
                    % Find the closest EM sensor pose in the calibration data
                    %find the pose at timestap
                    [~, idx] = min(abs(emSensor.Var10 - imageTimestamp));
                    timestampPose = emSensorData(idx, :);
    
                    % Store synchronized data along with the timestamp
                    synchronizedData{i, 1} = imageTimestamp;    % Timestamp from the image message
                    synchronizedData{i, 2} = timestampPose;       % Corresponding EM sensor pose
                    %emtransformation =  emSensorData(idx, :);
    
                end
            
            
            calibrationResults = load('Calib_Results.mat');  % Load calibration results

            % % Initialize an empty cell array to store calibrated data
            % calibratedData = cell(length(synchronizedData), 1);
            
            calibratedTranslations = cell(height(emSensorTime), 1);
            calibratedRotations = cell(height(emSensorTime), 1);
           
                for i = 1:30           %size(synchronizedData, 1)              
                    T_x = synchronizedData{i,2}.Var16;
                    T_y = synchronizedData{i,2}.Var17;
                    T_z = synchronizedData{i,2}.Var18;
                    R_roll = synchronizedData{i,2}.Var15 * pi / 180;
                    R_pitch =synchronizedData{i,2}.Var14 * pi / 180;
                    R_yaw = synchronizedData{i,2}.Var13 * pi / 180;
              
                    % Rotation matrix
                    R = eul2rotm([R_roll, R_pitch, R_yaw]);
                    T = [T_x; T_y; T_z];
    
                    H_timestamp = eye(4);
                    H_timestamp(1:3,1:3) = [R];
                    H_timestamp(4,:) = [0 0 0 1];
                    H_timestamp(1:3,4) = [T_x; T_y; T_z];
    
                    % Apply calibration 
                    roll = calibrationResults.(['omc_' num2str(i)])(1); % Access omc for the i-th image
                    pitch = calibrationResults.(['omc_' num2str(i)])(2);
                    yaw = calibrationResults.(['omc_' num2str(i)])(3);
                    
                    % Convert Euler angles to rotation matrix
                    R_calib = eul2rotm([roll, pitch, yaw]);
    
                    % Construct the homogeneous transformation matrix
                    H_calibration = eye(4); % Initialize as identity matrix
                    H_calibration(1:3, 1:3) = R_calib;
                    H_calibration(1:3, 4) = calibrationResults.(['Tc_' num2str(i)]); % Access Tc for the i-th image
    
    
                    H_calibrated = H_calibration * H_timestamp;
                    
                    % Extract calibrated translation and rotation
                    calibratedTranslations{i} = H_calibrated(1:3, 4)';
                    calibratedRotations{i} = rotm2eul(H_calibrated(1:3, 1:3));
    
                end

                % Calculate the average calibrated translations and rotations
                avgCalibratedTranslation = mean(cell2mat(calibratedTranslations), 1);
                avgCalibratedRotation = mean(cell2mat(calibratedRotations), 1);

                                
                                                        


        end



            function dataAcquisition(self)

                %Capture data from both the RGB-D
                % camera and the EM sensor simultaneously.
                % Topics to subscribe to may include color images, depth images,
                % EM sensor data, and camera transforms.

            end

            function poseEstimation()
                
                % Generate point clouds from the RGB-D camera data. 
                % You'll obtain both RGB data and depth data.
                % Fuse the RGB and depth data to create 3D point clouds for each frame.
            end

            function pointCloudGeneration()
                
                % Generate point clouds from the RGB-D camera data. 
                % You'll obtain both RGB data and depth data.
                % Fuse the RGB and depth data to create 3D point clouds for each frame.
            end


            function coordinateTransformation()
               
                % Transform the point clouds from the 
                % camera's frame to the global EM field generator coordinate frame.
                % This step aligns all the point clouds in a common global frame
            end

         
            

            

    function calibrationToolbox()
            
            %this is conductng calibration algorithim using the 
            %toolbox_calib provided by UTS
            bag1 = rosbag('CalibNew_360.bag');
            
            %Selecting image raw topic
            rgbRawTopics = select(bag1,'Topic', '/camera/color/image_raw');

            %Selecting images in the.bag from specfic timestamps from forCali_GroundTruth.txt
            
            timeStamps = emSensorTime; %make sure you have the emSensorTime in the workspace
            
            % Initialize an array to store the selected images
            selectedImages = cell(height(timeStamps), 1);

            %%

            % Calculate the conversion factor
            conversionFactor = rgbRawTopics.MessageList{1, 'Time'} / timeStamps{1, 1};
            
            % Scale the timestamps in timeStamps
            timeStamps{:, 1} = timeStamps{:, 1} * conversionFactor;

            %%
            
            % Iterate through the messages to extract images at the specified timestamps
            for i = 1:height(timeStamps)
                timestamp = timeStamps{i,1};
            
                % Find the message with the closest timestamp
                [~, idx] = min(abs(rgbRawTopics.MessageList{:, 'Time'} - timestamp));
            
                % Extract the image message
                msg = readMessages(rgbRawTopics, idx);
            
                % Convert the image message to a MATLAB image format (e.g., uint8 or double)
                % You might need to adjust this part based on the image message format
                image = readImage(msg{1}); % Assuming a single image per message
            
                % Store the selected image
                selectedImages{i} = image;
            end

            %Now saving those selected images to calibrate
            % Specify the directory where you want to save the .jpg files
            outputDirectory = '/home/meghatron/Documents/Sensors and Control/Group Project/CalibrationResults/rgb~image_raw'; % Change to your desired directory
            
            % Ensure the output directory exists
            if ~exist(outputDirectory, 'dir')
            mkdir(outputDirectory);
            end
            
            % Save selected images as .jpg files
            for i = 1:70
            % Construct the file name for the .png file (e.g., image1.png, image2.png, etc.)
            fileName = fullfile(outputDirectory, ['image' num2str(i) '.jpg']);
            
            % Save the image as a .png file
            imwrite(selectedImages{i}, fileName);
            
            % Display a message indicating the file was saved
            fprintf('Image %d saved as %s\n', i, fileName);
            end
            
            % Instructions for using toolbox_calib
  
                %to Calibrate the saved images
                %calib_gui
                %select "Standard"
                %select "image names"
                %type in the suffix e.g. (image)
                %type "j" for jpg
                %select "extract grid corners"
                %press enter for all images
                %leave wintx winty as default 
                %select automate for amount of squares
                %dx = 30  dy = 30
                %after selecting all corners for images
                %select "calibration"
                %to refine calib press "reproject images" for all
                %press "recompute corners"
                %press "calibration" again
                %press "save" once done to save results

        end

    end
end