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
for video=1:1
    data1=zeros(1,datalength);
    for ii =1:datalength
        data1(1,ii)=data(video,4,datastart+ii);
    end
    
%     Plot for PSD of raw data in microVolts   
    psd_r=spectrum(data1,256);
    hpsd_r = dspdata.psd(psd_r,'Fs',fs); % Create a PSD data object.
   % plot(hpsd_r);
    xlim([0 300]);
     
      filter_data= filtfilt(hdr.Numerator,1,data1);
      data2=filter_data;
      avpow = norm(data2,2)^2/numel(data2);
%     Plot for psd of filtered data
     psd_f=spectrum(data2,256);
     hpsd_f = dspdata.psd(psd_f,'Fs',fs); % Create a PSD data object.
     subplot(2,1,2);
     plot(hpsd_f);
     xlim([0 100]);
     hold all;
    
    avpow = norm(data1,2)^2/numel(data1);
    
    % %   delta band
    ts=(length(data1)/128);
    Wp = [1 4]/(fs/2); Ws = [0.5 4.5]/(fs/2);
    Rp = 3; Rs = 40;
    [n,Wn] = buttord(Wp,Ws,Rp,Rs);
    [z, p, k] = butter(n,Wn,'bandpass');
    [sos,g] = zp2sos(z,p,k);
    filt = dfilt.df2sos(sos,g);
    fd1 = filter(filt,data1);
    avpow1 = norm(fd1,2)^2/numel(fd1);
    
    % %  theta band
    Wp = [4 8]/(fs/2); Ws = [3.5 8.5]/(fs/2);
    [n,Wn] = buttord(Wp,Ws,Rp,Rs);
    [z, p, k] = butter(n,Wn,'bandpass');
    [sos,g] = zp2sos(z,p,k);
    filt = dfilt.df2sos(sos,g);
    fd2 = filter(filt,data1);
    avpow2 = norm(fd2,2)^2/numel(fd2);
    
    % %   alpha band
    Wp = [8 13]/(fs/2); Ws = [7.5 13.5]/(fs/2);
    [n,Wn] = buttord(Wp,Ws,Rp,Rs);
    [z, p, k] = butter(n,Wn,'bandpass');
    [sos,g] = zp2sos(z,p,k);
    filt = dfilt.df2sos(sos,g);
    fd3 = filter(filt,data1);
    fd3= filtfilt(hda.Numerator,1,data1);
    avpow3 = norm(fd3,2)^2/numel(fd3);
    
    % % beta band
    Wp = [13 30]/(fs/2); Ws = [12.5 30.5]/(fs/2);
    [n,Wn] = buttord(Wp,Ws,Rp,Rs);
    [z, p, k] = butter(n,Wn,'bandpass');
    [sos,g] = zp2sos(z,p,k);
    filt = dfilt.df2sos(sos,g);
    fd4 = filter(filt,data1);
    fd4= filtfilt(hdb.Numerator,1,data1);
    avpow4 = norm(fd4,2)^2/numel(fd4);
    
    sumpow=avpow1+avpow2+avpow3+avpow4;
    d_bpr=log10(avpow1/sumpow);
    t_bpr=log10(avpow2/sumpow);
    a_bpr=log10(avpow3/sumpow);
    b_bpr=log10(avpow4/sumpow);
    
    valence=labels(video,1);
    arousal=labels(video,2);
    dominance=labels(video,3);
    liking=labels(video,4);
    if(valence<5 && arousal<5)
        op=1;
    end
    if(valence<5 && arousal>5)
        op=2;
    end
    if(valence>5 && arousal<5)
        op=3;
    end
    if(valence>5 && arousal>5)
        op=4;
    end
   % fprintf(fid,'%d,%d,%.3f,%.3f,%.3f,%.3f,%d',1,video,d_bpr,t_bpr,a_bpr,b_bpr,op);
    fprintf(fid,'\n');
    
end %the tetcase loop
fclose(myfile);