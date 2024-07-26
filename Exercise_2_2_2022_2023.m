% Robotics I Series 2 Exercise 2 2022-2023

syms c1 c2 c3 c4 s1 s2 s3 s4 l1 l2 q1;

A00 = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
A01 = [1 0 0 0; 0 1 0 0; 0 0 1 q1; 0 0 0 1];
A12 = [c2 0 s2 0; s2 0 -c2 0; 0 1 0 l1; 0 0 0 1]
A23 = [c3 0 -s3 0; s3 0 c3 0; 0 -1 0 0; 0 0 0 1]
A34 = [c4 -s4 0 0; s4 c4 0 0; 0 0 1 l2; 0 0 0 1]

A02 = A01 * A12
A03 = A02 * A23
A04 = A03 * A34

R00 = [1 0 0; 0 1 0; 0 0 1];
R01 = [1 0 0; 0 1 0; 0 0 1];
R12 = [c2 0 s2; s2 0 -c2; 0 1 0];
R23 = [c3 0 -s3; s3 0 c3; 0 -1 0];
R34 = [c4 -s4 0; s4 c4 0; 0 0 1];

b = [0; 0; 1];
b0 = R00 * b
b1 = R01 * b
b2 = R01 * R12 * b
b3 = R01 * R12 * R23 * b

r = [0; 0; 0; 1];
r1E = A04 * r - A01 * r;
r1E = r1E(1:3)
r2E = A04 * r - A02 * r;
r2E = r2E(1:3)
r3E = A04 * r - A03 * r;
r3E = r3E(1:3)

JL1 = b0;
JL2 = cross(b1, r1E)
JL3 = cross(b2, r2E)
JL4 = cross(b3, r3E)
JA1 = 0;
JA2 = b1;
JA3 = b2;
JA4 = b3;

J = [JL1 JL2 JL3 JL4; JA1 JA2 JA3 JA4]