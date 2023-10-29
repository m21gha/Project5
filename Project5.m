classdef Project5 %This is the main class for project 5: 3D reconsutrction using RGB-D camera
%#ok<*NASGU>
%#ok<*NOPRT>
%#ok<*TRYNC>  
 methods
      function self = Project5()
          %self.calibration()
          self.coordinatetransformation()
          self.displayComparisonImages()
          self.fusedPointCloud()
        end
  end


    methods (Static)
        function calibration(self)

            %calibration bag
            bag1 = rosbag('CalibNew_360.bag');
            
            %Selecting image raw topic
            rgbRawTopics = select(bag1,'Topic', '/camera/color/image_raw');

            %read in TSV file
            emSensor = readtable('forCali_GroundTruth_new360.txt');
            %selecting the Rz	Ry	Rx	Tx	Ty	Tz data
            emSensorData = emSensor(:,13:18);
            %time
            emSensorTime = emSensor(:,10);

            % Initialize a cell array to store synchronized data
            synchronizedData = cell(height(emSensorTime), 2);

                % Iterate through messages on the image topic
                for i = 1:70
                    msg = readMessages(rgbRawTopics, i);
                
                    % Extract timestamp from the image message
                    %imageTimestamp = msg{1}.Header.Stamp.Sec + msg{1}.Header.Stamp.Nsec * 1e-9;
                    imageTimestamp = emSensorTime{i,1};
    
                    %Find the closest EM sensor pose in the calibration data
                    %find the pose at timestap
                    [~, idx] = min(abs(emSensor.Var10 - imageTimestamp));
                    timestampPose = emSensorData(idx, :);
    
                    % Store synchronized data along with the timestamp
                    synchronizedData{i, 1} = imageTimestamp;    % Timestamp from the image message
                    synchronizedData{i, 2} = timestampPose;       % Corresponding EM sensor pose
    
                end
 
            calibrationResults = load('Calib_Results.mat');  % Load calibration results

            % % Initialize an empty cell array to store calibrated data
            calibratedTranslations = cell(height(emSensorTime), 1);
            calibratedRotations = cell(height(emSensorTime), 1);
           
                for i = 1:30%size(synchronizedData, 1)              
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

                %Calculate the average calibrated translations and rotations
                %avgCalibratedTranslation = mean(cell2mat(calibratedTranslations), 1)
                %avgCalibratedRotation = mean(cell2mat(calibratedRotations), 1)
                              
        end


        function coordinatetransformation(self)
                
            % Load a .npy file 
            depth_data = readNPY('depthimagesdepth_image_0.npy');
            
            % Camera intrinsic parameters from the calibrationResults
            fx = 696.631370276213829;
            fy = 688.430910512066930;
            cx = 343.7744401879735965;
            cy = 304.051147293626400;
            
            % Convert depth image to 3D point cloud
            [height, width] = size(depth_data);
            [Y, X] = ndgrid(1:height, 1:width);
            Z = double(depth_data) / 1000.0;  % Convert depth to meters
            X_3D = (X - cx) .* Z / fx;
            Y_3D = (Y - cy) .* Z / fy;
            
            % Create a 3D point cloud
            point_cloud = cat(3, X_3D, Y_3D, Z);
           
            % Display the point cloud using pcshow
            figure;
            pcshow(point_cloud);
            
            % Customize the point cloud visualization (optional)
            title('3D Point Cloud Visualization');
            xlabel('X-axis');
            ylabel('Y-axis');
            zlabel('Z-axis');
            
            view(0, -90); % Adjust the view as needed

        end

        function displayComparisonImages()
            % Load the original depth image
            original_depth_data = readNPY('depthimagesdepth_image_0.npy');  % Replace with the path to your original depth image
            
            % Load the filtered depth image
            filtered_depth_data = readNPY('filtered_depth1.npy');  % Replace with the path to your filtered depth image
            
            % Load the outlier-removed depth image
            outlier_removed_data = readNPY('filtered_depth1_outlier_removed.npy');  % Replace with the path to your outlier-removed depth image
            
            % Display the images side by side for comparison
            figure;
            
            % Display the original depth image
            subplot(1, 3, 1);
            imshow(original_depth_data, []);
            title('Original Depth Image');
            
            % Display the filtered depth image
            subplot(1, 3, 2);
            imshow(filtered_depth_data, []);
            title('Filtered Depth Image');
            
            % Display the outlier-removed depth image
            subplot(1, 3, 3);
            imshow(outlier_removed_data, []);
            title('Outlier-Removed Depth Image');
        end


         function fusedPointCloud(~)
            
             % Define the directory where your filtered depth data is stored
            filteredDataDir = 'F:\UTS\2023 subjects\2023 Semester 2 Spring\Sensors and Control for Mechatronic Systems\Group Project\Github\Project5\Datas\outlierRemovedDepthData';  % Replace with the actual directory
        
            % List all .npy files in the filtered data directory
            filteredDepthFiles = dir(fullfile(filteredDataDir, '*.npy'));
            
            %Define the directory where your depth data files are stored
            depthdataDir = 'F:\UTS\2023 subjects\2023 Semester 2 Spring\Sensors and Control for Mechatronic Systems\Group Project\Github\Project5\Datas\depthdata'; % Replace with the actual directory  
            % List all .npy files in the directory
            depthDataFiles = dir(fullfile(depthdataDir, 'depthimagesdepth_image_*.npy'));
           
             % Camera intrinsic parameters from the calibrationResults
            fx = 696.631370276213829;
            fy = 688.430910512066930;
            cx = 343.7744401879735965;
            cy = 304.051147293626400;
        
            % Create an empty point cloud to store all data
            fusedPointCloud = pointCloud(zeros(0, 3, 'single'));
        
            for i = 1:numel(depthDataFiles)
                % Load the depth data
                depth_data = readNPY(fullfile(depthdataDir, depthDataFiles(i).name));
        
                % Convert depth image to 3D point cloud
                [height, width] = size(depth_data);
                [Y, X] = ndgrid(1:height, 1:width);
                Z = double(depth_data) / 1000.0;  % Convert depth to meters
                X_3D = (X - cx) .* Z / fx;
                Y_3D = (Y - cy) .* Z / fy;
        
                % Create a 3D point cloud from the current data
                currentPointCloud = pointCloud(cat(3, X_3D, Y_3D, Z), 'Color', uint8(ones(height, width, 3)));
        
                % Merge the current point cloud with the fused point cloud
                fusedPointCloud = pcmerge(fusedPointCloud, currentPointCloud, 0.001); % Adjust the merge threshold
            end

        
            % Display the fused point cloud
            figure;
            pcshow(fusedPointCloud);
            fig = gcf; 
            fig.Color = 'white';
            title('Fused 3D Point Cloud');
            
            % Load and merge filtered depth data
            for i = 1:numel(filteredDepthFiles)
                % Load the filtered depth data from the filtered data directory
                filtered_depth_data = readNPY(fullfile(filteredDataDir, filteredDepthFiles(i).name));
        
                % Convert filtered depth image to 3D point cloud
                [height, width] = size(filtered_depth_data);
                [Y, X] = ndgrid(1:height, 1:width);
                Z = double(filtered_depth_data) / 1000.0;  % Convert depth to meters
                X_3D = (X - cx) .* Z / fx;
                Y_3D = (Y - cy) .* Z / fy;
        
                % Create a 3D point cloud from the current filtered depth data
                currentPointCloud = pointCloud(cat(3, X_3D, Y_3D, Z), 'Color', uint8(ones(height, width, 3)));
        
                % Merge the current point cloud with the fused point cloud
                fusedPointCloud = pcmerge(fusedPointCloud, currentPointCloud, 0.001); % Adjust the merge threshold
            end
        
            % Display the fused point cloud
            figure;
            pcshow(fusedPointCloud);
            fig = gcf; 
            fig.Color = 'white';
            title('Fused 3D Point Cloud');
    
        end   

        

%%
        function noiseReductionAndSave()

            % Specify the folder where your depth data files are located
            data_folder = 'F:\UTS\2023 subjects\2023 Semester 2 Spring\Sensors and Control for Mechatronic Systems\Group Project\Github\Project5\Datas\depthdata';
        
            % Get a list of all depth data files in the folder
            depth_data_files = dir(fullfile(data_folder, 'depthimagesdepth_image_*.npy'));
            
            %folder to save processed depth images
            output_folder = 'F:\UTS\2023 subjects\2023 Semester 2 Spring\Sensors and Control for Mechatronic Systems\Group Project\Github\Project5\Datas\filteredDepthData'; % Adjust the path
            if ~exist(output_folder, 'dir')
                mkdir(output_folder);
            end
        
            % Loop through each depth data file
            for i = 1:numel(depth_data_files)
                % Load depth data
                depth_data = readNPY(fullfile(depth_data_files(i).folder, depth_data_files(i).name));
        
                % Apply noise reduction ( Gaussian smoothing)
                % Apply Gaussian smoothing
                sigma = 2.0;  % Adjust the standard deviation as needed
                filtered_depth_data = imgaussfilt(depth_data, sigma); % Implement your noise reduction function
        
                % Save the processed depth image to the output folder
                output_filename = fullfile(output_folder, sprintf('filtered_depth%d.npy', i));
                writeNPY(filtered_depth_data, output_filename);
            end
               

        end

%%
        function outlierRemovalAndSave()
        
            % Define the folder where filtered depth files are located
            filtered_folder = 'F:\UTS\2023 subjects\2023 Semester 2 Spring\Sensors and Control for Mechatronic Systems\Group Project\Github\Project5\Datas\filteredDepthData'; % Adjust the path
            
            % Create a pattern to match specific file names (e.g., 'filtered_depth*.npy')
            file_pattern = 'filtered_depth*.npy';
            
            % List files in the folder that match the pattern
            filtered_depth_files = dir(fullfile(filtered_folder, file_pattern));

            %folder to save the outlier-removed depth images
            output_folder = 'F:\UTS\2023 subjects\2023 Semester 2 Spring\Sensors and Control for Mechatronic Systems\Group Project\Github\Project5\Datas\outlierRemovedDepthData'; % Adjust the path
            if ~exist(output_folder, 'dir')
                mkdir(output_folder);
            end
        
            % Define the neighborhood size for the median filter
            neighborhood_size = [3, 3]; % Adjust the size as needed
        
            % Loop through each filtered depth data file
            for i = 1:numel(filtered_depth_files)
                % Load filtered depth data
                filtered_depth_data = readNPY(fullfile(filtered_depth_files(i).folder, filtered_depth_files(i).name));
        
                % Apply median filtering for outlier removal
                outlier_removed_data = medfilt2(filtered_depth_data, neighborhood_size);
        
                % Save the outlier-removed depth image to the output folder
                [~, name, ~] = fileparts(filtered_depth_files(i).name);  % Extract file name without extension
                output_filename = fullfile(output_folder, [name, '_outlier_removed.npy']);
                writeNPY(outlier_removed_data, output_filename);
            end
        
        end


%%
    function calibrationToolboxAndSave()
            
            %this is conductng calibration algorithim using the 
            %toolbox_calib provided by UTS
            bag1 = rosbag('CalibNew_360.bag');
            
            %Selecting image raw topic
            rgbRawTopics = select(bag1,'Topic', '/camera/color/image_raw');

            %Selecting images in the.bag from specfic timestamps from forCali_GroundTruth.txt
            timeStamps = emSensorTime; %make sure you have the emSensorTime in the workspace
            
            % Initialize an array to store the selected images
            selectedImages = cell(height(timeStamps), 1);

            % Calculate the conversion factor
            conversionFactor = rgbRawTopics.MessageList{1, 'Time'} / timeStamps{1, 1};
            
            % Scale the timestamps in timeStamps
            timeStamps{:, 1} = timeStamps{:, 1} * conversionFactor;
            
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