%----function to calculate emi base on loan rate and time inputted >>>----%
%------------------     loan*rate*(1+rate)^time) -----------------%
%----formula used emi = ------------------------- .................%
%------------------ -   (((1+rate)^time)-1)       ----------------%

function [emi]= emicalc(loan,rate,time)

rate=rate/(100*12); %%monthly rate of interest 

a=((1+rate)^time)/(((1+rate)^time)-1);
emi =round((loan * ( rate *a)),2);

