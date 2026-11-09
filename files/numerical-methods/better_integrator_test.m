x = (2:100);
y = x.*x.*x.*x.*x;
trapz_prediction = trapz(x,y);
[our_prediction,count] = betterIntegrator(x,y);
trueVal = 166666666656;
trapz_error = abs((trueVal - trapz_prediction)./trueVal .*100)
betterIntegratorError = abs((trueVal - our_prediction)./trueVal .*100)
