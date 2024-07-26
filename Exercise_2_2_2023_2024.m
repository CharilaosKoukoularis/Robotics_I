% Define symbolic variables
syms q1 q2 q3 q4 l1 l2 real

% Denavit-Hartenberg parameters
dhparams = [
    struct('d', l1 + q1, 'theta', 0, 'a', 0, 'alpha', 0);
    struct('d', 0, 'theta', q2, 'a', 0, 'alpha', sym(pi)/2);
    struct('d', 0, 'theta', q3, 'a', 0, 'alpha', -sym(pi)/2);
    struct('d', l2, 'theta', q4, 'a', 0, 'alpha', 0)
];

% cos(pi/2) = 6.12323399573677e-17
% sin(pi) = 1.22464679914735e-16
%
% Trigonometric function errors at pi or pi/2 such as sin(pi) or cos(pi/2)
% https://www.mathworks.com/matlabcentral/fileexchange/47894-trigonometric-function-errors-at-pi-or-pi-2-such-as-sin-pi-or-cos-pi-2#:~:text=It%20is%20because%20pi%20value,pi)%20is%20the%20exact%20pi.&text=There%20is%20another%20way%20without%20using%20symbolic%20toolbox.
% 
% pi value cannot be represented in floating-point number.
% sin(sym(pi)) returns 0. Note that sym(pi) is the exact pi.

% Display the Denavit-Hartenberg parameters
disp('Denavit-Hartenberg parameters:');
disp(dhparams);


%% 
for i = 1:4
    A(:,:,i) = [cos(dhparams(i).theta) -sin(dhparams(i).theta)*cos(dhparams(i).alpha)  sin(dhparams(i).theta)*sin(dhparams(i).alpha) dhparams(i).a*cos(dhparams(i).theta);
                sin(dhparams(i).theta)  cos(dhparams(i).theta)*cos(dhparams(i).alpha) -cos(dhparams(i).theta)*sin(dhparams(i).alpha) dhparams(i).a*sin(dhparams(i).theta);
                0                       sin(dhparams(i).alpha)                         cos(dhparams(i).alpha)                        dhparams(i).d;
                0                       0                                              0                                             1]
end

%%

% A^0_1(q1)
T(:,:,1) = A(:,:,1)

% A^0_2(q1,q2), A^0_3(q1,q2,q3), A^0_E(q1,q2,q3,q4)
for i = 1:3
    T(:,:,i+1) = T(:,:,i) * A(:,:,i+1)
end

% Transforms = [];
% for i = 1:4
%     Transforms = struct(['A0_' int2str(i)], T(:,:,i))
% end

%% Vectors r_E and b

% Vector r_0_E
r_E(:,1) = [-l2 * cos(q2) * sin(q3);
          -l2 * sin(q2) * sin(q3);
           l1 + q1 + l2 * cos(q3);];

% Vectors r_1_E, r_2_E, r_3_E
for i = 2:4
    r_E(:,i) = [-l2 * cos(q2) * sin(q3); -l2 * sin(q2) * sin(q3); l2 * cos(q3)];
end

for i = 1:3
    T(1:3,4,4) - T(1:3,4,4-i) 
end

%%
% Vector b_0
b(:,1) = sym([0; 0; 1]);

% Vector b_1
b(:,2) = b(:,1);

% Cross product matrix [b_0 x] and [b_1 x]
bx(:,:,1) = sym([0, 0, 1; 0, 0, 0; -1, 0, 0]);
bx(:,:,2) = bx(:,:,1);

% Vector b_2
b(:,3) = [sin(q2); -cos(q2); 0];

% Cross product matrix [b_2 x]
bx(:,:,3) = [0, 0, -cos(q2); 0, 0, -sin(q2); cos(q2), sin(q2), 0];

% Vector b_3
b(:,4) = [-cos(q2)*sin(q3); -sin(q2)*cos(q3); cos(q3)];

% Cross product matrix [b_3 x]
bx(:,:,4) = [0, -cos(q3), -sin(q2)*cos(q3); 0, 0, cos(q2)*sin(q3); sin(q2)*cos(q3), -cos(q2)*sin(q3), 0];

%%

for i = 1:4
    bx(:,:,i) * r_E(:,i)
end

%% 

syms q2 q3 q4 s2 c2 s3 c3;

J_A = [0, s2, -c2*s3;
       0, -c2, -s2*c3;
       1, 0, 0];

det(J_A)