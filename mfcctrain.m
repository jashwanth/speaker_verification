clear all;
clc;
x1=0;
a=dir('trainwavdata/m*');
    
   for i=1:length(a)
       
      allwav=dir(fullfile('trainwavdata',a(i).name,'*.wav'));
      
        for j=1:length(allwav)
            fname=fullfile('trainwavdata',a(i).name,allwav(j).name);
           
                  [y fs]=wavread(fname);
                   clear fname;
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
          clear  FS Threshold E sig y ;
	              
                   dest=dest';
	              
                   if j==1
                       x1=dest;
                   else
                      x1=vertcat(x1,dest);
                   end;
        clear dest;
        end;
        
        y1=mfcc_rasta_delta_pkm_v1(x1,8000,13,26,20,10,0,0,1);
        save(fullfile('mfcc_train',a(i).name),'y1');
        clear y1,x1;
        
   end;
   
