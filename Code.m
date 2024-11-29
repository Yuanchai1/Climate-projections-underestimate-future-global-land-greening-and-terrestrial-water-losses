% Code for calculating constrained results
warning off
close all
clear
clc

% Load data
load('Data_for_X.mat');           % Load independent variable data
load('Data_for_Y.mat');           % Load dependent variable data
load('Observations.mat');         % Load observational data
load('Uncertainty_of_observations.mat'); % Load uncertainty in observations

% Calculate the constrained results
[r, m, b] = regression(X, Y);    % Perform linear regression
Corr_R = r;                      % Extract correlation coefficient

% Calculate statistics for X
mean_x = mean(X(1, :));          % Mean of X
sigma_x = std(X(1, :));          % Standard deviation of X

% Calculate statistics for Y
mean_y = mean(Y(1, :));          % Mean of Y
std_y = std(Y(1, :));            % Standard deviation of Y

% Calculate Signal-to-Noise Ratios (SNR)
SNR1 = sigma_x^2;                % SNR for X
SNR2 = sigmao^2;                 % SNR for observations
SNR = SNR1 ./ SNR2;              % Overall SNR

% Adjusted data calculations
Data1 = Corr_R .* std_y ./ sigma_x;  % Scale correlation
Data2 = uo - mean_x;                   % Deviation from mean
Data3 = sigma_x^2 + sigmao^2;         % Combined variance
Data4 = Data1 .* Data2 ./ Data3 .* sigma_x^2; % Adjusted data

% Best estimate of constrained results
Best_after = mean_y + Data4;         % Final constrained results
Future_LAI_ave_after_the_constraint = Best_after; % Store best estimate