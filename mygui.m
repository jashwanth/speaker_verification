function mygui()
   figure('Menubar','none','Name','spkr_verify_system','NumberTitle','off','Position',[100,100,600,600]);
    b1 =  uicontrol('Style','PushButton','String','load speaker model','Position',[150,400,300,50],...
    'CallBack',@b1Pressed);
   function b1Pressed(h, eventdata)
       [filename,pathname] = uigetfile('*.mat','Select the MATLAB code file');
       assignin('base','f1',filename);
       assignin('base','p1',pathname);
       uiimport(fullfile(pathname,filename));
       b2 =  uicontrol('Style','PushButton','String','load test file','Position',[20,300,200,50],...
    'CallBack',@b2Pressed);
     function b2Pressed(h, eventdata)
         [filename,pathname] = uigetfile('*.wav','Select the MATLAB file');
       assignin('base','f2',filename);
       assignin('base','p2',pathname);
       uiimport(fullfile(pathname,filename));
       b3 =  uicontrol('Style','PushButton','String','extract features','Position',[380,300,200,50],...
    'CallBack',@b3Pressed);
       function b3Pressed(h, eventdata)
           disp('extracting features.................');
           y2 = evalin('base', 'data');
           sig=y2.*y2;
           E=mean(sig);
           Threshold=0.04*E;
           k=1;
           dest = 0;
           for b=1:100:(length(sig)-100)
              if((sum(sig(b:b+100)))/100 > Threshold)
                  dest(k:k+100)=y2(b:b+100);
                  k=k+100;
              end;
          end;
          dest=dest';
           y3=mfcc_rasta_delta_pkm_v1(dest,8000,13,26,20,10,0,0,1);
           assignin('base','y3',y3);
           disp('feature extraction done.....');
           b4 =  uicontrol('Style','PushButton','String','check claimed speaker','Position',[150,200,300,50],...
    'CallBack',@b4Pressed);
            function b4Pressed(h, eventdata)
                threshold = 4218.2;
                p1 = evalin('base','p1');
                f1 = evalin('base','f1');
                a = dir(p1);
                mix1 = evalin('base','MIX');
                y1 = evalin('base','y3');
                verification = zeros(2,1);
               verification(1) = mean(log(gmmprob(mix1,y1))/length(y1));
               for k=3:length(a)
                if(~strcmp(f1,a(k).name))
                 assignin('base','mix1',load(fullfile(p1,a(k).name)));
                  verification(2) = verification(2) + mean(log(gmmprob(mix1,y1)/(length(a)-3)));
                end
               end
              tilda = verification(1)-verification(2)
              if(tilda < threshold)
                  msgbox('claimed spkr is true');
              else
                  msgbox('claimed spkr is false');
              end
            end;
       end
     end
   end
end

