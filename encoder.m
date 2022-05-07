function encodedVector = encoder(frame,M)

%TODO: fix M=4 & M=8 cases
encodedVector = [];
switch M
    case 2
        
        for i = 1 : log2(M) : 1024
            word = frame(i);
            encodedVector = [encodedVector,sum(word)];
        end

    case 4
        
        for i = 1 : log2(M) : 1024-log2(M)
            word = 0;
            for j = i:1:i+log2(M)+1
                word = word + frame(j);
            end
            encodedVector = [encodedVector,sum(word)+1];
        end
        

    case 8

        for i = 1 : log2(M) : 1023-log2(M)
            word = 0;
            for j = i:1:i+log2(M)
                word = word + frame(j);
            end
            encodedVector = [encodedVector,sum(word)+1];
        end
        
end