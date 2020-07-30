clear;
load('spectra.mat');
%Our training data
training_1 = C1(:,1:8000);
training_2 = C2(:,1:8000);

%finding the within class mean
u1 = mean(training_1, 2);
u2 = mean(training_2, 2);

%between class mean
ut = mean([training_1 training_2], 2);

%demeaning our matrix
training_1_zero = training_1-u1;
training_2_zero = training_2-u2;

%calculating our scatter matrixes and generalized eigenvector
Sw = (training_1_zero*(training_1_zero')) + (training_2_zero*(training_2_zero'));
a = u1-ut;
b = u2-ut;
Sb = (8000*(a*a')) + (8000*(b*b'));


[e, D] = eigs(Sb, Sw, 1);
%projecting it onto one dimensional linear space
s1 = (e'*training_1)';
s2 = (e'*training_2)';

%visualizing with histograms
figure(1);
cla;
hold on;
h = histfit( s1 ); set( h(1), 'FaceAlpha', 0.5 );
h = histfit( s2); set( h(1), 'FaceAlpha', 0.5 );
hold off;
%the overlapping section represents the data points that we will have
%misprediction because our program can't differentiate if they belong in
%training_1_zero or training_2_zero. 

minT = min(min([s1 s2]));
maxT = max(max([s1 s2]));
rng = linspace(minT, maxT, 500);

c = mean(s1);
nc = mean(s2);
%we find that those with cancer have a lower value than those without
cancer = zeros(1, size(rng, 2));
nocancer = zeros(1, size(rng, 2));
i = 1;
success = 0;
threshold = 0;
cancer_rate = 0;
ncancer_rate = 0;

%iterating through the potential threshold points and finding
%the number of data points in each class that would be correctly classified using this threshold
for T = rng
    ind1 = find(s1 <T);
    cancer(i) = 100*length(ind1)/8000;
    ind2 = find(s2>=T);
    nocancer(i) = 100*length(ind2)/8000;
    temp = cancer(i) + nocancer(i);
    if temp > success  % only keeping the max success rate as our threshold
        success = temp;
        threshold = T;
        cancer_rate = cancer(i);
        ncancer_rate = nocancer(i);
    end
    i=i+1;
end
s_rate = (cancer_rate + ncancer_rate)/2;
%A success rate of 94.69% with a threshold of -0.1115

%plotting our ROC curve which shows the accuracy of our threshold
figure(2)
plot(rng,cancer, 'color', 'r');
hold on;
plot(rng,nocancer, 'color', 'b');
legend('Cancer', 'No Cancer');
xlabel('Threshold Values') 
ylabel('Success Rate') 
hold off;


%our testing data
testing_1 = C1(:,8001:10000);
testing_2 = C2(:,8001:10000);
%finding the within class mean
u1_test = mean(testing_1, 2);
u2_test = mean(testing_2, 2);
%between class mean
u_test = mean([testing_1 testing_2], 2);
%demeaning our matrix
testing_1_zero = testing_1-u1_test;
testing_2_zero = testing_2-u2_test;
%calculating our scatter matrixes and generalized eigenvector
Sw_test = (testing_1_zero*(testing_1_zero')) + (testing_2_zero*(testing_2_zero'));
c = u1_test-u_test;
d = u2_test-u_test;
Sb_test = (2000*(c*c')) + (2000*(d*d'));


[e2, D] = eigs(Sb_test, Sw_test, 1);
%projecting it onto one dimensional linear space
s1_test = (e2'*testing_1)';
s2_test = (e2'*testing_2)';
minT = min(min([s1_test s2_test]));
maxT = max(max([s1_test s2_test]));
rng = linspace(minT, maxT, 500);
%visualizing with histograms
figure(3);
cla;
hold on;
h = histfit( s1_test ); set( h(1), 'FaceAlpha', 0.5 );
h = histfit( s2_test); set( h(1), 'FaceAlpha', 0.5 );
hold off;

cancer_test = zeros(1, size(rng, 2));
nocancer_test = zeros(1, size(rng, 2));
i = 1;
success_t = 0;
threshold_t = 0;
crate_test = 0;
ncrate_test = 0;
for T = rng
    ind1 = find(s1_test <T);
    cancer_test(i) = 100*length(ind1)/2000;
    ind2 = find(s2_test>=T);
    nocancer_test(i) = 100*length(ind2)/2000;
    temp = cancer_test(i) + nocancer_test(i);
    if temp > success_t
        success_t = temp;
        threshold_t = T;
        crate_test = cancer_test(i);
        ncrate_test = nocancer_test(i);
    end
    i=i+1;
end
s_rate_test = (crate_test+ncrate_test)/2;
%A success rate of 96.7% with a threshold of -0.2307

figure(4);
cla;
plot(rng,cancer_test, 'color', 'r');
hold on;
plot(rng,nocancer_test, 'color', 'b');
legend('Cancer', 'No Cancer');
xlabel('Threshold Values') 
ylabel('Success Rate') 
hold off;

% The ROC curves differ in their threshold and the success rate. This
% suggests that the classifier is not super accurate. 
