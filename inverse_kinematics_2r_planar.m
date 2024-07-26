% Robotics I 
% Set 1 Page 79 Example 2: 2R planar

close all
clear
clc

l1 = 3;
l2 = 2;
px = 3;
py = 1;

figure() 
title('2R planar robotic arm')

for py = 0:0.5:2

    c2 = (px^2 + py^2 - l1^2 - l2^2) / (2 * l1 * l2);
    q2_plus = atan2(sqrt(1 - c2^2), c2);
    q2_minus = -q2_plus;
    rad2deg(q2_plus)
    rad2deg(q2_minus)

    d1 = l1 + l2 * cos(q2_plus);
    d2 = l2 * sin(q2_plus);
    a = atan2(d2, d1);

    q1_plus = atan2(py, px) - a;
    rad2deg(q1_plus)

    d1 = l1 + l2 * cos(q2_minus);
    d2 = l2 * sin(q2_minus);
    a = atan2(d2, d1);

    q1_minus = atan2(py, px) - a;
    rad2deg(q1_minus)

    plot(l1 * cos(q1_plus), l1 * sin(q1_plus), 'ro')
    hold on
    plot(l1 * cos(q1_minus), l1 * sin(q1_minus), 'bo')
    hold on
    plot(px, py, 'kx', 0, 0, 'ko')
    hold on

    Px = [0, l1 * cos(q1_plus), l1 * cos(q1_plus) + l2 * cos(q1_plus + q2_plus)];
    Py = [0, l1 * sin(q1_plus), l1 * sin(q1_plus) + l2 * sin(q1_plus + q2_plus)];
    plot(Px, Py, 'r')
    hold on

    Px = [0, l1 * cos(q1_minus), l1 * cos(q1_minus) + l2 * cos(q1_minus + q2_minus)];
    Py = [0, l1 * sin(q1_minus), l1 * sin(q1_minus) + l2 * sin(q1_minus + q2_minus)];
    plot(Px, Py, 'b')
    grid on

    xlim([-l1-l2, l1+l2])
    ylim([-l1-l2, l1+l2])
    
    pause(0.7)
    hold off
end