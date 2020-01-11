%--------function to sort all car models on basis of old car price-----%
%-------- price range included is 0.85*oldcarprice < x < 1.5*oldcarprice--%
%------this range is made so as the new emi should not rise higher than 2times of the initial emi--- %
%------------------------------------------------------------------------%
function [data1]= price_short(data,oldcost)
[n m]=size(data);
j=1;
data1=1;      
for i=2:n
    if (((1.5*oldcost)> str2num([data{i,1}])) && ((0.95*oldcost)< str2num([data{i,1}]))) && ~(str2num([data{i,1}])==oldcost)
        data1(1,j)=i ;
        j=j+1;
    end  
end