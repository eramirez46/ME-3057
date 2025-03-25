function [ indices ] = segmentData( x, y )
%segmentData() plots data x and y and allows the user to select on the
%   figure where they would like to divide the data into segments. Returns 
%   the indices for the start and end of each data segment. Assumes that x
%   is sorted, either ascending or descending.
% Created by Peter Griffiths 9/19/2018
% Modified 9/24/2018 - x can be ascending or descending

% Loop until user is satisfied with data selection
flag = 1; % 1 user wants to collect data, 0 good to go
while flag
    % Plot data set for user to select boundaries on
    figure; dataFig = gcf; plot(x, y, '.');
    grid on; grid minor;
    xlabel(inputname(1)); ylabel(inputname(2));
    
    % Print directions for data selection by user
    fprintf('Select points for segment boundaries on figure\n Press ENTER when done\n');    
    % Call function to select points
    [X,Y] = getpts(dataFig); % X and Y points selected by user (not necessarily data points)
    
    % Get number of points selected
    numPts = length(X);
    % Check if odd (user did not select end point)
    if(mod(numPts,2)) 
       % Use largest value as last point
       X(end+1) = max(x);
       Y(end+1) = y(x == X(end));
    end
    numPts = length(X); % Update number of data points selected

    % Calculate indices of data from selections
    numSegments = numPts/2;
    indices = zeros(numSegments,2);
    for i = 1:2:numPts-1
        current = ceil(i/2);
        % Find closest values to selections
        [dist1, index1] = min(abs(x-X(i)));     
        [dist2, index2] = min(abs(x-X(i+1)));
        % Sort indices
        if ( index2(1) > index1(1) )
            indices(current,1) = index1(1);
            indices(current,2) = index2(1);
        else
            indices(current,1) = index2(1);
            indices(current,2) = index1(1);
        end
    end

    % Plot selected data for user to see data segments
    hold all;    
    for current = 1:numSegments
        i = indices(current,1):indices(current,2);
        plot(x(i), y(i), 'o');        
    end
    legend('Data', 'Segments');
    
    % Check if user is satisfied
    if (input('Save current selection (Y/N)?: ', 's') == 'Y')
        flag = 0; % Exit loop and return indices
    else
        close gcf % Close figure and try again
    end
end

end

