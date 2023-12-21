% ��Դ����
data = randi([0,1],1,1000); 

% ���������
trellis = poly2trellis(3, [4 5]);
codedData = convenc(data, trellis);

% FSK����
fskModulator = comm.FSKModulator('BitInput', true);
modulatedData = fskModulator(codedData');

% AWGN�ŵ�
snr = 0:5:30; % ��ͬ�����ֵ
errorRate = zeros(size(snr));
for i = 1:length(snr)
    noisyData = awgn(modulatedData, snr(i),'measured');

    % FSK���
    fskDemodulator = comm.FSKDemodulator('BitOutput', true);
    demodulatedData = fskDemodulator(noisyData)';

    % ���������
    decodedData = vitdec(demodulatedData, trellis,5,'trunc','hard');

    % ����������
    errorRate(i) = sum(decodedData ~= data) / length(data);
end

% ��������������
figure;
semilogy(snr, errorRate);
xlabel('����� (dB)');
ylabel('������');
title('��ͬ������µ�������');