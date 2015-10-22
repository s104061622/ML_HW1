clc;clear;close all;
load('x2.mat');
scatter(1:20, x2(1:20));
hold on
p = polyfit([1:20],x2,1);
plot
