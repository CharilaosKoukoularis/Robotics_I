% Robotics I 
% Semester Project 2023-2024
% Charilaos Koukoularis 03118137

l0 = 15;
l = [20 30 30];
q = [0 0 0];
s = [sin(q(1)) sin(q(2)) sin(q(3))];
c = [cos(q(1)) cos(q(2)) cos(q(3))];

% Position of links in initial pose
p = [0     0    0
     0     0    l0
     l(1)  0    l0
     l(1)  0    l0+l(2)
     l(1) -l(3) l0+l(2)];

%           a     α     d    θ
dhparams = [0    -pi/2  l0   q(1)+pi/2;
            l(2)  0    -l(1) q(2)-pi/2;
            l(3) -pi/2  0    q(3)-pi/2;
            0     0     0    pi/2];
a = 1;
alpha = 2;
d = 3;
theta = 4;


%% 
for i = 1:4
    [cos(dhparams(i,theta)) -sin(dhparams(i,theta))*cos(dhparams(i,alpha))  sin(dhparams(i,theta))*sin(dhparams(i,alpha)) dhparams(i,a)*cos(dhparams(i,theta));
     sin(dhparams(i,theta))  cos(dhparams(i,theta))*cos(dhparams(i,alpha)) -cos(dhparams(i,theta))*sin(dhparams(i,alpha)) dhparams(i,a)*sin(dhparams(i,theta));
     0                       sin(dhparams(i,alpha))                         cos(dhparams(i,alpha))                        dhparams(i,d);
     0                       0                                              0                                             1]
end


%% Πίνακες Μετασχηματισμών

% 
A(:,:,1) = eye(4);%5 * 

% A^0_1
A(:,:,2) = A(:,:,1) * [-s(1)  0 -c(1) 0
                        c(1)  0 -s(1) 0
                         0   -1   0   l0
                         0    0   0   1];
% A^1_2
A(:,:,3) = A(:,:,1) * [s(2) c(2) 0  l(2)*s(2)
                      -c(2) s(2) 0 -l(2)*c(2)
                        0   0    1 -l(1)
                        0   0    0  1];
% A^2_3
A(:,:,4) = A(:,:,1) * [s(3) 0 c(3)  l(3)*s(3)
                      -c(3) 0 s(3) -l(3)*c(3)
                        0   1 0     0
                        0   0 0     1];

% A^3_E
A(:,:,5) = A(:,:,1) * [0 -1 0 0
                       1  0 0 0
                       0  0 1 0
                       0  0 0 1];


%%
T(:,:,1) = A(:,:,1);

for i = 2:5
    % TODO: change A
    % A^0_i = A^0_{i-1} * A^{i-1}_i
    T(:,:,i) = T(:,:,i - 1) * A(:,:,i);
end

% T(:,:,2) = T(:,:,1) * A(:,:,2);
% 
% T(:,:,3) = T(:,:,2) * A(:,:,3);
% 
% T(:,:,4) = T(:,:,3) * A(:,:,4);
% 
% T(:,:,5) = T(:,:,4) * A(:,:,5);

%% 

x = 3;
y = 1;
z = 2;

x = 1;
y = 2;
z = 3;


%% Manipulator's initial pose

figure
hold
grid
for i = 1:4
    plot3(p(i:i+1,x),p(i:i+1,y),p(i:i+1,z), ...
        LineStyle='-',Marker='.', ...
        Color='black',MarkerFaceColor='black')
end
view(45,25)
%xlim([-0.2 20.2])

% xlabel('z')
% ylabel('x')
% zlabel('y')

xlabel('x')
ylabel('y')
zlabel('z')

%%
for i = 1:5
    text(p(i,x)+A(1,x,i),p(i,y)+A(2,x,i),p(i,z)+A(3,x,i),['y_' int2str(i - 1)],Color='green')
    text(p(i,x)+A(1,y,i),p(i,y)+A(2,y,i),p(i,z)+A(3,y,i),['z_' int2str(i - 1)],Color='blue')
    text(p(i,x)+A(1,z,i),p(i,y)+A(2,z,i),p(i,z)+A(3,z,i),['x_' int2str(i - 1)],Color='red')
    
    quiver3(p(i,x),p(i,y),p(i,z),A(1,x,i),A(2,x,i),A(3,x,i),Color='green',LineWidth=1)
    quiver3(p(i,x),p(i,y),p(i,z),A(1,y,i),A(2,y,i),A(3,y,i),Color='blue',LineWidth=1)
    quiver3(p(i,x),p(i,y),p(i,z),A(1,z,i),A(2,z,i),A(3,z,i),Color='red',LineWidth=1)
end


%%


% for i = 1:5
%     P(:,i) = T(:,:,i) * [p(i,:) 1]';
% end

for i = 1:5
    text(T(x,4,i)+T(1,x,i),T(y,4,i)+T(2,x,i),T(z,4,i)+T(3,x,i),['y_' int2str(i - 1)],Color='green')
    text(T(x,4,i)+T(1,y,i),T(y,4,i)+T(2,y,i),T(z,4,i)+T(3,y,i),['z_' int2str(i - 1)],Color='blue')
    text(T(x,4,i)+T(1,z,i),T(y,4,i)+T(2,z,i),T(z,4,i)+T(3,z,i),['x_' int2str(i - 1)],Color='red')

    quiver3(T(x,4,i),T(y,4,i),T(z,4,i),T(1,x,i),T(2,x,i),T(3,x,i),Color='green',LineWidth=1)
    quiver3(T(x,4,i),T(y,4,i),T(z,4,i),T(1,y,i),T(2,y,i),T(3,y,i),Color='blue',LineWidth=1)
    quiver3(T(x,4,i),T(y,4,i),T(z,4,i),T(1,z,i),T(2,z,i),T(3,z,i),Color='red',LineWidth=1)
    % quiver3(T(x,4,i),T(y,4,i),T(z,4,i),T(x,1,i),T(x,2,i),T(x,3,i),Color='green',LineWidth=1)
    % quiver3(T(x,4,i),T(y,4,i),T(z,4,i),T(y,1,i),T(y,2,i),T(y,3,i),Color='blue',LineWidth=1)
    % quiver3(T(x,4,i),T(y,4,i),T(z,4,i),T(z,1,i),T(z,2,i),T(z,3,i),Color='red',LineWidth=1
end



%% 

% Define symbolic variables
syms s1 c1 l0 s2 c2 l1 l2 s3 c3 l3 real

% Transformation matrix A1^0(q1)
A1_0 = [-s1, 0, -c1, 0;
         c1, 0, -s1, 0;
         0, -1, 0, l0;
         0, 0, 0, 1];

% Transformation matrix A2^1(q2)
A2_1 = [s2, c2, 0, l2*s2;
        -c2, s2, 0, -l2*c2;
        0, 0, 1, -l1;
        0, 0, 0, 1];

% Transformation matrix A3^2(q3)
A3_2 = [s3, 0, c3, l3*s3;
        -c3, 0, s3, -l3*c3;
        0, 1, 0, 0;
        0, 0, 0, 1];

% Transformation matrix AE^3
AE_3 = [0, -1, 0, 0;
        1, 0, 0, 0;
        0, 0, 1, 0;
        0, 0, 0, 1];

% Display the matrices
disp('A1^0(q1):');
disp(A1_0);

disp('A2^1(q2):');
disp(A2_1);

disp('A3^2(q3):');
disp(A3_2);

disp('AE^3:');
disp(AE_3);

% Transformation matrix A2^0(q1, q2)
A2_0 = [-s1*s2, -c2*s1, -c1, c1*l1 - l2*s1*s2;
        c1*s2, c1*c2, -s1, l1*s1 + c1*l2*s2;
        c2, -s2, 0, l0 + c2*l2;
        0, 0, 0, 1];

% Display the matrix
disp('A2^0(q1, q2):');
disp(A2_0);

% Define c_{23} and s_{23}
syms c23 s23 

% Transformation matrix A3^0(q1, q2, q3)
A3_0 = [s1*c23, -c1, -s1*s23, c1*l1 - l2*s1*s2 + l3*s1*c23;
        -c1*c23, -s1, c1*s23, l1*s1 + c1*l2*s2 - c1*l3*c23;
        s23, 0, c23, l0 + c2*l2 + l3*s23;
        0, 0, 0, 1];

% Display the matrix
disp('A3^0(q1, q2, q3):');
disp(A3_0);

% Transformation matrix AE^0(q1, q2, q3)
AE_0 = [-c1, -c23*s1, -s1*s23, c1*l1 + c23*l3*s1 - l2*s1*s2;
         -s1, c1*c23, c1*s23, l1*s1 - c1*c23*l3 + c1*l2*s2;
         0, -s23, c23, l0 + c2*l2 + l3*s23;
         0, 0, 0, 1];

% Display the matrix
disp('AE^0(q1, q2, q3):');
disp(AE_0);

%%

% Define symbolic variables
syms l1 l2 l3 l0 c1 s1 c2 s2 c3 s3 c23 s23 real

% Vector r_{0,E}
r_E(:,1) = [l1 * c1 - l2 * s1 * s2 + l3 * s1 * c23;
          l1 * s1 + l2 * c1 * s2 - l3 * c1 * c23;
          l0 + l2 * c2 + l3 * s23;];

% Vectors r_{1,E}
r_E(:,2) =  [l1 * c1 - l2 * s1 * s2 + l3 * s1 * c23;
           l1 * s1 + l2 * c1 * s2 - l3 * c1 * c23;
           l2 * c2 + l3 * s23;];

% Vectors r_{2,E}
r_E(:,3) = [l3 * s1 * c23;
         -l3 * c1 * c23;
          l3 * s23;];

% Vectors b_0, b_1, b_2
b(:,1) = sym([0; 0; 1]);
b(:,2) = [-c1; -s1; 0];
b(:,3) = b(:,2);

% Cross product matrices [b_0 x], [b_1 x], [b_2 x]
bx(:,:,1) = sym([0, 0, 1; 0, 0, 0; -1, 0, 0]);
bx(:,:,2) = [0, 0, -s1; 0, 0, c1; s1, -c1, 0];
bx(:,:,3) = bx(:,:,2);

% Display results
disp('r_E:');
disp(r_E(:,1));

disp('r_1_E:');
disp(r_E(:,2));

disp('r_2_E:');
disp(r_E(:,3));

disp('b(1):');
disp(b(:,1));

disp('[b(1) x]:');
disp(bx(:,:,1));

disp('b(2):');
disp(b(:,2));

disp('[b(2) x]:');
disp(bx(:,:,2));

disp('b(3):');
disp(b(:,3));

disp('[b(3) x]:');
disp(bx(:,:,3));

%%

for i = 1:3
    bx(:,:,i) * r_E(:,i)
end

%%

J_L = [l0 + l2*c2 + l3*s23,          -s1*(l2*c2 + l3*s23), -l3*s1*s23;
       0,                             c1*(l2*c2 + l3*s23),  l3*c1*s23;
      -l1*c1 + l2*s1*s2 - l3*s1*c23, -l2*s2 + l3*c23,       l3*c23];

det(J_L)

%% 

(J_L/det(J_L))^-1
adjoint(J_L)