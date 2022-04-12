%% Forecasting of SVM Machine Learning Model

%Training & Testing

Train_X = X_Train_01(:,:);
Train_Y = Y_Train_01(:,:);

Test_X = X_Test_01(:,:);
Test_Y = Y_Test_01(:,:);

%Model

Mdl_SVM = fitrsvm(Train_X,Train_Y,'Standardize',true);

%Prediction

yPred_SVM = predict(Mdl_SVM,Test_X);


%Errors Calculate

r1 = Test_Y - yPred_SVM;
Mape_SVM = nanmean (abs(r1./Test_Y*100));
MAE_SVM = mae (r1);
RMSE_SVM = sqrt(mean((yPred_SVM(:)-Test_Y(:)).^2));
R_SQUARE_SVM = calculateR2(Test_Y,yPred_SVM);
Std_Dev_SVM =  std(yPred_SVM)/sqrt(length(yPred_SVM)) ;


%% Calculate PA for yPred SVM

yPred = yPred_SVM;

PA_SVM = corr(Test_Y,yPred);


%% Calculate PI Count for yPred SVM 

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


Percent_PI_SVM = (count1 / N1) * 100;

PI_Count_SVM = Percent_PI_SVM;

%% ERROR Display

ERROR(1,1) = Mape_SVM; ERROR(1,2) = MAE_SVM; ERROR(1,3) = RMSE_SVM;   ERROR(1,4) = R_SQUARE_SVM; ERROR(1,5) = Std_Dev_SVM; ERROR(1,6) = PA_SVM ; ERROR(1,7) = PI_Count_SVM; 
ERROR(1,:);