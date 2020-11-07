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
WaterExt=zeros(size(I,1));
for i = 1 : blockCounter
    ImageBlock=Cropped((((1+(rowsImageBlockIndex(i)*block_size))):((1+rowsImageBlockIndex(i))*block_size)),((1+(colsImageBlockIndex(i)*block_size)):(1+colsImageBlockIndex(i))*block_size));
    New=zeros(block_size);
    for k=1 : block_size
        for l=1 : block_size
            x=dec2bin(ImageBlock(k,l));
            New(k,l)=str2double(x(end));
        end
    end
    WaterExt(((1+rowsWaterBlockIndex(i)*block_size):((1+rowsWaterBlockIndex(i))*block_size)),((1+colsWaterBlockIndex(i)*block_size):((1+colsWaterBlockIndex(i))*block_size)))=New;
end
Result=WaterExt-Water
figure
imshow(WaterExt);
figure
imshow(Result);

