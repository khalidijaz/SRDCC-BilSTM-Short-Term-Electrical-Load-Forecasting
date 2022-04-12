%% Forecasting of ANN - PSO Machine Learning Model

%Training & Testing / Data Preparation


Train_X = X_Train_01(:,:);
Train_Y = Y_Train_01(:,:);

Test_X = X_Test_01(:,:);
Test_Y = Y_Test_01(:,:);

%{

Train_X = X_Train_01(1:end-2,:);
Train_Y = Y_Train_01(1:end-2,:);

Test_X = X_Test_01(end-1:end,:);
Test_Y = Y_Test_01(end-1:end,:);

%}
inputs = Train_X(:,:)';
targets = Train_Y(:,:)';

inputs_test = Test_X(:,:)';
targets_test = Test_Y(:,:)';
test = targets_test';

%PSO Model Code

% number of neurons
neurons = 2;

% create a neural network
net_nn_2 = fitnet(neurons);

% Training, Validation, Testin Ratios
net_nn_2.divideParam.trainRatio = 70/100;
net_nn_2.divideParam.valRatio = 15/100;
net_nn_2.divideParam.testRatio = 15/100;

% configure the neural network for this dataset
net_nn_2 = train(net_nn_2, inputs, targets);


% get the normal NN weights and biash

getwb(net_nn_2)

% error MSE normal NN
error = targets - net_nn_2(inputs);
calc = mean(error.^2)/mean(var(targets',1))

% create handle to the MSE_TEST function, that calculates MSE
h = @(x) NMSE(x, net_nn_2, inputs, targets);

% running the particle swarm optimization algorithm with desired options
[x, err_ga] = pso(h, 12*neurons+neurons+neurons+1)
net_nn_pso = setwb(net_nn_2, x');

% get the PSO optimized NN weights and bias
getwb(net_nn_pso)

% error MSE PSO optimized NN
error = targets - net_nn_pso(inputs);
calc = mean(error.^2)/mean(var(targets',1))

%Prediction
predict_pso = sim(net_nn_pso,inputs_test);
yPred_NN_PSO = predict_pso';

%Errors Calculation
r4 = test - yPred_NN_PSO;

%Errors Calculation

Mape_NN_PSO = nanmean (abs(r4./test*100));
MAE_NN_PSO = mae (r4);
RMSE_NN_PSO = sqrt(mean((yPred_NN_PSO(:)- test(:)).^2));
R_SQUARE_NN_PSO = calculateR2(test,yPred_NN_PSO);
Std_Dev_NN_PSO =  std(yPred_NN_PSO)/sqrt(length(yPred_NN_PSO)) ;


%% Calculate PA for yPred Neural Network - PSO Algorithm

yPred = yPred_NN_PSO;

PA_NN_PSO = corr(Test_Y,yPred);


%% Calculate PI Count for yPred Neural Network - PSO Algorithm

U_max =      CI_HI_01(1:end)';
U_min =      CI_LO_01(1:end)';

N1 = length(yPred);

count1 = 0;

% Calculate PI Count

for  i1 = 1:N1
    
    if(yPred(i1) <= U_max(i1) && yPred(i1) >= U_min(i1))
        count1 = count1+1;
        
    end
end

Percent_PI_NN_PSO = (count1 / N1) * 100;

PI_Count_NN_PSO = Percent_PI_NN_PSO;


%% ERROR Display

ERROR(1,1) = Mape_NN_PSO; ERROR(1,2) = MAE_NN_PSO; ERROR(1,3) = RMSE_NN_PSO;  ERROR(1,4) = R_SQUARE_NN_PSO; ERROR(1,5) = Std_Dev_NN_PSO; ERROR(1,6) = PA_NN_PSO; ERROR(1,7) = PI_Count_NN_PSO;
ERROR(1,:)