%% Forecasting of Bagged Tree Machine Learning Model


%Training & Testing

Train_X = X_Train_01(:,:);
Train_Y = Y_Train_01(:,:);

Test_X = X_Test_01(:,:);
Test_Y = Y_Test_01(:,:);

%Model

KNN = fitcknn(Train_X,Train_Y,'NumNeighbors',140,'Standardize',1);

%Prediction
yPred_KNN = predict(KNN,Test_X);

%Errors
r2 = Test_Y - yPred_KNN;
MAPE_KNN = nanmean (abs(r2./Test_Y*100));
MAE_KNN = mae (r2);
RMSE_KNN = sqrt(mean((yPred_KNN(:)-Test_Y(:)).^2));

R_SQUARE_KNN = calculateR2(Test_Y,yPred_KNN);
Std_Dev_KNN =  std(yPred_KNN)/sqrt(length(yPred_KNN));

%% Calculate PA for yPred KNN

yPred = yPred_KNN;

PA_KNN = corr(Test_Y,yPred);


%% Calculate PI Count for yPred KNN

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


Percent_PI_KNN = (count1 / N1) * 100;

PI_Count_KNN = Percent_PI_KNN;

%% ERROR Display

ERROR(1,1) = MAPE_KNN; ERROR(1,2) = MAE_KNN; ERROR(1,3) = RMSE_KNN;   ERROR(1,4) = R_SQUARE_KNN; ERROR(1,5) = Std_Dev_KNN; ERROR(1,6) = PA_KNN; ERROR(1,7) = PI_Count_KNN; 
ERROR(1,:);

