%% Forecasting of Bagged Tree Machine Learning Model


%Training & Testing

Train_X = X_Train_01(:,:);
Train_Y = Y_Train_01(:,:);

Test_X = X_Test_01(:,:);
Test_Y = Y_Test_01(:,:);

%Model

Tree = TreeBagger(25, Train_X,Train_Y, 'method', 'regression', 'minleaf', 50);

%Prediction

yPred_Tree = predict(Tree,Test_X);

%Errors

r2 = Test_Y - yPred_Tree;
MAPE_Tree = nanmean (abs(r2./Test_Y*100));
MAE_Tree = mae (r2);
RMSE_Tree = sqrt(mean((yPred_Tree(:)-Test_Y(:)).^2));

R_SQUARE_Tree = calculateR2(Test_Y,yPred_Tree);
Std_Dev_Tree =  std(yPred_Tree)/sqrt(length(yPred_Tree));


%% Calculate PA for yPred Bagged Tree

yPred = yPred_Tree;

PA_Tree = corr(Test_Y,yPred);

%% Calculate PI Count for yPred Bagged Tree

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

Percent_PI_Tree = (count1 / N1) * 100;

PI_Count_Tree = Percent_PI_Tree;

%% ERROR Display

ERROR_01(1,1) = MAPE_Tree; ERROR_01(1,2) = MAE_Tree; ERROR_01(1,3) = RMSE_Tree ;   ERROR_01(1,4) = R_SQUARE_Tree; ERROR_01(1,5) = Std_Dev_Tree; ERROR(1,6) = PA_Tree; ERROR(1,7) = PI_Count_Tree;
ERROR_01(1,:)

