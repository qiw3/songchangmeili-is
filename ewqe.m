% 清空工作空间
clear

% 设置参数
% 汉明码编码
hamming_encoded = encode(message, n, k, 'hamming/binary');

% FSK调制
fsk_modulated = fskmod(hamming_encoded, 2);

% 初始化误码统计
error_count = zeros(1, length(snr_range));

% 逐个信噪比计算误码率
for snr_index = 1:length(snr_range)
    % 加入AWGN信道噪声
    awgn_noisy = awgn(fsk_modulated, snr_range(snr_index));
    
    % FSK解调
    fsk_demodulated = fskdemod(awgn_noisy, 2);
    
    % 汉明码解码
    hamming_decoded = decode(fsk_demodulated, n, k, 'hamming/binary');

    % 计算误码率
    error_count(snr_index) = biterr(hamming_decoded, message);
end

% 计算误码率
error_rate = error_count / (msg_length * n);

% 绘制误码率曲线
figure;
semilogy(snr_range, error_rate, 'bo-');
xlabel('信噪比（dB）');
ylabel('误码率');
title('信噪比对误码率的影响');
grid on;