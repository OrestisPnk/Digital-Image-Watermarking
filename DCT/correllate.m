
% R1 = corrcoef(AttackedWater,Recovered)
% R2 = corrcoef(AttackedWater,Recovered)
% R1=corrcoef(CropExtract,Water)
R1=corrcoef(CropExtract,Recovered)
% R2=corrcoef(CropExtract,Recovered)

if R1>0.95
    D=1;
else
    D=0;
end