y = yahoo;

ticker = 'NKE';
fetch(y, ticker)

from = datetime('2015-01-01');
to = datetime('2016-01-01');
data = fetch(y,ticker,from, to)
whos data
close(y);
o = data(end:-1:1,2);
h = data(end:-1:1,3);
l = data(end:-1:1,4);
c = data(end:-1:1,5);
v = data(end:-1:1,6);
s = data(end:-1:1,7);
t= datetime(data(end:-1:1,1), 'convertfrom', 'datenum');

%grafikas
figure(1)
plot(t,s); title('NIKE, Inc. (NKE)');xlabel('date');ylabel('adj averege(USD)');

filesize = size(data,1); 

vo1=v;
vo=v;
b=data;
cl=c;

% On-Balance Volume
for i1 = 2:size(b,1)
   if     cl(i1) > cl(i1-1)
      vo1(i1) = vo1(i1-1)+vo(i1);
   elseif cl(i1) < cl(i1-1)
      vo1(i1) = vo1(i1-1)-vo(i1);
   elseif cl(i1) == cl(i1-1)
      vo1(i1) =vo1(i1-1);
   end
end    
figure(2)
plot(t,vo1);title('On-Balance Volume');xlabel('date');
ylabel('volume');

%Moving Average on adjusted average
figure(3)
sma=tsmovavg(s,'s',50,1);
plot(t,s,t,sma);title('NIKE, Inc. (NKE)');xlabel('date');ylabel('USD');legend('adjusted average','moving average')

%Rate of Change
roc = nan(filesize,1);
roc(2:filesize) = ((cl(2:filesize)- ...
    cl(1:filesize-1))./cl(1:filesize-1))*100;
figure(4)
plot(t,roc);title('Rate of Change');xlabel('date');ylabel('change(%)');

