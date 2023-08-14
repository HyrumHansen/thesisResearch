data = readtable("Thesis/walsh_data.csv");

g_scores = [];
g_efficiencies = [];

for i = 1:size(data,1)
    X = data_reader(data(i,4));
    score = compute_g(X);
    g_scores = [g_scores, score];
    if data{i, 1} == 1
        g_efficiencies = [g_efficiencies, 100*3/score];
    elseif data{i, 1} == 2
        g_efficiencies = [g_efficiencies, 100*6/score];
    elseif data{i, 1} == 3
        g_efficiencies = [g_efficiencies, 100*10/score];
    elseif data{i, 1} == 4
        g_efficiencies = [g_efficiencies, 100*15/score];
    elseif data{i, 1} == 5
        g_efficiencies = [g_efficiencies, 100*21/score];
    end
end

K = data{:,1};
N = data{:,2};
PSO_efficiency = data{:,3};
gloptipoly_efficiency = g_efficiencies.';
absolute_difference = abs(PSO_efficiency - gloptipoly_efficiency);

T = table(K, N, PSO_efficiency, gloptipoly_efficiency, absolute_difference);

table2latex(T)
