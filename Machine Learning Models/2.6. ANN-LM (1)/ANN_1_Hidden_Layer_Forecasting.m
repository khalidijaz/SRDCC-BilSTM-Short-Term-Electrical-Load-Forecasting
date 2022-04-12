%% Forecasting of ANN - LM (1-Hidden Layer) Machine Learning Model

%Training & Testing

Train_X = X_Train_01(:,:);
Train_Y = Y_Train_01(:,:);

Test_X = X_Test_01(:,:);
Test_Y = Y_Test_01(:,:);

%Model / Construct Neural Network

N = length(Test_Y);

neurons = 20;
net_nn_1 = fitnet(neurons,'trainlm');

% Training, Validation, Testin Ratios
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

net_nn_1 = train(net_nn_1, Train_X', Train_Y');

%Prediction

yPred_NN_1 = sim (net_nn_1,Test_X')';


%Errors
r2 = Test_Y - yPred_NN_1;
Mape_NN_1 = nanmean (abs(r2./Test_Y*100));
MAE_NN_1 = mae (r2);
RMSE_NN_1 = sqrt(mean((yPred_NN_1(:)-Test_Y(:)).^2));
R_SQUARE_NN_1 = calculateR2(Test_Y,yPred_NN_1);
Std_Dev_NN_1 =  std(yPred_NN_1)/sqrt(length(yPred_NN_1)) ;


%% Calculate PA for yPred Neural Network - 1 Hidden Layer

yPred = yPred_NN_1;

PA_NN_1 = corr(Test_Y,yPred);

%% Calculate PI Count for yPred Neural Network - 2 Hidden Layer

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

Percent_PI_NN_1 = (count1 / N1) * 100;

PI_Count_NN_1 = Percent_PI_NN_1;

%% ERROR Display

ERROR(1,1) = Mape_NN_1; ERROR(1,2) = MAE_NN_1; ERROR(1,3) = RMSE_NN_1 ;   ERROR(1,4) = R_SQUARE_NN_1; ERROR(1,5) = Std_Dev_NN_1; ERROR(1,6) = PA_NN_1 ; ERROR(1,7) = PI_Count_NN_1;
ERROR = ERROR(1,:)