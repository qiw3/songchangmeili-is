% 信源数据
data = randi([0,1],1,1000); 

% 卷积编码器
trellis = poly2trellis(3, [4 5]);
codedData = convenc(data, trellis);

% FSK调制
fskModulator = comm.FSKModulator('BitInput', true);
modulatedData = fskModulator(codedData');

% AWGN信道
snr = 0:5:30; % 不同信噪比值
errorRate = zeros(size(snr));
for i = 1:length(snr)
    noisyData = awgn(modulatedData, snr(i),'measured');

    % FSK解调
    fskDemodulator = comm.FSKDemodulator('BitOutput', true);
    demodulatedData = fskDemodulator(noisyData)';

    % 卷积译码器
    decodedData = vitdec(demodulatedData, trellis,5,'trunc','hard');

    % 计算误码率
    errorRate(i) = sum(decodedData ~= data) / length(data);
end

% 绘制误码率曲线
figure;
semilogy(snr, errorRate);
xlabel('信噪比 (dB)');
ylabel('误码率');
title('不同信噪比下的误码率');