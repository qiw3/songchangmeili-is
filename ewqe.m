% ��չ����ռ�
clear

% ���ò���
% ���������
hamming_encoded = encode(message, n, k, 'hamming/binary');

% FSK����
fsk_modulated = fskmod(hamming_encoded, 2);

% ��ʼ������ͳ��
error_count = zeros(1, length(snr_range));

% �������ȼ���������
for snr_index = 1:length(snr_range)
    % ����AWGN�ŵ�����
    awgn_noisy = awgn(fsk_modulated, snr_range(snr_index));
    
    % FSK���
    fsk_demodulated = fskdemod(awgn_noisy, 2);
    
    % ���������
    hamming_decoded = decode(fsk_demodulated, n, k, 'hamming/binary');

    % ����������
    error_count(snr_index) = biterr(hamming_decoded, message);
end

% ����������
error_rate = error_count / (msg_length * n);

% ��������������
figure;
semilogy(snr_range, error_rate, 'bo-');
xlabel('����ȣ�dB��');
ylabel('������');
title('����ȶ������ʵ�Ӱ��');
grid on;