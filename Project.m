train = importdata("train.csv");
train_d = train.data;

p = train_d(:,2:end)';
T = train_d(:,1);
S1 = 10;
S2 = 10;
S3 = 1;

W1 = rand(S1,10); %10x10
b1 = rand(S1,1); %

W2 = rand(S2,S1); %
b2 = rand(S2,1); %

W3 = rand(S3,S2); %
b3 = rand(S3,1); %

alpha = 0.001;
epochs = 10000;

%Training
for i = 1:epochs
    for j = 1:length(p)
        a1 = logsig(W1 * p(:, j) + b1);
        a2 = logsig(W2 * a1 + b2);
        a3 = purelin(W3 * a2 + b3);
        e = T(j) - a3;
        
        se3 = -2 * e;
        se2 = (1 - a2) .* a2 .* (W3' * se3);
        se1 = (1 - a1) .* a1 .* (W2' * se2);
        
        W3 = W3 - alpha * se3 * a2';
        b3 = b3 - alpha * se3;
        W2 = W2 - alpha * se2 * a1';
        b2 = b2 - alpha * se2;
        W1 = W1 - alpha * se1 * p(:, j)';
        b1 = b1 - alpha * se1;
    end
end

%Testing with training Data
T_predicted = zeros(length(p),1);
for i = 1:length(p)
    a1 = logsig(W1 * p(:, i) + b1);
    a2 = logsig(W2 * a1 + b2);
    a3 = purelin(W3 * a2 + b3);
    
    if a3 >= 0
        T_predicted(i) = 1;
    else
        T_predicted(i) = -1;
    end
end

correlationMatrix = corrcoef(train_d);

disp('Correlation Matrix training data:');
disp(correlationMatrix);

C = confusionmat(T, T_predicted);
disp('Confusion Matrix training data:');
disp(C);

accuracy = sum(diag(C)) / sum(C(:));
disp('Accuracy training data:');
disp(accuracy);


%Testing with testing Data
test = importdata("test.csv");
test_d = test.data;

p = test_d(:,2:end)';
T = test_d(:,1);
T_predicted = zeros(length(p),1);
for i = 1:length(p)
    a1 = logsig(W1 * p(:, i) + b1);
    a2 = logsig(W2 * a1 + b2);
    a3 = purelin(W3 * a2 + b3);
    
    if a3 >= 0
        T_predicted(i) = 1;
    else
        T_predicted(i) = -1;
    end
end

correlationMatrix = corrcoef(test_d);

disp('Correlation Matrix testing data:');
disp(correlationMatrix);

C = confusionmat(T, T_predicted);
disp('Confusion Matrix testing data:');
disp(C);

accuracy = sum(diag(C)) / sum(C(:));
disp('Accuracy testing data:');
disp(accuracy);

save('variablesNN.mat','W1','W2','W3','b1','b2','b3');
