/**/


data soccer;

input team $ attendance arrest;
cards;

AV 404 308
BC 286 197
LU 443 184
BM 169 149
WB 222 132
H 150 126
M 321 110
BG 189 101
IT 258 99
LC 223 81
BB 211 79
CP 215 78
S 108 68
ST 210 67
SU 224 60
SC 211 57
B 168 55
MW 185 44
HC 158 38
MC 429 35
P 226 29
R 150 20
O 148 19
;

proc genmod;
model arrest/attendance =/ dist=poi link=log;
