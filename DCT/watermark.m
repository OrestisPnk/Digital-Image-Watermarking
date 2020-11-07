clc;
close all;
clear;

Im=load('Eikona1.mat');
I=Im.flower;
figure
imshow(I);

block_size=16;
%Plithos block ana diastash
dimensions1=round(size(I,1)/block_size);
dimensions2=round(size(I,2)/block_size);
blockCounter=dimensions1*dimensions2;

% Pseudotuxaioi-Kleidia antistoixishs block watermark sta block ths eikonas
blockIndex = randperm(dimensions1*dimensions2);

%%Dhmiourgia deiktwn block Ydatografhmatos
colsWaterBlockIndex=mod((blockIndex-1),dimensions2);
rowsWaterBlockIndex=zeros(1,length(blockIndex));

if block_size==32
    for i=1 : length(blockIndex)
            if (blockIndex(i)>=1 && blockIndex(i)<=8)
                rowsWaterBlockIndex(i)=0;
            elseif blockIndex(i)>=9 && blockIndex(i)<=16
                rowsWaterBlockIndex(i)=1;
            elseif blockIndex(i)>=17 && blockIndex(i)<=24
                rowsWaterBlockIndex(i)=2;
            elseif blockIndex(i)>=25 && blockIndex(i)<=32
                rowsWaterBlockIndex(i)=3;
            elseif blockIndex(i)>=33 && blockIndex(i)<=40
                rowsWaterBlockIndex(i)=4;
            elseif blockIndex(i)>=41 && blockIndex(i)<=48
                rowsWaterBlockIndex(i)=5;
            elseif blockIndex(i)>=49 && blockIndex(i)<=56
                rowsWaterBlockIndex(i)=6;
            else blockIndex(i)>=57;
                rowsWaterBlockIndex(i)=7;
            end
    end
    %%%Dhmiourgia deiktwn block Arxikhs Eikonas
    rowsImageBlockIndex=[zeros(1,dimensions1), ones(1,dimensions1),2*ones(1,dimensions1),3*ones(1,dimensions1),4*ones(1,dimensions1),5*ones(1,dimensions1),6*ones(1,dimensions1),7*ones(1,dimensions1)];
    colsImageBlockIndex=[0:1:(dimensions1-1),0:1:(dimensions1-1),0:1:(dimensions1-1),0:1:(dimensions1-1),0:1:(dimensions1-1),0:1:(dimensions1-1),0:1:(dimensions1-1),0:1:(dimensions1-1)];
else
   for i=1 : length(blockIndex)
        if blockIndex(i)>=1 && blockIndex(i)<=16
            rowsWaterBlockIndex(i)=0;
        elseif blockIndex(i)>=17 && blockIndex(i)<=32
            rowsWaterBlockIndex(i)=1;
        elseif blockIndex(i)>=33 && blockIndex(i)<=48
            rowsWaterBlockIndex(i)=2;
        elseif blockIndex(i)>=49 && blockIndex(i)<=64
            rowsWaterBlockIndex(i)=3;
        elseif blockIndex(i)>=65 && blockIndex(i)<=80
            rowsWaterBlockIndex(i)=4;
        elseif blockIndex(i)>=81 && blockIndex(i)<=96
            rowsWaterBlockIndex(i)=5;
        elseif blockIndex(i)>=97 && blockIndex(i)<=112
            rowsWaterBlockIndex(i)=6;
        elseif blockIndex(i)>=113 && blockIndex(i)<=128
            rowsWaterBlockIndex(i)=7;
        elseif blockIndex(i)>=129 && blockIndex(i)<=144
            rowsWaterBlockIndex(i)=8;
        elseif blockIndex(i)>=145 && blockIndex(i)<=160
            rowsWaterBlockIndex(i)=9;
        elseif blockIndex(i)>=161 && blockIndex(i)<=176
            rowsWaterBlockIndex(i)=10;
        elseif blockIndex(i)>=177 && blockIndex(i)<=192
            rowsWaterBlockIndex(i)=11;
        elseif blockIndex(i)>=193 && blockIndex(i)<=208
            rowsWaterBlockIndex(i)=12;
        elseif blockIndex(i)>=209 && blockIndex(i)<=224
            rowsWaterBlockIndex(i)=13;
        elseif blockIndex(i)>=225 && blockIndex(i)<=240
            rowsWaterBlockIndex(i)=14;
        else blockIndex(i)>=241;
            rowsWaterBlockIndex(i)=15;
        end
   end
   %%%Dhmiourgia deiktwn block Arxikhs Eikonas
    rowsImageBlockIndex=[zeros(1,dimensions1), ones(1,dimensions1),2*ones(1,dimensions1),3*ones(1,dimensions1),4*ones(1,dimensions1),5*ones(1,dimensions1),6*ones(1,dimensions1),7*ones(1,dimensions1),8*ones(1,dimensions1),9*ones(1,dimensions1),10*ones(1,dimensions1),11*ones(1,dimensions1),12*ones(1,dimensions1),13*ones(1,dimensions1),14*ones(1,dimensions1),15*ones(1,dimensions1)];
    colsImageBlockIndex=[0:1:(dimensions1-1), 0:1:(dimensions1-1), 0:1:(dimensions1-1), 0:1:(dimensions1-1), 0:1:(dimensions1-1), 0:1:(dimensions1-1), 0:1:(dimensions1-1), 0:1:(dimensions1-1), 0:1:(dimensions1-1), 0:1:(dimensions1-1), 0:1:(dimensions1-1), 0:1:(dimensions1-1), 0:1:(dimensions1-1), 0:1:(dimensions1-1), 0:1:(dimensions1-1), 0:1:(dimensions1-1)];

end

%%
RecoveredWaterBlock=zeros(size(I,1));
co=zeros(block_size,block_size,blockCounter);
coTemp=zeros(block_size,block_size,blockCounter);
wa=zeros(block_size,block_size,blockCounter);
coAfter=zeros(block_size);
Nuulll=zeros(256,256);
Water = randi([0 1], size(I,1),size(I,2));
figure
imshow(Water);
offset=0.001;
midFreq=3;
for i = 1 : blockCounter
    ImageBlock=I((((1+(rowsImageBlockIndex(i)*block_size))):((1+rowsImageBlockIndex(i))*block_size)),((1+(colsImageBlockIndex(i)*block_size)):(1+colsImageBlockIndex(i))*block_size));

    coef=dct2(ImageBlock);

    WaterBlock=Water((((1+(rowsWaterBlockIndex(i)*block_size))):((1+rowsWaterBlockIndex(i))*block_size)),((1+(colsWaterBlockIndex(i)*block_size)):(1+colsWaterBlockIndex(i))*block_size));

    for k = 1 : block_size
        for l = 1 : block_size
            if (coef(k,l)<0) && (WaterBlock(k,l)==1)
                coef(k,l)=offset;
            elseif (coef(k,l)>0) && (WaterBlock(k,l)==0)
                coef(k,l)=-offset;
            end
        end
    end
    
    recovered=zeros(block_size);
    renew=coef>0;
    %ANAKTHSH PSEUDOTYXAIOY ME ARXIKO STA LOW HIGH KAI NEES DIAGWNIOYS 
    for j=-midFreq:midFreq
         recovered=WaterBlock-flip(diag(diag(flip(WaterBlock),j),j))+flip(diag(diag(flip(renew),j),j));
    end
    RecoveredWaterBlock((((1+(rowsWaterBlockIndex(i)*block_size))):((1+rowsWaterBlockIndex(i))*block_size)),((1+(colsWaterBlockIndex(i)*block_size)):(1+colsWaterBlockIndex(i))*block_size))=recovered;
    Inverse=idct2(coef);
    Nuulll(((1+rowsImageBlockIndex(i)*block_size):((1+rowsImageBlockIndex(i))*block_size)),((1+colsImageBlockIndex(i)*block_size):((1+colsImageBlockIndex(i))*block_size)))=Inverse;
end
figure
imshow(Nuulll)
result=Water-RecoveredWaterBlock

% Rec=zeros(block_size);
% Recovered=zeros(256);
% for i = 1 : blockCounter
%     ImageBlock=Nuulll((((1+(rowsImageBlockIndex(i)*block_size))):((1+rowsImageBlockIndex(i))*block_size)),((1+(colsImageBlockIndex(i)*block_size)):(1+colsImageBlockIndex(i))*block_size));
%     WaterBlock=Water((((1+(rowsWaterBlockIndex(i)*block_size))):((1+rowsWaterBlockIndex(i))*block_size)),((1+(colsWaterBlockIndex(i)*block_size)):(1+colsWaterBlockIndex(i))*block_size));
%     coef2=dct2(ImageBlock);
%     Temp=coef2>0;
%     for j=-midFreq:midFreq
%         Rec=WaterBlock-flip(diag(diag(flip(WaterBlock),j),j))+flip(diag(diag(flip(Temp),j),j));
%     end
%     
%     Recovered(((1+rowsWaterBlockIndex(i)*block_size):((1+rowsWaterBlockIndex(i))*block_size)),((1+colsWaterBlockIndex(i)*block_size):((1+colsWaterBlockIndex(i))*block_size)))=Rec;
% end
% Recovered-Water
