function [indices] = segmentData(x, y)
    % segmentData() plots data x and y and allows the user to select where
    % they would like to divide the data into segments using a polygon tool.
    % Returns the indices for the start and end of each data segment.
    % Assumes that x is sorted, either ascending or descending.
    
    flag = 1; % 1 user wants to collect data, 0 good to go
    while flag
        % Plot data set for user to select boundaries on
        figure; dataFig = gcf; plot(x, y, '.');
        grid on; grid minor;
        xlabel(inputname(1)); ylabel(inputname(2));
        
        % Print directions for data selection by user
        fprintf('Select regions for segment boundaries on figure\n');
        fprintf('Use the polygon tool and double-click to finish the selection.\n');
        
        % Use the polygon ROI for selecting segments
        roi = drawpolygon('Label','Select Segment');
        wait(roi);  % Wait until the user finishes selection
        
        % Get the vertices of the polygon
        polygonVertices = roi.Position;  % Nx2 matrix [x, y] coordinates
        
        % Number of points selected (must be even)
        numPts = size(polygonVertices, 1);
        
        % If the number of points is odd, add the max value as the endpoint
        if mod(numPts, 2)
            polygonVertices(end + 1, :) = [max(x), y(x == max(x))];
            numPts = numPts + 1;
        end
        
        % Initialize indices array
        numSegments = numPts / 2;
        indices = zeros(numSegments, 2);
        
        % Find closest points in x to the selected points
        for i = 1:2:numPts
            [~, idx1] = min(abs(x - polygonVertices(i, 1)));
            [~, idx2] = min(abs(x - polygonVertices(i + 1, 1)));
            
            % Sort indices to ensure correct order (ascending or descending)
            if idx1 > idx2
                indices(ceil(i / 2), :) = [idx2, idx1];
            else
                indices(ceil(i / 2), :) = [idx1, idx2];
            end
        end
        
        % Plot selected data for user to see segments
        hold on;
        for i = 1:numSegments
            segmentIndices = indices(i, 1):indices(i, 2);
            plot(x(segmentIndices), y(segmentIndices), 'o');
        end
        legend('Data', 'Selected Segments');
        
        % Check if user is satisfied
        if input('Save current selection (Y/N)?: ', 's') == 'Y'
            flag = 0; % Exit loop and return indices
        else
            close(dataFig); % Close figure and try again
        end
    end
end
