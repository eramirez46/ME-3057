function out = lab3

%bias
subplot(1,3,1)
book = readcell('Book1.xlsx');
book = book(2:end,:);
book(:,11) = book(:,1);
book = cell2mat(book);
time0 = book(:,1);
time1 = book(:,3);
time2 = book(:,5);
time3 = book(:,7);
time4 = book(:,9);
time5 = book(:,11);
amp0 = book(:,2);
biasamp1 = book(:,4);
biasamp2 = book(:,6);
biasamp3 = book(:,8);
biasamp4 = book(:,10);
biasamp5 = book(:,12);
plot(time0,amp0+0.3,time1,biasamp1-0.3,time2,biasamp2-0.4,time3,biasamp3-0.5,time4,biasamp4-0.6,time5,biasamp5-0.7)
xlim([0 0.003])
ylabel 'Signal'
xlabel 'Time'
legend('Input','Bias 1','Bias 2','Bias 3','Bias 4','Bias 5')
hold on
title 'Bias'

%systematic noise
subplot(1,3,2)
book2 = readcell('Book2.xlsx');
book2 = book2(2:end,:);
book2(:,11) = book2(:,1);
book2 = cell2mat(book2);
time0 = book2(:,1);
time1 = book2(:,3);
time2 = book2(:,5);
time3 = book2(:,7);
time4 = book2(:,9);
time5 = book2(:,11);
baseamp0 = book2(:,2);
baseamp1 = book2(:,4);
baseamp2 = book2(:,6);
baseamp3 = book2(:,8);
baseamp4 = book2(:,10);
baseamp5 = book2(:,12);
plot(time0,baseamp0+0.3,time1,baseamp1-0.3,time2,baseamp2-0.4,time3,baseamp3-0.5,time4,baseamp4-0.6,time5,baseamp5-0.7)
xlim([0 0.004])
ylabel 'Signal'
xlabel 'Time'
legend('Input','Baseline 1','Baseline 2','Baseline 3','Baseline 4','Baseline 5')
title 'Systematic'
%random noise
subplot(1,3,3)
book3 = readcell('Book3.xlsx');
book3 = book3(2:end,:);
book3(:,11) = book3(:,1);
book3 = cell2mat(book3);
time0 = book3(:,1);
time1 = book3(:,3);
time2 = book3(:,5);
time3 = book3(:,7);
time4 = book3(:,9);
time5 = book3(:,11);
baseamp0 = book3(:,2);
baseamp1 = book3(:,4);
baseamp2 = book3(:,6);
baseamp3 = book3(:,8);
baseamp4 = book3(:,10);
baseamp5 = book3(:,12);
plot(time0,baseamp0+0.3,time1,baseamp1-0.3,time2,baseamp2-0.4,time3,baseamp3-0.5,time4,baseamp4-0.6,time5,baseamp5-0.7)
%xlim([0 0.004])
ylabel 'Signal'
xlabel 'Time'
legend('Input','Target 1','Target 2','Target 3','Target 4','Target 5')
title 'Random'


end
