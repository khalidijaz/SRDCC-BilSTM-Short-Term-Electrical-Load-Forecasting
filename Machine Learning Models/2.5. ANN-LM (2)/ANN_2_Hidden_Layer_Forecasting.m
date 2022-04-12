%% Forecasting of ANN - LM (2-Hidden Layer) Machine Learning Model

%Training & Testing

Train_X = X_Train_01(:,:);
Train_Y = Y_Train_01(:,:);

Test_X = X_Test_01(:,:);
Test_Y = Y_Test_01(:,:);

%Model / Construct Neural Network

N = length(Test_Y);

neurons = [45 20] ;
net_nn_1 = fitnet(neurons,'trainlm');

% Training, Validation, Testin Ratios
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

net_nn_1 = train(net_nn_1, Train_X', Train_Y');

%Prediction

yPred_NN_2 = sim (net_nn_1,Test_X')';


%Errors
r2 = Test_Y - yPred_NN_2;
Mape_NN_2 = nanmean (abs(r2./Test_Y*100));
MAE_NN_2 = mae (r2);
RMSE_NN_2 = sqrt(mean((yPred_NN_2(:)-Test_Y(:)).^2));
R_SQUARE_NN_2 = calculateR2(Test_Y,yPred_NN_2);
Std_Dev_NN_2 =  std(yPred_NN_2)/sqrt(length(yPred_NN_2)) ;


%% Calculate PA for yPred Neural Network - 1 Hidden Layer

yPred = yPred_NN_2;

PA_NN_2 = corr(Test_Y,yPred);

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

Percent_PI_NN_2 = (count1 / N1) * 100;

PI_Count_NN_2 = Percent_PI_NN_2;

%% ERROR Display

ERROR(1,1) = Mape_NN_2; ERROR(1,2) = MAE_NN_2; ERROR(1,3) = RMSE_NN_2 ;   ERROR(1,4) = R_SQUARE_NN_2; ERROR(1,5) = Std_Dev_NN_2; ERROR(1,6) = PA_NN_2; ERROR(1,7) = PI_Count_NN_2;
ERROR = ERROR(1,:)
