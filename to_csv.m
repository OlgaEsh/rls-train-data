function csv_data = to_csv(data_num,column_num)
%     data_num - ���������� ������������ �������� (�����)
%     column_num - ����� ������� (����� ������) 96 000
% ��������� �������� �������
    data = zeros(1, column_num) 
    %������ ����� � ���� ������ ���������� ������ ��������������� ������
    for i = 0:1:data_num
        new_data = GENERATE_DATA()
        % GENERATE_DATA() - ������ ���������
        % new_data - ��������������� ������
        data = [data; new_data];
    end