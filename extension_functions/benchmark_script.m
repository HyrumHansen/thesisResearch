% Number of times to run the script
numRuns = 5;

% Array to store ex
% 
% 
% 
% 
% ecution times
executionTimes = zeros(1, numRuns);

% Loop to run the script multiple times
for i = 1:numRuns
    tic; % Start the timer
    run('data_gen_script.m'); % Run your script
    executionTimes(i) = toc; % Stop the timer and record the execution time
end

% Display the execution times
disp('Execution Times:');
disp(executionTimes);

% Optionally, you can calculate and display average execution time
averageTime = mean(executionTimes);
disp(['Average Execution Time: ', num2str(averageTime), ' seconds']);
