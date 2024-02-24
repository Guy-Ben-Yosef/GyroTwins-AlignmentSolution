function [mutual_time, interp_Omega1, interp_Omega2] = interpolateOmega(time1, Omega1, time2, Omega2)
    %INTERPOLATEOMEGA Interpolates angular velocities at a common time scale.
    %   [mutual_time, interp_Omega1, interp_Omega2] = interpolateOmega(time1, Omega1, time2, Omega2)
    %   The function accepts two sets of time and angular velocity data, which may have different lengths and time scales.
    %
    %   The output mutual_time is a linearly spaced vector from 0 to the maximum end time found in either input time vector,
    %   with length L, where L is the maximum of the lengths of the input time vectors.
    %   The function uses linear interpolation to calculate the angular velocities (Omega1 and Omega2) at these mutual time points.
    %   If the mutual_time extends beyond the range of the input time vectors, extrapolation is used based on the nearest points.
    %
    % Inputs:
    %   time1 - m-by-1 vector of floats, representing time in seconds for the first dataset.
    %   Omega1 - m-by-3 matrix of floats, representing angular velocity in rad/s for the first dataset.
    %   time2 - n-by-1 vector of floats, representing time in seconds for the second dataset.
    %   Omega2 - n-by-3 matrix of floats, representing angular velocity in rad/s for the second dataset.
    %
    % Outputs:
    %   mutual_time - L-by-1 vector of floats, representing the interpolated time scale.
    %   interp_Omega1 - L-by-3 matrix of floats, representing the interpolated angular velocities for the first dataset.
    %   interp_Omega2 - L-by-3 matrix of floats, representing the interpolated angular velocities for the second dataset.
    %
    % See also interp1.
    
    % Calculate the length of the new time vector
    L = max(length(time1), length(time2));
    
    % Generate the mutual_time vector
    mutual_time = linspace(0, max(time1(end), time2(end)), L).';
    
    % Initialize interpolated Omega matrices
    interp_Omega1 = zeros(L, 3);
    interp_Omega2 = zeros(L, 3);
    
    % Perform linear interpolation for Omega1 and Omega2
    for i = 1:3
        interp_Omega1(:, i) = interp1(time1, Omega1(:, i), mutual_time, 'linear', 'extrap');
        interp_Omega2(:, i) = interp1(time2, Omega2(:, i), mutual_time, 'linear', 'extrap');
    end
end
