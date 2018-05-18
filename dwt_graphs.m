%for graphs and all
numfiles = 32;
mydata1 = cell(1, numfiles);
spec=[];
hdr=lowpass_filter();
hda=alpha_band_filter();
hdb=beta_band_filter();
filter_data1 = cell(1,numfiles);
fs=128;
opfilename='testFile_01';
myfilename = sprintf('s0%d.mat', 1);
load(myfilename);
datastart=128*3;
datalength=8064-128*3;
framesize=6*128;
for video=1:1
    data1=zeros(1,datalength);
    for ii =1:datalength
        data1(1,ii)=data(video,4,datastart+ii);
    end
    %filter_data= filtfilt(hdr.Numerator,1,data1);
    start=0;
    %for wavesegmentloop=1:10
        data2=zeros(1,framesize);
        %take the wave segment in data2
        for jj =1:framesize
            data2(1,jj)=data1(1,start+jj);
        end
        start=start+framesize;
        %decompose into wavelets
        [c,l] = wavedec(data2,6,'db5');
        
        %visualize the wave:
        Lev=6;
        a3 = appcoef(c,l,'db5',Lev);
        subplot(2,1,1)
        plot(data1); title('Original Signal');
        subplot(2,1,2)
        plot(a3); title('Level 6- Approximation Coefficients');
        
        %first feature is relative wavelet energy Ea
        [Ea,Ed] = wenergy(c,l);
        %second feature sumEntropy, is wavelet shannon entropy
        sumEnergy=0;
        sumEntropy=0;
        for kk =1:6
            sumEnergy=Ed(1,kk)+sumEnergy;
        end
        for kk =1:6
            sumEntropy=Ed(1,kk)*log(Ed(1,kk)/sumEnergy);
        end
        %third feature is innovative which is coeff*their Sd
        innov=std(c);
        valence=labels(video,1);
        arousal=labels(video,2);
        op1=2;op2=2;combined=1;
        if(valence<5)
            op1=1;
        end
        if(arousal<5)
            op2=1;
        end
        if(valence<5 && arousal<5)
            combined=1;
        end
        if(valence<5 && arousal>5)
            combined=2;
        end
        if(valence>5 && arousal<5)
            combined=3;
        end
        if(valence>5 && arousal>5)
            combined=4;
        end
        fprintf('%d,%d,%d,%.3f,%.3f,%.3f,%d,%d,%d',1,video,wavesegmentloop,Ea,sumEntropy,innov,op1,op2,combined);
        fprintf('\n');
    %end
end 
fclose(myfilename);