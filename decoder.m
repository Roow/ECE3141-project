function decodedVector = decoder(Symbolframe,M)

decodedVector = [];
for l = 1: length(Symbolframe)
    decodedVector = [decodedVector;int2bit(Symbolframe(l),log2(M))];
end
decodedVector = decodedVector';
if M == 8
    decodedVector = [decodedVector, 9];%append 9 to vector to show that the last bit is droppped 
end