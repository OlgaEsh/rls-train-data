function csv_data = to_csv_add(data_num,column_num)
%   data_num - количество генерируемых примеров (строк)
%   column_num - длина вектора (одной строки) 96 000
%   определим исходную матрицу
    data = zeros(1, column_num);
    dlmwrite('train_data.csv',data ,';') %записали первую строку
    %дальше будем к этой строке прибавлять каждый сгенерированный вектор
    data_file = fopen('train_data.csv','a+'); %открываем csv файл
    for i = 1:data_num
        new_data = reflected_signal('thinking');
        % reflected_signal() - катина программа
        % new_data - сгенерированные данные
        fprintf(data_file,'%f;', new_data(1:end-1));
        fprintf(data_file,'%f\n', new_data(end));
    end
    fclose(data_file)
end
    