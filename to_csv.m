function csv_data = to_csv(data_num,column_num)
%     data_num - количество генерируемых примеров (строк)
%     column_num - длина вектора (одной строки) 96 000
% определим исходную матрицу
    data = zeros(1, column_num) 
    %дальше будем к этой строке прибавлять каждый сгенерированный вектор
    for i = 0:1:data_num
        new_data = GENERATE_DATA()
        % GENERATE_DATA() - катина программа
        % new_data - сгенерированные данные
        data = [data; new_data];
    end