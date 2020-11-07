Cropped=Nuulll;
for k = 220 : size(Nuulll,1)
    for l = 1 : size(Nuulll,2)
        Cropped(k,l)=0;
    end
end
for k = 220 : size(Nuulll,1)
    for l = 1 : size(Nuulll,2)
        Cropped(l,k)=0;
    end
end
figure
imshow(Cropped);
for i = 1 : blockCounter
    ImageBlock=Cropped((((1+(rowsImageBlockIndex(i)*block_size))):((1+rowsImageBlockIndex(i))*block_size)),((1+(colsImageBlockIndex(i)*block_size)):(1+colsImageBlockIndex(i))*block_size));

    coef2=dct2(ImageBlock);    

    Rec=   coef2>0;
    CropExtract(((1+rowsWaterBlockIndex(i)*block_size):((1+rowsWaterBlockIndex(i))*block_size)),((1+colsWaterBlockIndex(i)*block_size):((1+colsWaterBlockIndex(i))*block_size)))=Rec;
end
Result=CropExtract-Water
figure
imshow(Recovered);
figure
imshow(Result);
