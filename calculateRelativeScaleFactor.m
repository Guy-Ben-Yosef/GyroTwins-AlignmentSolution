function C = calculateRelativeScaleFactor(Omega1, Omega2)
    %CALCULATERELATIVESCALEFACTOR Calculate the relative scale factor matrix.
    %   C = calculateRelativeScaleFactor(Omega1, Omega2) calculates the relative
    %   scale factor matrix C between two sets of angular velocities Omega1
    %   and Omega2, represented as N-by-3 matrices of floats.
    %
    % Inputs:
    %   Omega1 - N-by-3 matrix of floats, representing angular velocities in rad/s.
    %   Omega2 - N-by-3 matrix of floats, representing angular velocities in rad/s.
    %
    % Output:
    %   C - 3-by-3 matrix of floats, representing the relative scale factor matrix.
    
    % Calculate matrices M and D
    M = transpose(Omega1) * Omega2;
    D = transpose(Omega1) * Omega1;
    
    % Calculate the square of matrix C
    C_squared = inv(D) * M * transpose(M) * inv(D);
    
    % Perform eigen-decomposition on C^2
    [U, Lambda] = eig(C_squared);
    
    % Calculate C from the square root of Lambda
    C = U * sqrt(Lambda) * inv(U);
end
