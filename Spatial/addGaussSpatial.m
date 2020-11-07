GaussImage = imnoise(Nuulll,'gaussian',0.01);
figure
imshow(GaussImage);
AttackedWater=zeros(size(I,1));
for i = 1 : blockCounter
    GaussImageBlock=GaussImage((((1+(rowsImageBlockIndex(i)*block_size))):((1+rowsImageBlockIndex(i))*block_size)),((1+(colsImageBlockIndex(i)*block_size)):(1+colsImageBlockIndex(i))*block_size));
    New=zeros(block_size);
    for k=1 : block_size
        for l=1 : block_size
            x=dec2bin(GaussImageBlock(k,l));
            New(k,l)=str2double(x(end));
        end
    end
    AttackedWater(((1+rowsWaterBlockIndex(i)*block_size):((1+rowsWaterBlockIndex(i))*block_size)),((1+colsWaterBlockIndex(i)*block_size):((1+colsWaterBlockIndex(i))*block_size)))=New;
end
Result1=AttackedWater-WaterExt
Result2=AttackedWater-Water
figure
imshow(AttackedWater);
figure
imshow(Result1);
