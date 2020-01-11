%-----------this function calculates number of monthes----------%
%-----------for which customer has user the car from the date of-----%
%-----------purchase%
function months= monthsused(date1,date2)
formatOut = 'mm/dd/yyyy';
MonthNum1 = month(date1,formatOut);
Year1 = year(date1,formatOut);
MonthNum2 = month(date2,formatOut);
Year2 = year(date2,formatOut);
%-----------------------------------------------------------%
%--- only estimated months difference has been calculated without----%
%----- has been calculated without considering dd(day)---------------%
months=(Year2-Year1-1)*12 + (MonthNum2) + (12-MonthNum1);

