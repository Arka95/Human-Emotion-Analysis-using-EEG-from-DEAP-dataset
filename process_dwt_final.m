numfiles = 32;
mydata1 = cell(1, numfiles);
spec=[];
hdr=lowpass_filter();
hda=alpha_band_filter();
hdb=beta_band_filter();
filter_data1 = cell(1,numfiles);
fs=128;
for channel=1:32%creating 32 testfiles i.e. 1 for each channel
    fprintf('\ncreating testfile number %d:\n',channel);
    if(channel<10)
        opfilename ='testFile_0';
    else
        opfilename='testFile_';
    end
    filename=[opfilename int2str(channel) '.txt'];filename;
    fid = fopen( filename, 'wt' );
    fprintf(fid,'user,video,wavesegment,energy,entropy,sd,valence,arousal,combined\n');
    for i = 1:numfiles
        fprintf('\nworking on file number %d:\n', i);
        if(i<10)
            myfilename = sprintf('s0%d.mat', i);
        else
            myfilename = sprintf('s%d.mat', i);
        end
        load(myfilename);
        datastart=128*3;
        datalength=8064-128*3;
        framesize=6*128;
        for video=1:40
            data1=zeros(1,8064-datastart);
            for ii =1:datalength
                data1(1,ii)=data(video,channel,ii+datastart);
            end
            %filter_data= filtfilt(hdr.Numerator,1,data1);
            start=0;
            %take the wavesegment from the main wave
            for wavesegmentloop=1:10
                
                data2=zeros(1,framesize);
                for jj =1:framesize
                    data2(1,jj)=data1(1,start+jj);
                end
                start=start+framesize;
                
                %decompose into wavelets
                [c,l] = wavedec(data2,6,'db5');
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
                %third feature is innovative which is coeff Sd
                dwtinnov=std(c);      
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
                fprintf(fid,'%d,%d,%d,%.3f,%.3f,%.3f,%d,%d,%d',i,video,wavesegmentloop,Ea,sumEntropy,innov,op1,op2,combined);
                fprintf(fid,'\n');
            end
            fprintf('.');
        end %the testcase loop
    end %the file loop
    fclose(fid);
end