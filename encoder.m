function encodedVector = encoder(frame,M)

encodedVector = [];
switch M
    case 2
        
        for i = 1 : log2(M) : 1024
            word = frame(i);
            encodedVector = [encodedVector,sum(word)+1];
        end

    case 4
        
        for i = 1 : 2 : 1024
            
            word = [];
            word = [word,frame(i)];
            word = [word,frame(i+1)];
            word_dec = bit2int(word',2);
            encodedVector = [encodedVector,word_dec+1];
        end
        

    case 8

        for i = 1 : 3 : 1023%1023/3 = 341 (drop last bit lol)
            word = [];
            word = [word,frame(i)];
            word = [word,frame(i+1)];
            word = [word,frame(i+2)];
            word_dec = bit2int(word',3);
            encodedVector = [encodedVector,word_dec+1];
        end
        
end