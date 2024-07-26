% Robotics I Series 2 Exercise 1 2022-2023

syms c1 c2 c3 s1 s2 s3 l0 l1 l2 l3 c23 s23;

A00 = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
A01 = [1 0 0 l1; 0 c1 -s1 l0; 0 s1 c1 0; 0 0 0 1]
A12 = [c2 -s2 0 -l2*s2; s2 c2 0 l2*c2; 0 0 1 0; 0 0 0 1]
A23 = [c3 -s3 0 -l3*s3; s3 c3 0 l3*c3; 0 0 1 0; 0 0 0 1]

A02 = A01 * A12
A03 = A02 * A23

A03 = [c23 -s23 0 l1-l2*s2-l3*s23; c1*s23 c1*c23 -s1 l0+c1*(l2*c2+l3*c23); s1*s23 s1*c23 c1 s1*(l2*c2+l3*c23); 0 0 0 1]

R00 = [1 0 0; 0 1 0; 0 0 1];
R01 = [1 0 0; 0 c1 -s1; 0 s1 c1];
R12 = [c2 -s2 0; s2 c2 0; 0 0 1];
R23 = [c3 -s3 0; s3 c3 0; 0 0 1];

b = [0; 0; 1];
b0 = R00 * b
b1 = R01 * b
b2 = R01 * R12 * b

r = [0; 0; 0; 1];
r0E = A03 * r - A00 * r;
r0E = r0E(1:3)
r1E = A03 * r - A01 * r;
r1E = r1E(1:3)
r2E = A03 * r - A02 * r;
r2E = r2E(1:3)

JL1 = cross(b0, r0E)
JL2 = cross(b1, r1E)
JL3 = cross(b2, r2E)
JA1 = b0;
JA2 = b1;
JA3 = b2;

J = [JL1 JL2 JL3; JA1 JA2 JA3]

Jv = [-l0-c1*(l1*c2*l3*c23) -(l2*c2+l3*c23) -l3*c23; l1-l2*s2-l3*s23 -c1*(l2*s2+l3*s23) -c1*l3*s23; 0 -s1*(l2*s2+l3*s23) -s1*l3*s23]
det(Jv)