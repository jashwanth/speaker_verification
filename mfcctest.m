%to extract the mfcc features of the testingdata after removing silence
clear all;
clc;
a=dir('testwavdata/*');

for i=3:length(a)
    allwav=dir(fullfile('testwavdata',a(i).name,'*.wav'));
   
    for j=1:length(allwav)
          fname=fullfile('testwavdata',a(i).name,allwav(j).name);
          [y,FS,FFX]=wavread(fname);
          sig=y.*y;
          E=mean(sig);
          Threshold=0.04*E;
          k=1;
          for b=1:100:(length(sig)-100)
              if((sum(sig(b:b+100)))/100 > Threshold)
                  dest(k:k+100)=y(b:b+100);
                  k=k+100;
               end;
          end;
          dest=dest';
          clear  FS FFX Threshold E sig y ;
         
  
   % clear fname dest;        
 y1=mfcc_rasta_delta_pkm_v1(dest,8000,13,26,20,10,0,0,1);
 mkdir(fullfile('mfcc_test',a(i).name));
 save(fullfile('mfcc_test',a(i).name, regexprep(allwav(j).name, '.wav', '')),'y1');
 clear y1 dest fname  ;
end;
end;
