clear all
n = 3; k = 2;               % A (3,2) ѭ����
N=10000;                    %��Ϣ���ص�����           
msg = randi([2,123],N,k);         %��Ϣ���ع�N*k��
pol=cyclpoly(n,k);          %ѭ��������ɶ���ʽ
[h,g]=cyclgen(n,pol);       %����ѭ����
code2 = mod(msg*g,2);
noisy=randerr(N,n,[0 1;0.7 0.3]);           %����
noisycode2 = mod(code2 + noisy,2);      %��������
newmsg2 = decode(noisycode2,n,k,'cyclic'); % ����.
 [number,ratio2] = biterr(newmsg2,msg); %�������
disp(['The bit error rate2 is ',num2str(ratio2)])