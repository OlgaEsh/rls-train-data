function csv_data = to_csv_add(data_num,column_num)
%   data_num - ���������� ������������ �������� (�����)
%   column_num - ����� ������� (����� ������) 96 000
%   ��������� �������� �������
    data = zeros(1, column_num);
    dlmwrite('train_data.csv',data ,';') %�������� ������ ������
    %������ ����� � ���� ������ ���������� ������ ��������������� ������
    data_file = fopen('train_data.csv','a+'); %��������� csv ����
    for i = 1:data_num
        new_data = reflected_signal('thinking');
        % reflected_signal() - ������ ���������
        % new_data - ��������������� ������
        fprintf(data_file,'%f;', new_data(1:end-1));
        fprintf(data_file,'%f\n', new_data(end));
    end
    fclose(data_file)
end
    