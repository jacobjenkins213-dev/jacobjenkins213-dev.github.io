x = (2:100);
y = x.*x.*x.*x.*x;
matlabguess = diff(y)./diff(x);
[our_prediction,counts] = betterDifferentiator(x,y);
trueVals = 5.*x.*x.*x.*x;
diff_error = [];
for i = 1:length(trueVals)-1
    diff_error(i) = abs((matlabguess(i) - trueVals(i+1))./trueVals(i+1) .* 100);
end
our_error = [];
for l = 1:length(trueVals)
    our_error(l) = abs((our_prediction(l) - trueVals(l))./trueVals(l) .* 100);
end
our_error = our_error;
hold on
plot(x,our_error,'b')
plot(x(2:end),diff_error,'r')
xlabel('X Value')
ylabel('True Error[%]')
ylim([0,150])
xlim([2,60])
