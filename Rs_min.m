% 清空工作空间
clear

% 设置参数
n = 4;                     % 汉明码中数据位数
k = 7;                     % 汉明码中编码后的总位数
msg_length = 10000;        % 发送消息的长度
snr_range = -10:2:10;      % 信噪比范围(dB)

% 生成随机发送消息
message = randi([0, 1], msg_length, n);

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