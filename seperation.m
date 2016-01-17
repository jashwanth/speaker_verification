clear all;
clc;
allspk=dir('timitdata/*');
for i=3:length(allspk)
    str=allspk(i).name;
    mkdir(fullfile('traindata',str));
    mkdir(fullfile('testdata',str));
    wavall=dir(fullfile('timitdata',allspk(i).name,'*.wav'));
    for(j=1:8)   
        copyfile((fullfile('timitdata',allspk(i).name,wavall(j).name)),(fullfile('traindata',str,sprintf('%d.wav',j))),'f');
    end;
        for(j=9:10)
         copyfile((fullfile('timitdata',allspk(i).name,wavall(j).name)),(fullfile('testdata',str,sprintf('%d.wav',j))),'f');   
        end;
        
end;
