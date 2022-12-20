clear; clc;

%Screenshots
i = 1;
sc{i}.sample = 3;
sc{i}.MR_point = [41 50];
sc{i}.HE_ylim  = [13725  15555];
sc{i}.HE_xlim  = [15390  17010];
sc{i}.descrip  = 'MD biased green, Microcysts in microcystic/angiomatous huge';

i = 2;
sc{i}.sample = 3;
sc{i}.MR_point = [30  28];
sc{i}.HE_xlim  = [8262  9882];
sc{i}.HE_ylim  = [10065  11895];
sc{i}.descrip  = 'MD works well, only few microcysts';

i = 3;
sc{i}.sample = 5;
sc{i}.MR_point = [27  54];
sc{i}.HE_xlim  = [18643  20453];
sc{i}.HE_ylim  = [9114  10974];
sc{i}.descrip  = 'High cell density and no bias';

i = 4;
sc{i}.sample = 5;
sc{i}.MR_point = [54  18];
sc{i}.HE_xlim  = [5249  7059];
sc{i}.HE_ylim  = [18786  20646];
sc{i}.descrip  = 'Low cell density and no bias';

i = 5;
sc{i}.sample = 6;
sc{i}.MR_point = [32  60];
sc{i}.HE_xlim  = [20585  22375];
sc{i}.HE_ylim  = [11711 13696];
sc{i}.descrip  = 'Circular structures in meningothelial meningioma';

i = 6;
sc{i}.sample = 7;
sc{i}.MR_point = [41  37];
sc{i}.HE_xlim  = [12662  14497];
sc{i}.HE_ylim  = [13514  15269];
sc{i}.descrip  = 'Are these vessels? Sample 7, red bias';

i = 7;
sc{i}.sample = 7;
sc{i}.MR_point = [25  40];
sc{i}.HE_xlim  = [13396  15231];
sc{i}.HE_ylim  = [7547  9302];
sc{i}.descrip  = 'Is this stroma? Sample 7 green bias';

i = 8;
sc{i}.sample = 7;
sc{i}.MR_point = [70  45];
sc{i}.HE_xlim  = [15598  17433];
sc{i}.HE_ylim  = [23693  25448];
sc{i}.descrip  = 'Collagen? Sample 7, green bias';

i = 9;
sc{i}.sample = 9;
sc{i}.MR_point = [34  14];
sc{i}.HE_xlim  = [4646  6666];
sc{i}.HE_ylim  = [11438  13313];
sc{i}.descrip  = 'Sample 9, psammoma bodies, green bias';

i = 10;
sc{i}.sample = 10;
sc{i}.MR_point = [47  34];
sc{i}.HE_xlim  = [11651  13561];
sc{i}.HE_ylim  = [16052  17897];
sc{i}.descrip  = 'Sample 10, what is this? strong green bias';

i = 11;
sc{i}.sample = 10;
sc{i}.MR_point = [55  35];
sc{i}.HE_xlim  = [12415  14325];
sc{i}.HE_ylim  = [19373  21218];
sc{i}.descrip  = 'Sample 10, stroma? red bias';

i = 12;
sc{i}.sample = 10;
sc{i}.MR_point = [68  54];
sc{i}.HE_xlim  = [19673  21583];
sc{i}.HE_ylim  = [23801  25646];
sc{i}.descrip  = 'Sample 10, Lymphocytes? strong red bias';

i = 13;
sc{i}.sample = 11;
sc{i}.MR_point = [58  27];
sc{i}.HE_xlim  = [7943  9633];
sc{i}.HE_ylim  = [19148  20873];
sc{i}.descrip  = 'Sample 11, dense tissue, strong green bias';

i = 14;
sc{i}.sample = 11;
sc{i}.MR_point = [48  25];
sc{i}.HE_xlim  = [7267  8957];
sc{i}.HE_ylim  = [15353  17078];
sc{i}.descrip  = 'Sample 11, loose tissue, no bias';

i = 15;
sc{i}.sample = 11;
sc{i}.MR_point = [16  24];
sc{i}.HE_xlim  = [7267  8957];
sc{i}.HE_ylim  = [4658  6383];
sc{i}.descrip  = 'Sample 11, stroma tissue, red bias';

i = 16;
sc{i}.sample = 12;
sc{i}.MR_point = [39  32];
sc{i}.HE_xlim  = [9662  11357];
sc{i}.HE_ylim  = [13277  15147];
sc{i}.descrip  = 'Sample 12, what is this, green bias';

i = 17;
sc{i}.sample = 16;
sc{i}.MR_point = [43  25];
sc{i}.HE_xlim  = [8393  10258];
sc{i}.HE_ylim  = [15998  17973];
sc{i}.descrip  = 'Sample 16, stroma?, green bias';

i = 18;
sc{i}.sample = 16;
sc{i}.MR_point = [68  30];
sc{i}.HE_xlim  = [10258  12123];
sc{i}.HE_ylim  = [25873  27848];
sc{i}.descrip  = 'Sample 16, what is it?, red bias';

i = 19;
sc{i}.sample = 16;
sc{i}.MR_point = [43  45];
sc{i}.HE_xlim  = [15853  17718];
sc{i}.HE_ylim  = [15998  17973];
sc{i}.descrip  = 'Sample 16, no bias';

i = 20;
sc{i}.sample = 4;
sc{i}.MR_point = [28  27];
sc{i}.HE_xlim  = [8257  9942];
sc{i}.HE_ylim  = [9041  10886];
sc{i}.descrip  = 'Sample 4, pink ordered stroma stripes? green bias';

i = 21;
sc{i}.sample = 4;
sc{i}.MR_point = [38  18];
sc{i}.HE_xlim  = [5224  6909];
sc{i}.HE_ylim  = [13100  14945];
sc{i}.descrip  = 'Sample 4, more stroma? green bias';

i = 22;
sc{i}.sample = 3;
sc{i}.MR_point = [29  45];
sc{i}.HE_xlim  = [13446  15066];
sc{i}.HE_ylim  = [9333  11163];
sc{i}.descrip  = 'Sample 3, vessels explain variability';

i = 23;
sc{i}.sample = 1;
sc{i}.MR_point = [44  46];
sc{i}.HE_xlim  = [15513  17338];
sc{i}.HE_ylim  = [16725  18740];
sc{i}.descrip  = 'Sample 1, green bias';

i = 24;
sc{i}.sample = 2;
sc{i}.MR_point = [30  17];
sc{i}.HE_xlim  = [3996  5476];
sc{i}.HE_ylim  = [9625  11375];
sc{i}.descrip  = 'Sample 2, green bias, compare with red one';

i = 25;
sc{i}.sample = 2;
sc{i}.MR_point = [8  20];
sc{i}.HE_xlim  = [4884  6364];
sc{i}.HE_ylim  = [1925  3675];
sc{i}.descrip  = 'Sample 2, red bias, compare with green one';

i = 26;
sc{i}.sample = 3;
sc{i}.MR_point = [14  29];
sc{i}.HE_xlim  = [8586  10206];
sc{i}.HE_ylim  = [4209  6039];
sc{i}.descrip  = 'Sample 3, green bias is usually microcyst but this is also green! What is it?';

i = 27;
sc{i}.sample = 3;
sc{i}.MR_point = [24  24];
sc{i}.HE_xlim  = [6966  8586];
sc{i}.HE_ylim  = [7869  9699];
sc{i}.descrip  = 'Sample 3, what is this? It has high cellularity';

i = 28;
sc{i}.sample = 4;
sc{i}.MR_point = [66  43];
sc{i}.HE_xlim  = [13312  14997];
sc{i}.HE_ylim  = [23432  25277];
sc{i}.descrip  = 'Sample 4, what is this? Green bias';

i = 29;
sc{i}.sample = 4;
sc{i}.MR_point = [27  27];
sc{i}.HE_xlim  = [8257  9942];
sc{i}.HE_ylim  = [9041  10886];
sc{i}.descrip  = 'Sample 4, what is this? Green bias';

i = 30;
sc{i}.sample = 4;
sc{i}.MR_point = [45  32];
sc{i}.HE_xlim  = [9605  11290];
sc{i}.HE_ylim  = [15314  17159];
sc{i}.descrip  = 'Sample 4, what is this? Red bias';

i = 31;
sc{i}.sample = 5;
sc{i}.MR_point = [13  21];
sc{i}.HE_xlim  = [6697  8507];
sc{i}.HE_ylim  = [3534  5394];
sc{i}.descrip  = 'Sample 5, Green bias, "full tissue"';

i = 32;
sc{i}.sample = 5;
sc{i}.MR_point = [57  47];
sc{i}.HE_xlim  = [16109  17919];
sc{i}.HE_ylim  = [20274  22134];
sc{i}.descrip  = 'Sample 5, Red bias, loose tissue';

i = 33;
sc{i}.sample = 5;
sc{i}.MR_point = [28  54];
sc{i}.HE_xlim  = [18281  20091];
sc{i}.HE_ylim  = [9114  10974];
sc{i}.descrip  = 'Sample 5, high cellularity, no bias';

i = 34;
sc{i}.sample = 5;
sc{i}.MR_point = [55  17];
sc{i}.HE_xlim  = [5249  7059];
sc{i}.HE_ylim  = [19158  21018];
sc{i}.descrip  = 'Sample 5, low cellularity, no bias';

i = 35;
sc{i}.sample = 5;
sc{i}.MR_point = [38  18];
sc{i}.HE_xlim  = [5249  7059];
sc{i}.HE_ylim  = [13206  15066];
sc{i}.descrip  = 'Sample 5, green bias collagen?';

i = 36;
sc{i}.sample = 5;
sc{i}.MR_point = [61  52];
sc{i}.HE_xlim  = [17919  19729];
sc{i}.HE_ylim  = [21390  23250];
sc{i}.descrip  = 'Sample 5, red bias vessels?';

i = 37;
sc{i}.sample = 6;
sc{i}.MR_point = [34  58];
sc{i}.HE_xlim  = [19869  21659];
sc{i}.HE_ylim  = [12506  14491];
sc{i}.descrip  = 'Sample 6, what is this green bias?';

i = 38;
sc{i}.sample = 6;
sc{i}.MR_point = [19  34];
sc{i}.HE_xlim  = [11277  13067];
sc{i}.HE_ylim  = [6154  8139];
sc{i}.descrip  = 'Sample 6, what is this red bias?';

i = 39;
sc{i}.sample = 6;
sc{i}.MR_point = [11  28];
sc{i}.HE_xlim  = [9129  10919];
sc{i}.HE_ylim  = [3375  5360];
sc{i}.descrip  = 'Sample 6, high cellularity no bias?';

i = 40;
sc{i}.sample = 6;
sc{i}.MR_point = [52  36];
sc{i}.HE_xlim  = [11993  13783];
sc{i}.HE_ylim  = [19255  21240];
sc{i}.descrip  = 'Sample 6, high cellularity no bias?';

i = 41;
sc{i}.sample = 7;
sc{i}.MR_point = [31  35];
sc{i}.HE_xlim  = [11561  13396];
sc{i}.HE_ylim  = [10004  11759];
sc{i}.descrip  = 'Sample 7, what is the red bias?';

i = 42;
sc{i}.sample = 9;
sc{i}.MR_point = [22  38];
sc{i}.HE_xlim  = [13938  15958];
sc{i}.HE_ylim  = [7313  9188];
sc{i}.descrip  = 'Sample 9, green bias, low cellularity tear or something else';

i = 43;
sc{i}.sample = 9;
sc{i}.MR_point = [61  17];
sc{i}.HE_xlim  = [5858  7878];
sc{i}.HE_ylim  = [21563  23438];
sc{i}.descrip  = 'Sample 9, red bias, tear or something else?';

i = 44;
sc{i}.sample = 10;
sc{i}.MR_point = [56  34];
sc{i}.HE_xlim  = [11651  13561];
sc{i}.HE_ylim  = [19742  21587];
sc{i}.descrip  = 'Sample 10, red bias, collagen?';

i = 45;
sc{i}.sample = 10;
sc{i}.MR_point = [46  36];
sc{i}.HE_xlim  = [12415  14325];
sc{i}.HE_ylim  = [16052  17897];
sc{i}.descrip  = 'Sample 10, green bias, what is it?';

i = 46;
sc{i}.sample = 10;
sc{i}.MR_point = [43  19];
sc{i}.HE_xlim  = [5921  7831];
sc{i}.HE_ylim  = [14945  16790];
sc{i}.descrip  = 'Sample 10, green bias, what is it?';

i = 47;
sc{i}.sample = 11;
sc{i}.MR_point = [31  55];
sc{i}.HE_xlim  = [17407  19097];
sc{i}.HE_ylim  = [9488  11213];
sc{i}.descrip  = 'Sample 11, high celluarity, what is it?';

i = 48;
sc{i}.sample = 12;
sc{i}.MR_point = [39  31];
sc{i}.HE_xlim  = [9323  11018];
sc{i}.HE_ylim  = [13277  15147];
sc{i}.descrip  = 'Sample 12, what is green bias with low cellularity?';

i = 49;
sc{i}.sample = 12;
sc{i}.MR_point = [43  18];
sc{i}.HE_xlim  = [4916  6611];
sc{i}.HE_ylim  = [14773  16643];
sc{i}.descrip  = 'Sample 12, high MD so it was there before?';

i = 50;
sc{i}.sample = 12;
sc{i}.MR_point = [14  42];
sc{i}.HE_xlim  = [13391  15086];
sc{i}.HE_ylim  = [4301  6171];
sc{i}.descrip  = 'Sample 12, no bias, it looks like this everywhere withough bias';

i = 51;
sc{i}.sample = 14;
sc{i}.MR_point = [31  13];
sc{i}.HE_xlim  = [2679  4089];
sc{i}.HE_ylim  = [11343  13333];
sc{i}.descrip  = 'Sample 14, red bias';

i = 52;
sc{i}.sample = 14;
sc{i}.MR_point = [32  34];
sc{i}.HE_xlim  = [8883  10293];
sc{i}.HE_ylim  = [11741  13731];
sc{i}.descrip  = 'Sample 14, green bias';

i = 53;
sc{i}.sample = 14;
sc{i}.MR_point = [8  36];
sc{i}.HE_xlim  = [9165  10575];
sc{i}.HE_ylim  = [2189  4179];
sc{i}.descrip  = 'Sample 14, also red bias but looks like green';

i = 54;
sc{i}.sample = 15;
sc{i}.MR_point = [59  44];
sc{i}.HE_xlim  = [17132  19247];
sc{i}.HE_ylim  = [22487  24477];
sc{i}.descrip  = 'Sample 15, high MD, vessel and red bias';

i = 55;
sc{i}.sample = 15;
sc{i}.MR_point = [25  14];
sc{i}.HE_xlim  = [4442  6557];
sc{i}.HE_ylim  = [8955  10945];
sc{i}.descrip  = 'Sample 15, high MD and what is this red bias?';

i = 56;
sc{i}.sample = 15;
sc{i}.MR_point = [29  36];
sc{i}.HE_xlim  = [14171  16286];
sc{i}.HE_ylim  = [10547  12537];
sc{i}.descrip  = 'Sample 15, what is this creating green bias?';

i = 57;
sc{i}.sample = 16;
sc{i}.MR_point = [43  26];
sc{i}.HE_xlim  = [8393  10258];
sc{i}.HE_ylim  = [15603  17578];
sc{i}.descrip  = 'Sample 16, green bias';

i = 58;
sc{i}.sample = 16;
sc{i}.MR_point = [53  54];
sc{i}.HE_xlim  = [18837  20702];
sc{i}.HE_ylim  = [19948  21923];
sc{i}.descrip  = 'Sample 16, red bias type I';

i = 59;
sc{i}.sample = 16;
sc{i}.MR_point = [69  29];
sc{i}.HE_xlim  = [9885  11750];
sc{i}.HE_ylim  = [25873  27848];
sc{i}.descrip  = 'Sample 16, red bias type II';

i = 60;
sc{i}.sample = 7;
sc{i}.MR_point = [47  23];
sc{i}.HE_xlim  = [7157  8992];
sc{i}.HE_ylim  = [15269  17024];
sc{i}.descrip  = 'Sample 7, no bias close to vessel region for an offset';

i = 61;
sc{i}.sample = 9;
sc{i}.MR_point = [44  35];
sc{i}.HE_xlim  = [12726  14746];
sc{i}.HE_ylim  = [15188  17063];
sc{i}.descrip  = 'Sample 9, no bias close to psammoma bodies region for an offset';

i = 62;
sc{i}.sample = 3;
sc{i}.MR_point = [35  45];
sc{i}.HE_xlim  = [13770  15390];
sc{i}.HE_ylim  = [11529  13359];
sc{i}.descrip  = 'Sample 3, no bias no cellularity but high MD';

i = 63;
sc{i}.sample = 3;
sc{i}.MR_point = [51  15];
sc{i}.HE_xlim  = [4050  5670];
sc{i}.HE_ylim  = [17385  19215];
sc{i}.descrip  = 'Sample 3, no bias no cellularity but low MD';

i = 64;
sc{i}.sample = 4;
sc{i}.MR_point = [46  11];
sc{i}.HE_xlim  = [2528  4213];
sc{i}.HE_ylim  = [15683  17528];
sc{i}.descrip  = 'Sample 4, no bias no cellularity but low MD';

i = 65;
sc{i}.sample = 4;
sc{i}.MR_point = [46  40];
sc{i}.HE_xlim  = [ 12301  13986];
sc{i}.HE_ylim  = [15683  17528];
sc{i}.descrip  = 'Sample 4, no bias no cellularity but high MD';

i = 66;
sc{i}.sample = 5;
sc{i}.MR_point = [22  19];
sc{i}.HE_xlim  = [5973  7783];
sc{i}.HE_ylim  = [6882  8742];
sc{i}.descrip  = 'Sample 5, no bias no cellularity but high MD';

i = 67;
sc{i}.sample = 5;
sc{i}.MR_point = [22  19];
sc{i}.HE_xlim  = [5973  7783];
sc{i}.HE_ylim  = [6882  8742];
sc{i}.descrip  = 'Sample 5, no bias no cellularity but high MD';

i = 68;
sc{i}.sample = 5;
sc{i}.MR_point = [24  58];
sc{i}.HE_xlim  = [19729  21539];
sc{i}.HE_ylim  = [7998  9858];
sc{i}.descrip  = 'Sample 5, no bias no cellularity but low MD';

i = 69;
sc{i}.sample = 7;
sc{i}.MR_point = [48  12];
sc{i}.HE_xlim  = [3120  4955];
sc{i}.HE_ylim  = [15971  17726];
sc{i}.descrip  = 'Sample 7, no bias no cellularity but high MD';

i = 70;
sc{i}.sample = 7;
sc{i}.MR_point = [76  46];
sc{i}.HE_xlim  = [15598  17433];
sc{i}.HE_ylim  = [25448  27203];
sc{i}.descrip  = 'Sample 7, no bias no cellularity but low MD';

i = 71;
sc{i}.sample = 8;
sc{i}.MR_point = [38  26];
sc{i}.HE_xlim  = [8742  10602];
sc{i}.HE_ylim  = [11661  13351];
sc{i}.descrip  = 'Sample 8, no bias no cellularity but high MD';

i = 72;
sc{i}.sample = 8;
sc{i}.MR_point = [42   9];
sc{i}.HE_xlim  = [2418  4278];
sc{i}.HE_ylim  = [13351  15041];
sc{i}.descrip  = 'Sample 8, no bias no cellularity but low MD';

i = 73;
sc{i}.sample = 10;
sc{i}.MR_point = [78  50];
sc{i}.HE_xlim  = [17763  19673];
sc{i}.HE_ylim  = [27491  29336];
sc{i}.descrip  = 'Sample 10, no bias no cellularity but high MD';

i = 74;
sc{i}.sample = 10;
sc{i}.MR_point = [67  29];
sc{i}.HE_xlim  = [10123  12033];
sc{i}.HE_ylim  = [23801  25646];
sc{i}.descrip  = 'Sample 10, no bias no cellularity but low MD';

i = 75;
sc{i}.sample = 5;
sc{i}.MR_point = [11  22];
sc{i}.HE_xlim  = [7059  8869];
sc{i}.HE_ylim  = [3162  5022];
sc{i}.descrip  = 'Sample 5, green bias';

i = 76;
sc{i}.sample = 5;
sc{i}.MR_point = [15  46];
sc{i}.HE_xlim  = [15385  17195];
sc{i}.HE_ylim  = [4278  6138];
sc{i}.descrip  = 'Sample 5, green bias';

i = 77;
sc{i}.sample = 5;
sc{i}.MR_point = [78  35];
sc{i}.HE_xlim  = [11403  13213];
sc{i}.HE_ylim  = [27714  29574];
sc{i}.descrip  = 'Sample 5, green bias';

i = 78;
sc{i}.sample = 5;
sc{i}.MR_point = [36  24];
sc{i}.HE_xlim  = [7783  9593];
sc{i}.HE_ylim  = [12090  13950];
sc{i}.descrip  = 'Sample 5, no bias test cell high MD, no good';

i = 79;
sc{i}.sample = 16;
sc{i}.MR_point = [57  41];
sc{i}.HE_xlim  = [14361  16226];
sc{i}.HE_ylim  = [21528  23503];
sc{i}.descrip  = 'Sample 16, no bias';

i = 80;
sc{i}.sample = 10;
sc{i}.MR_point = [53  24];
sc{i}.HE_xlim  = [8213  10123];
sc{i}.HE_ylim  = [18635  20480];
sc{i}.descrip  = 'Sample 10, no bias';

i = 81;
sc{i}.sample = 3;
sc{i}.MR_point = [46  13];
sc{i}.HE_xlim  = [3078  4698];
sc{i}.HE_ylim  = [15921  17751];
sc{i}.descrip  = 'Sample 3, no bias';






i = 82;
sc{i}.sample = 5;
sc{i}.MR_point = [37  31];
sc{i}.HE_xlim  = [10317  12127];
sc{i}.HE_ylim  = [12462  14322];
sc{i}.descrip  = 'Sample 5, no bias';

i = 83;
sc{i}.sample = 6;
sc{i}.MR_point = [15  46];
sc{i}.HE_xlim  = [15573  17363];
sc{i}.HE_ylim  = [4566  6551];
sc{i}.descrip  = 'Sample 6, no bias';

i = 84;
sc{i}.sample = 6;
sc{i}.MR_point = [32  60];
sc{i}.HE_xlim  = [20585  22375];
sc{i}.HE_ylim  = [11712  13697];
sc{i}.descrip  = 'Sample 6, very green bias';

i = 85;
sc{i}.sample = 16;
sc{i}.MR_point = [61  27];
sc{i}.HE_xlim  = [9139  11004];
sc{i}.HE_ylim  = [22713  24688];
sc{i}.descrip  = 'Sample 16, no bias';

i = 86;
sc{i}.sample = 3;
sc{i}.MR_point = [21  25];
sc{i}.HE_xlim  = [6966  8586];
sc{i}.HE_ylim  = [6771  8601];
sc{i}.descrip  = 'Sample 3, no bias but high cellularity';

i = 87;
sc{i}.sample = 3;
sc{i}.MR_point = [67  30];
sc{i}.HE_xlim  = [8910  10530];
sc{i}.HE_ylim  = [23607  25437];
sc{i}.descrip  = 'Sample 3, no bias but low cellularity';

i = 88;
sc{i}.sample = 16;
sc{i}.MR_point = [47  23];
sc{i}.HE_xlim  = [7647  9512];
sc{i}.HE_ylim  = [17578  19553];
sc{i}.descrip  = 'Sample 16, strong tumor stroma';

i = 89;
sc{i}.sample = 16;
sc{i}.MR_point = [36  15];
sc{i}.HE_xlim  = [4290  6155];
sc{i}.HE_ylim  = [12838  14813];
sc{i}.descrip  = 'Sample 16, less strong tumor stroma';














%save all
for c_exp = 88:i
    disp(c_exp)
    load(fullfile('local_data',strcat(num2str(sc{c_exp}.sample)),'coreg_fine','ver1','HE.mat'),'HE');
    sc{c_exp}.im = HE(sc{c_exp}.HE_xlim(1):sc{c_exp}.HE_xlim(2),sc{c_exp}.HE_ylim(1):sc{c_exp}.HE_ylim(2),:);
end
save('HE_screenshots_MD.mat','sc')


