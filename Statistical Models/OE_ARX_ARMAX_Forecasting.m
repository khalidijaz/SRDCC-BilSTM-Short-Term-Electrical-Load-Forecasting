%% Forecasting of Statistical Models

%Training/Testing Data
Train_X = X_Train_01(:,:);
Train_Y = Y_Train_01(:,:);

Test_X = X_Test_01(:,:);
Test_Y = Y_Test_01(:,:);

%% Models

ARX = ARX_01;
ARMX = ARMX_01;
OE = OE_01;

%Number of Testing Data Samples
N = length(Test_Y);

%idData conversion
Training_Data = iddata(Train_Y, Train_X, 1);

%% Forecasting

yPred1 = forecast(ARX,Training_Data,N,Test_X);
yPred2 = forecast(ARMX,Training_Data,N,Test_X);
yPred3 = forecast(OE,Training_Data,N,Test_X);

yPred_ARX  = yPred1.y(:,1);
yPred_ARMX = yPred2.y(:,1);
yPred_OE  =  yPred3.y(:,1);


%% Errors Calculate

%ARX
r1 = Test_Y - yPred_ARX;
Mape_1 = nanmean (abs(r1./Test_Y*100));
MAE_1 = mae (r1);
RMSE_1 = sqrt(mean((yPred_ARX(:)-Test_Y(:)).^2));
R_SQUARE_1 = calculateR2(Test_Y,yPred_ARX);
Std_Dev_1 =  std(yPred_ARX)/sqrt(length(yPred_ARX)) ;

%ARMX
r2 = Test_Y - yPred_ARMX;
Mape_2 = nanmean (abs(r2./Test_Y*100));
MAE_2 = mae (r2);
RMSE_2 = sqrt(mean((yPred_ARMX-Test_Y(:)).^2));
R_SQUARE_2 = calculateR2(Test_Y,yPred_ARMX);
Std_Dev_2 = std(yPred_ARMX)/sqrt(length(yPred_ARMX)) ;

%OE
r3 = Test_Y - yPred_OE;
Mape_3 = nanmean (abs(r3./Test_Y*100));
MAE_3 = mae (r3);
RMSE_3 = sqrt(mean((yPred_OE -Test_Y(:)).^2)); 
R_SQUARE_3 = calculateR2(Test_Y,yPred_OE);
Std_Dev_3 = std(yPred_OE)/sqrt(length(yPred_OE)) ;


%% Calculate PA for yPred OE, ARX, ARMAX

yPred_1 = yPred_ARX;
yPred_2 = yPred_ARMX;
yPred_3 = yPred_OE;

PA_1 = corr(Test_Y,yPred_1);
PA_2 = corr(Test_Y,yPred_2);
PA_3 = corr(Test_Y,yPred_3);


%% Calculate PI Count for yPred OE, ARX, ARMAX 

U_max =      CI_HI_01(1:end)';
U_min =      CI_LO_01(1:end)';

N1 = length(yPred_1);
N2 = length(yPred_2);
N3 = length(yPred_3);

count1 = 0; count2 = 0;  count3 = 0;

% Calculate PI Count

for  i1 = 1:N1
    
    if(yPred_1(i1) <= U_max(i1) && yPred_1(i1) >= U_min(i1))
        count1 = count1+1;
        
    end
end

for  i2 = 1:N2
    
    if(yPred_2(i2) <= U_max(i2) && yPred_2(i2) >= U_min(i2))
        count2 = count2+1;
        
    end
end

for  i3 = 1:N3
    
    if(yPred_3(i3) <= U_max(i3) && yPred_3(i3) >= U_min(i3))
        count3 = count3+1;
        
    end
end


Percent_PI_ARX = (count1 / N1) * 100;
Percent_PI_ARMX = (count2 / N2) * 100;
Percent_PI_OE = (count3 / N3) * 100;

PI_Count_1 = Percent_PI_ARX;
PI_Count_2 = Percent_PI_ARMX;
PI_Count_3 = Percent_PI_OE;


%% Error Display 

ERROR(1,1) = Mape_3; ERROR(1,2) = MAE_3; ERROR(1,3) = RMSE_3;   ERROR(1,5) = R_SQUARE_3; ERROR(1,6) = Std_Dev_3; ERROR(1,6) = PA_3; ERROR(1,7) = PI_Count_3;
ERROR(2,1) = Mape_1; ERROR(2,2) = MAE_1; ERROR(2,3) = RMSE_1;   ERROR(2,5) = R_SQUARE_1; ERROR(2,6) = Std_Dev_1; ERROR(2,6) = PA_1; ERROR(2,7) = PI_Count_1;
ERROR(3,1) = Mape_2; ERROR(3,2) = MAE_2; ERROR(3,3) = RMSE_2;   ERROR(3,5) = R_SQUARE_2; ERROR(3,6) = Std_Dev_2; ERROR(3,6) = PA_2; ERROR(3,7) = PI_Count_2;

ERROR (:,:)