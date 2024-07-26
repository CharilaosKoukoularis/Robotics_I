% Σελίδα 12 Παράδειγμα: Ρομποτικός Βραχίονας 3-R
% 17/1/2024

syms q1 q2 q3 l1 l2 l3 real

c1 = cos(q1);
s1 = sin(q1);
c2 = cos(q2);
s2 = sin(q2);
c3 = cos(q3);
s3 = sin(q3);

% A^0_1(q1)
A0_1 = [c1 -s1 0 0;
        s1  c1 0 0;
        0   0  1 l1;
        0   0  0 1];

% A^1_2(q2)
A1_2 = [c2, 0, s2, l2*s2;
        0,  1, 0,  0;
       -s2, 0, c2, l2*c2;
        0,  0, 0,  1];

% A^2_3(q3)
A2_3 = [c3, 0, s3, l3*s3;
        0,  1, 0,  0;
       -s3, 0, c3, l3*c3;
        0,  0, 0,  1];

A0_2 = A0_1 * A1_2;

A0_3 = A0_2 * A2_3;

simplify(A0_3)