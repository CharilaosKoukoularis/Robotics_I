% Ρομποτική Ι
% 2η Σειρά Ασκήσεων
% 13/1/2024

%% Άσκηση 2.1

% Define symbolic variables
syms q1 q2 q3 l1 l2      real

% Transformation matrices
A1_0 = [cos(q1), 0, sin(q1), l1*sin(q1);
        0, 1, 0, 0;
        -sin(q1), 0, cos(q1), l1*cos(q1);
        0, 0, 0, 1];

A2_1 = [cos(q2), 0, sin(q2), l2*sin(q2);
        0, 1, 0, 0;
        -sin(q2), 0, cos(q2), l2*cos(q2);
        0, 0, 0, 1];

A3_2 = [1, 0, 0, 0;
        0, 1, 0, q3;
        0, 0, 1, 0;
        0, 0, 0, 1];

% Display the matrices
disp('A1^0(q1):');
disp(A1_0);

disp('A2^1(q2):');
disp(A2_1);

disp('A3^2(q3):');
disp(A3_2);

% Define c_{12} and s_{12}
c12 = cos(q1 + q2);
s12 = sin(q1 + q2);

% Transformation matrix A2^0(q1, q2)
A2_0 = [c12, 0, s12, l1*sin(q1) + l2*s12;
        0, 1, 0, 0;
        -s12, 0, c12, l1*cos(q1) + l2*c12;
        0, 0, 0, 1];

% Display the matrix
disp('A2^0(q1, q2):');
disp(A2_0);


% Transformation matrix A2^0(q1, q2)
A3_0 = [c12, 0, s12, l1*sin(q1) + l2*s12;
        0, 1, 0, q3;
        -s12, 0, c12, l1*cos(q1) + l2*c12;
        0, 0, 0, 1];

% Display the matrix
disp('A3^0(q1, q2, q3):');
disp(A3_0);


bx = [0 0 1;
      0 0 0;
     -1 0 0];

bx * A3_0(1:3,4)

bx * A3_1(1:3,4)

bx * A1_0(1:3,1:3) * A3_1(1:3,4)

%% Jacobian
% Calculate the elements of the Jacobian matrix
J_L = [l1*cos(q1) + l2*cos(q1 + q2), l2*cos(q1 + q2), 0;
       0, 0, 1;
      -l1*sin(q1) - l2*sin(q1 + q2), -l2*sin(q1 + q2), 0];

% Display the Jacobian matrix
disp('det(J_L(q1, q2, q3)):');
disp(det(J_L))
