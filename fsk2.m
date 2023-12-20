all_msg=a_msg; %所有可能的信号


msg=rand(5,3);
msg=floor(msg*8) %产生随机的5组信号
MSG=gf(msg,3); %将产生的5组信号映射到GF域
code=rs_rscode(MSG) %对5组信号进行编码，得到5组正确的
RS
a=zeros(5,5);
b=floor(rand(5,2)*8);
noise=[a,b];
NOISE=gf(noise,3); %产生噪声信号
in_msg=code+NOISE %加噪
for ii = 1:5 %对5组信号进行译码
 new_msg(ii,:) = rs_rrscode(in_msg(ii,:),all_code_msg,all_msg);
end
new_msg%译码输出
num_same = same(msg,new_msg); %译码正确个数
num =num_same/15 %译码正确率
%RS码编码
function code=rs_rscode(msg)
g=[1 0 0 3 2 1 3
 0 1 0 5 5 1 4
0 0 1 7 6 1 6] ;
g=gf(g,3);
code=msg*g; 
function new_msg=rs_rrscode(in_msg,all_code_msg,all_msg)
new_msg=rs_interpret(in_msg,all_code_msg,all_msg);
return;
%计算GF域内两个码字的码距子程序：
function ret = gf_dis(a,b)
ret = 0;
44
a_temp = de2bi(gf2num(a),3);
b_temp = de2bi(gf2num(b),3);
temp = a_temp+b_temp;
temp = mod(temp,2);
ret = sum(temp);
%计算GF域内每个码元与“0”码字的码距，并映射在成实数子程序：
function distance = gf2num(gf_a)
distance = -1;
if (gf_a == gf(0,3)) distance = 0; end
if (gf_a == gf(1,3)) distance = 1; end
if (gf_a == gf(2,3)) distance = 2; end
if (gf_a == gf(3,3)) distance = 3; end
if (gf_a == gf(4,3)) distance = 4; end
if (gf_a == gf(5,3)) distance = 5; end
if (gf_a == gf(6,3)) distance = 6; end
if (gf_a == gf(7,3)) distance = 7; end
%得到码距最短的码字：
function interpret_msg=rs_interpret(in_msg,all_code_msg,all_msg)
for i=1:512
 rs_dis(i)=rscode_dis(in_msg,all_code_msg(i,:)); 
end
rs_dis_min =min(rs_dis);
index = find(rs_dis == rs_dis_min);
interpret_msg = all_msg(index(1),:);
return;
%计算两个RS码的码距子程序：
function dis = rscode_dis(code1,code2)
dis = 0;
for i = 1:7
 temp = gf_dis(code1(i),code2(i));
 dis = dis+temp;
end
function x=a_msg(x)
x=[0 0 0
 0 0 1
 0 0 2
 0 0 3
 0 0 4
45
 0 0 5
 0 0 6
 0 0 7
 0 1 0
 0 1 1
 0 1 2
 0 1 3
 0 1 4
 0 1 5
 0 1 6
 0 1 7
 0 2 0
 0 2 1
 0 2 2
 0 2 3
 0 2 4
 0 2 5
 0 2 6
 0 2 7
 0 3 0
 0 3 1
 0 3 2
 0 3 3
 0 3 4
 0 3 5
 0 3 6
 0 3 7
 0 4 0
 0 4 1
 0 4 2
 0 4 3
 0 4 4
 0 4 5
 0 4 6
 0 4 7
 0 5 0
 0 5 1
 0 5 2
 0 5 3
 0 5 4
 0 5 5
 0 5 6
 0 5 7
 0 6 0
46
 0 6 1
 0 6 2
 0 6 3
 0 6 4
 0 6 5
 0 6 6
 0 6 7
 0 7 0
 0 7 1
 0 7 2
 0 7 3
 0 7 4
 0 7 5
 0 7 6
 0 7 7
 1 0 0
 1 0 1
 1 0 2
 1 0 3
 1 0 4
 1 0 5
 1 0 6
 1 0 7
 1 1 0
 1 1 1
 1 1 2
 1 1 3
 1 1 4
 1 1 5
 1 1 6
 1 1 7
 1 2 0
 1 2 1
 1 2 2
 1 2 3
 1 2 4
 1 2 5
 1 2 6
 1 2 7
 1 3 0
 1 3 1
 1 3 2
 1 3 3
 1 3 4
47
 1 3 5
 1 3 6
 1 3 7
 1 4 0
 1 4 1
 1 4 2
 1 4 3
 1 4 4
 1 4 5
 1 4 6
 1 4 7
 1 5 0
 1 5 1
 1 5 2
 1 5 3
 1 5 4
 1 5 5
 1 5 6
 1 5 7
 1 6 0
 1 6 1
 1 6 2
 1 6 3
 1 6 4
 1 6 5
 1 6 6
 1 6 7
 1 7 0
 1 7 1
 1 7 2
 1 7 3
 1 7 4
 1 7 5
 1 7 6
 1 7 7
 2 0 0
 2 0 1
 2 0 2
 2 0 3
 2 0 4
 2 0 5
 2 0 6
 2 0 7
 2 1 0
48
 2 1 1
 2 1 2
 2 1 3
 2 1 4
 2 1 5
 2 1 6
 2 1 7
 2 2 0
 2 2 1
 2 2 2
 2 2 3
 2 2 4
 2 2 5
 2 2 6
 2 2 7
 2 3 0
 2 3 1
 2 3 2
 2 3 3
 2 3 4
 2 3 5
 2 3 6
 2 3 7
 2 4 0
 2 4 1
 2 4 2
 2 4 3
 2 4 4
 2 4 5
 2 4 6
 2 4 7
 2 5 0
 2 5 1
 2 5 2
 2 5 3
 2 5 4
 2 5 5
 2 5 6
 2 5 7
 2 6 0
 2 6 1
 2 6 2
 2 6 3
 2 6 4
49
 2 6 5
 2 6 6
 2 6 7
 2 7 0
 2 7 1
 2 7 2
 2 7 3
 2 7 4
 2 7 5
 2 7 6
 2 7 7
 3 0 0
 3 0 1
 3 0 2
 3 0 3
 3 0 4
 3 0 5
 3 0 6
 3 0 7
 3 1 0
 3 1 1
 3 1 2
 3 1 3
 3 1 4
 3 1 5
 3 1 6
 3 1 7
 3 2 0
 3 2 1
 3 2 2
 3 2 3
 3 2 4
 3 2 5
 3 2 6
 3 2 7
 3 3 0
 3 3 1
 3 3 2
 3 3 3
 3 3 4
 3 3 5
 3 3 6
 3 3 7
 3 4 0
50
 3 4 1
 3 4 2
 3 4 3
 3 4 4
 3 4 5
 3 4 6
 3 4 7
 3 5 0
 3 5 1
 3 5 2
 3 5 3
 3 5 4
 3 5 5
 3 5 6
 3 5 7
 3 6 0
 3 6 1
 3 6 2
 3 6 3
 3 6 4
 3 6 5
 3 6 6
 3 6 7
 3 7 0
 3 7 1
 3 7 2
 3 7 3
 3 7 4
 3 7 5
 3 7 6
 3 7 7
 4 0 0
 4 0 1
 4 0 2
 4 0 3
 4 0 4
 4 0 5
 4 0 6
 4 0 7
 4 1 0
 4 1 1
 4 1 2
 4 1 3
 4 1 4
51
 4 1 5
 4 1 6
 4 1 7
 4 2 0
 4 2 1
 4 2 2
 4 2 3
 4 2 4
 4 2 5
 4 2 6
 4 2 7
 4 3 0
 4 3 1
 4 3 2
 4 3 3
 4 3 4
 4 3 5
 4 3 6
 4 3 7
 4 4 0
 4 4 1
 4 4 2
 4 4 3
 4 4 4
 4 4 5
 4 4 6
 4 4 7
 4 5 0
 4 5 1
 4 5 2
 4 5 3
 4 5 4
 4 5 5
 4 5 6
 4 5 7
 4 6 0
 4 6 1
 4 6 2
 4 6 3
 4 6 4
 4 6 5
 4 6 6
 4 6 7
 4 7 0
52
 4 7 1
 4 7 2
 4 7 3
 4 7 4
 4 7 5
 4 7 6
 4 7 7
 5 0 0
 5 0 1
 5 0 2
 5 0 3
 5 0 4
 5 0 5
 5 0 6
 5 0 7
 5 1 0
 5 1 1
 5 1 2
 5 1 3
 5 1 4
 5 1 5
 5 1 6
 5 1 7
 5 2 0
 5 2 1
 5 2 2
 5 2 3
 5 2 4
 5 2 5
 5 2 6
 5 2 7
 5 3 0
 5 3 1
 5 3 2
 5 3 3
 5 3 4
 5 3 5
 5 3 6
 5 3 7
 5 4 0
 5 4 1
 5 4 2
 5 4 3
 5 4 4
53
 5 4 5
 5 4 6
 5 4 7
 5 5 0
 5 5 1
 5 5 2
 5 5 3
 5 5 4
 5 5 5
 5 5 6
 5 5 7
 5 6 0
 5 6 1
 5 6 2
 5 6 3
 5 6 4
 5 6 5
 5 6 6
 5 6 7
 5 7 0
 5 7 1
 5 7 2
 5 7 3
 5 7 4
 5 7 5
 5 7 6
 5 7 7
 6 0 0
 6 0 1
 6 0 2
 6 0 3
 6 0 4
 6 0 5
 6 0 6
 6 0 7
 6 1 0
 6 1 1
 6 1 2
 6 1 3
 6 1 4
 6 1 5
 6 1 6
 6 1 7
 6 2 0
54
 6 2 1
 6 2 2
 6 2 3
 6 2 4
 6 2 5
 6 2 6
 6 2 7
 6 3 0
 6 3 1
 6 3 2
 6 3 3
 6 3 4
 6 3 5
 6 3 6
 6 3 7
 6 4 0
 6 4 1
 6 4 2
 6 4 3
 6 4 4
 6 4 5
 6 4 6
 6 4 7
 6 5 0
 6 5 1
 6 5 2
 6 5 3
 6 5 4
 6 5 5
 6 5 6
 6 5 7
 6 6 0
 6 6 1
 6 6 2
 6 6 3
 6 6 4
 6 6 5
 6 6 6
 6 6 7
 6 7 0
 6 7 1
 6 7 2
 6 7 3
 6 7 4
55
 6 7 5
 6 7 6
 6 7 7
 7 0 0
 7 0 1
 7 0 2
 7 0 3
 7 0 4
 7 0 5
 7 0 6
 7 0 7
 7 1 0
 7 1 1
 7 1 2
 7 1 3
 7 1 4
 7 1 5
 7 1 6
 7 1 7
 7 2 0
 7 2 1
 7 2 2
 7 2 3
 7 2 4
 7 2 5
 7 2 6
 7 2 7
 7 3 0
 7 3 1
 7 3 2
 7 3 3
 7 3 4
 7 3 5
 7 3 6
 7 3 7
 7 4 0
 7 4 1
 7 4 2
 7 4 3
 7 4 4
 7 4 5
 7 4 6
 7 4 7
 7 5 0
56
 7 5 1
 7 5 2
 7 5 3
 7 5 4
 7 5 5
 7 5 6
 7 5 7
 7 6 0
 7 6 1
 7 6 2
 7 6 3
 7 6 4
 7 6 5
 7 6 6
 7 6 7
 7 7 0
 7 7 1
 7 7 2
 7 7 3
 7 7 4
 7 7 5
 7 7 6
 7 7 7] ;