clear; clc;

%Screenshots
i = 1;
sc{i}.sample = 5;
sc{i}.MR_point = [26  42];
sc{i}.HE_ylim  = [13937  15747];
sc{i}.HE_xlim  = [8370  10230];
sc{i}.descrip  = 'High FA2D/IA with low bias has anisotropic tissue';

i = 2;
sc{i}.sample = 5;
sc{i}.MR_point = [63  29];
sc{i}.HE_xlim  = [9593  11403];
sc{i}.HE_ylim  = [22134  23994];
sc{i}.descrip  = 'low FA2D/IA with low bias has isotropic tissue';

i = 3;
sc{i}.sample = 5;
sc{i}.MR_point = [71  43];
sc{i}.HE_xlim  = [14661  16471];
sc{i}.HE_ylim  = [25482  27342];
sc{i}.descrip  = 'Red bias associated with "curly tissue"';

i = 4;
sc{i}.sample = 5;
sc{i}.MR_point = [45  46];
sc{i}.HE_xlim  = [15747  17557];
sc{i}.HE_ylim  = [15438  17298];
sc{i}.descrip  = 'Green bias associated with tears in the histology';

i = 5;
sc{i}.sample = 5;
sc{i}.MR_point = [22  32];
sc{i}.HE_xlim  = [10679  12489];
sc{i}.HE_ylim  = [7254  9114];
sc{i}.descrip  = 'Red bias associated histology that is anisotropic but circular';

i = 6;
sc{i}.sample = 3;
sc{i}.MR_point = [36  25];
sc{i}.HE_xlim  = [7290  8910];
sc{i}.HE_ylim  = [12261  14091];
sc{i}.descrip  = 'Higher IA has lots of small microcysts';

i = 7;
sc{i}.sample = 3;
sc{i}.MR_point = [41  53];
sc{i}.HE_xlim  = [16038  17658];
sc{i}.HE_ylim  = [13725  15555];
sc{i}.descrip  = 'Lower IA has lots of bigger microcysts';

i = 8;
sc{i}.sample = 3;
sc{i}.MR_point = [56  37];
sc{i}.HE_xlim  = [11178  12798];
sc{i}.HE_ylim  = [19581  21411];
sc{i}.descrip  = 'Higher IA vessels';

i = 9;
sc{i}.sample = 9;
sc{i}.MR_point = [57  18];
sc{i}.HE_xlim  = [5858  7878];
sc{i}.HE_ylim  = [20438  22313];
sc{i}.descrip  = 'Sample 9 no bias high IA';

i = 10;
sc{i}.sample = 9;
sc{i}.MR_point = [41  20];
sc{i}.HE_xlim  = [7070  9090];
sc{i}.HE_ylim  = [14438  16313];
sc{i}.descrip  = 'Sample 9 no bias low IA';

i = 11;
sc{i}.sample = 9;
sc{i}.MR_point = [76  51];
sc{i}.HE_xlim  = [19190  21210];
sc{i}.HE_ylim  = [27188  29063];
sc{i}.descrip  = 'Sample 9 no bias high IA';

i = 12;
sc{i}.sample = 9;
sc{i}.MR_point = [21  11];
sc{i}.HE_xlim  = [3434  5454];
sc{i}.HE_ylim  = [6563  8438];
sc{i}.descrip  = 'Sample 9 no bias low IA';

i = 13;
sc{i}.sample = 7;
sc{i}.MR_point = [54  17];
sc{i}.HE_xlim  = [5322  7157];
sc{i}.HE_ylim  = [18077  19832];
sc{i}.descrip  = 'Sample 7 no bias high IA';

i = 14;
sc{i}.sample = 7;
sc{i}.MR_point = [21   9];
sc{i}.HE_xlim  = [2019  3854];
sc{i}.HE_ylim  = [6143  7898];
sc{i}.descrip  = 'Sample 7 no bias low IA';

i = 15;
sc{i}.sample = 7;
sc{i}.MR_point = [74  40];
sc{i}.HE_xlim  = [13396  15231];
sc{i}.HE_ylim  = [25097  26852];
sc{i}.descrip  = 'Sample 7 no bias low IA';

i = 16;
sc{i}.sample = 7;
sc{i}.MR_point = [47  13];
sc{i}.HE_xlim  = [3854  5689];
sc{i}.HE_ylim  = [15269  17024];
sc{i}.descrip  = 'Sample 7 no bias high IA';

i = 17;
sc{i}.sample = 4;
sc{i}.MR_point = [21  48];
sc{i}.HE_xlim  = [15334  17019];
sc{i}.HE_ylim  = [6458  8303];
sc{i}.descrip  = 'Sample 4 no bias high IA';

i = 18;
sc{i}.sample = 4;
sc{i}.MR_point = [40  24];
sc{i}.HE_xlim  = [7246  8931];
sc{i}.HE_ylim  = [13469  15314];
sc{i}.descrip  = 'Sample 4 no bias low IA';

i = 19;
sc{i}.sample = 6;
sc{i}.MR_point = [15  56];
sc{i}.HE_xlim  = [18795  20585];
sc{i}.HE_ylim  = [4566  6551];
sc{i}.descrip  = 'Sample 6 no bias low IA';

i = 20;
sc{i}.sample = 6;
sc{i}.MR_point = [27  58];
sc{i}.HE_xlim  = [19869  21659];
sc{i}.HE_ylim  = [9727  11712];
sc{i}.descrip  = 'Sample 6 no bias low IA';

i = 21;
sc{i}.sample = 6;
sc{i}.MR_point = [35  43];
sc{i}.HE_xlim  = [14499  16289];
sc{i}.HE_ylim  = [12506  14491];
sc{i}.descrip  = 'Sample 6 no bias high IA';

i = 22;
sc{i}.sample = 6;
sc{i}.MR_point = [64  22];
sc{i}.HE_xlim  = [6981  8771];
sc{i}.HE_ylim  = [24416  26401];
sc{i}.descrip  = 'Sample 6 red bias';

i = 23;
sc{i}.sample = 6;
sc{i}.MR_point = [28  41];
sc{i}.HE_xlim  = [13783  15573];
sc{i}.HE_ylim  = [9727  11712];
sc{i}.descrip  = 'Sample 6 green bias';

i = 24;
sc{i}.sample = 8;
sc{i}.MR_point = [12  44];
sc{i}.HE_xlim  = [15066  16926];
sc{i}.HE_ylim  = [3211  4901];
sc{i}.descrip  = 'Sample 8 red bias';

i = 25;
sc{i}.sample = 8;
sc{i}.MR_point = [22  39];
sc{i}.HE_xlim  = [13578  15438];
sc{i}.HE_ylim  = [6591  8281];
sc{i}.descrip  = 'Sample 8 no bias';

i = 26;
sc{i}.sample = 8;
sc{i}.MR_point = [21  32];
sc{i}.HE_xlim  = [10974  12834];
sc{i}.HE_ylim  = [6253  7943];
sc{i}.descrip  = 'Sample 8 green bias';

i = 27;
sc{i}.sample = 10;
sc{i}.MR_point = [30  56];
sc{i}.HE_xlim  = [20055  21965];
sc{i}.HE_ylim  = [9779  11624];
sc{i}.descrip  = 'Sample 10 high IA';

i = 28;
sc{i}.sample = 10;
sc{i}.MR_point = [31  51];
sc{i}.HE_xlim  = [18527  20437];
sc{i}.HE_ylim  = [10148  11993];
sc{i}.descrip  = 'Sample 10 high IA no bias';

i = 29;
sc{i}.sample = 10;
sc{i}.MR_point = [64  37];
sc{i}.HE_xlim  = [13179  15089];
sc{i}.HE_ylim  = [22325  24170];
sc{i}.descrip  = 'Sample 10 low IA no bias';

i = 30;
sc{i}.sample = 10;
sc{i}.MR_point = [54  58];
sc{i}.HE_xlim  = [20819  22729];
sc{i}.HE_ylim  = [18635  20480];
sc{i}.descrip  = 'Sample 10 red bias';

i = 31;
sc{i}.sample = 10;
sc{i}.MR_point = [17  34];
sc{i}.HE_xlim  = [11651  13561];
sc{i}.HE_ylim  = [4982  6827];
sc{i}.descrip  = 'Sample 10 green bias';

i = 32;
sc{i}.sample = 10;
sc{i}.MR_point = [11  13];
sc{i}.HE_xlim  = [4011  5921];
sc{i}.HE_ylim  = [3137  4982];
sc{i}.descrip  = 'Sample 10 red bias';

i = 33;
sc{i}.sample = 10;
sc{i}.MR_point = [68  21];
sc{i}.HE_xlim  = [7067  8977];
sc{i}.HE_ylim  = [24170  26015];
sc{i}.descrip  = 'Sample 10 green bias';


%create the fig last
i = 34;
sc{i}.sample = 9;
sc{i}.MR_point = [52  18];
sc{i}.HE_xlim  = [5858  7878];
sc{i}.HE_ylim  = [18188  20063];
sc{i}.descrip  = 'Sample 9 no bias high IA';

i = 35;
sc{i}.sample = 6;
sc{i}.MR_point = [42  41];
sc{i}.HE_xlim  = [13425  15215];
sc{i}.HE_ylim  = [15682  17667];
sc{i}.descrip  = 'Sample 6 no bias high IA';

i = 36;
sc{i}.sample = 5;
sc{i}.MR_point = [23  22];
sc{i}.HE_xlim  = [6697  8507];
sc{i}.HE_ylim  = [7626  9486];
sc{i}.descrip  = 'Sample 5 no bias high IA';

i = 37;
sc{i}.sample = 5;
sc{i}.MR_point = [25  40];
sc{i}.HE_xlim  = [13575  15385];
sc{i}.HE_ylim  = [7998  9858];
sc{i}.descrip  = 'Sample 5 no bias high IA';

i = 38;
sc{i}.sample = 5;
sc{i}.MR_point = [19  54];
sc{i}.HE_xlim  = [18643  20453];
sc{i}.HE_ylim  = [6138  7998];
sc{i}.descrip  = 'Sample 5 no bias high IA';

i = 39;
sc{i}.sample = 5;
sc{i}.MR_point = [52  24];
sc{i}.HE_xlim  = [7421  9231];
sc{i}.HE_ylim  = [18042  19902];
sc{i}.descrip  = 'Sample 5 no bias low IA';

i = 40;
sc{i}.sample = 5;
sc{i}.MR_point = [48  18];
sc{i}.HE_xlim  = [5249  7059];
sc{i}.HE_ylim  = [16554  18414];
sc{i}.descrip  = 'Sample 5 no bias low IA';

i = 41;
sc{i}.sample = 5;
sc{i}.MR_point = [62  30];
sc{i}.HE_xlim  = [9955  11765];
sc{i}.HE_ylim  = [22134  23994];
sc{i}.descrip  = 'Sample 5 no bias low IA';

i = 42;
sc{i}.sample = 9;
sc{i}.MR_point = [64  30];
sc{i}.HE_xlim  = [10706  12726];
sc{i}.HE_ylim  = [23063  24938];
sc{i}.descrip  = 'Sample 9 no bias low IA';

i = 43;
sc{i}.sample = 9;
sc{i}.MR_point = [45  18];
sc{i}.HE_xlim  = [6262  8282];
sc{i}.HE_ylim  = [15938  17813];
sc{i}.descrip  = 'Sample 9 no bias low IA';

i = 44;
sc{i}.sample = 4;
sc{i}.MR_point = [40  23];
sc{i}.HE_xlim  = [6909  8594];
sc{i}.HE_ylim  = [13838  15683];
sc{i}.descrip  = 'Sample 4 no bias low IA';

i = 45;
sc{i}.sample = 4;
sc{i}.MR_point = [47  59];
sc{i}.HE_xlim  = [19041  20726];
sc{i}.HE_ylim  = [16052  17897];
sc{i}.descrip  = 'Sample 4 no bias low IA';





















%save all
for c_exp = 34:i
    disp(c_exp)
    load(fullfile('..','..','local_data',strcat(num2str(sc{c_exp}.sample)),'coreg_fine','ver1','HE.mat'),'HE');
    sc{c_exp}.im = HE(sc{c_exp}.HE_xlim(1):sc{c_exp}.HE_xlim(2),sc{c_exp}.HE_ylim(1):sc{c_exp}.HE_ylim(2),:);
end
save(fullfile('..','..','local_data','HE_screenshots_FAIP.mat'),'sc')


