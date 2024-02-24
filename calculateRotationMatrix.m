function T = calculateRotationMatrix(Omega1, Omega2)
    %CALCULATEROTATIONMATRIX Calculate the rotation matrix between two sets of angular velocities.
    %   T = calculateRotationMatrix(Omega1, Omega2) calculates the rotation matrix T
    %   that best aligns two sets of angular velocities Omega1 and Omega2, represented
    %   as N-by-3 matrices of floats. This implementation solves the orthogonal Procrustes problem.
    %
    % Inputs:
    %   Omega1 - N-by-3 matrix of floats, representing angular velocities in rad/s in the first coordinate system.
    %   Omega2 - N-by-3 matrix of floats, representing angular velocities in rad/s in the second coordinate system.
    %
    % Output:
    %   T - 3-by-3 matrix of floats, representing the best (leasr squares) rotation matrix between the two coordinate systems.

    % Calculate the matrix S
    S = transpose(Omega1) * Omega2;
    
    % Perform Singular Value Decomposition (SVD) on S
    [U, ~, V] = svd(S);
    
    % Calculate the rotation matrix T
    T = U * transpose(V);
    
    % Ensure T is a proper rotation matrix by checking its determinant
    % If det(T) is -1, adjust to ensure a right-handed coordinate system
    if det(T) < 0
        warning("det(T) < 0")
        V(:,end) = -V(:,end); % Negate the last column of V
        T = U * transpose(V); % Recalculate T with the adjusted V
    end
end
