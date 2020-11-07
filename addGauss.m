
GaussImage = imnoise(Nuulll,'gaussian',0.01);
figure
imshow(GaussImage);
AttackedWater=zeros(size(I,1));
for i = 1 : blockCounter
    GaussImageBlock=GaussImage((((1+(rowsImageBlockIndex(i)*block_size))):((1+rowsImageBlockIndex(i))*block_size)),((1+(colsImageBlockIndex(i)*block_size)):(1+colsImageBlockIndex(i))*block_size));
    WaterBlock=Water((((1+(rowsWaterBlockIndex(i)*block_size))):((1+rowsWaterBlockIndex(i))*block_size)),((1+(colsWaterBlockIndex(i)*block_size)):(1+colsWaterBlockIndex(i))*block_size));

    coeff=dct2(GaussImageBlock);    
    Bin=coeff>0;
    for j=-midFreq:midFreq
        Rec=WaterBlock-flip(diag(diag(flip(WaterBlock),j),j))+flip(diag(diag(flip(Bin),j),j));
    end
    AttackedWater(((1+rowsWaterBlockIndex(i)*block_size):((1+rowsWaterBlockIndex(i))*block_size)),((1+colsWaterBlockIndex(i)*block_size):((1+colsWaterBlockIndex(i))*block_size)))=Rec;
end
Result=AttackedWater-Recovered
figure
imshow(AttackedWater);
figure
imshow(Result);

