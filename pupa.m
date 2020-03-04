% x = [0:pi:5*pi];
% % y = sin(x);
% % plot(x,y)
% 
% for i = 0:1:5
%     y = i*sin(x);
%     disp(i)
% end

% T = table(['M';'F';'M'],[45 45;41 32;40 34],{'NY';'CA';'MA'},[true;false;false]);
% writetable(T,'what.csv')

% clear;
x=rand(2,10);
dlmwrite('what4.txt',x,';')

% data = fopen('what.csv','a+','n','UTF-8');
data = fopen('what4.txt','a+');
x2=rand(1,10);
fprintf(data,'%f;', x2(1:end-1));
fprintf(data,'%f\n', x2(end));
x3=rand(1,10);
fprintf(data,'%f;', x3(1:end-1));
fprintf(data,'%f\n', x3(end));

fclose(data);
disp('done')

% fileID = fopen('magic4.csv','w');
% fwrite(fileID,magic(4),'double');
% fclose(fileID);
% 
% fileID = fopen('magic4.csv','a');
% disp(fileID)
% fwrite(fileID,zeros(4),'double');
% 
% fclose(fileID);
% disp('done')