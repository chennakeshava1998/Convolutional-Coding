function codeword = encoder(gen1, gen2, dataword)
  
  %disp(dataword);
  len_dataword = length(dataword);
  generator_matrix = zeros(len_dataword, length(gen1) + 2*(len_dataword - 1));
  
  j = 1; % number of positions to leave, before proceeding to fill gen_values
  i = 1; %  row index in generator_matrix
  p = 1; % index of generator array
  while i <= length(dataword)
    k = j;
    p = 1;
    % filling in gen1 and gen2 values in generator matrix
    while p <= length(gen1)
      generator_matrix(i, k) = gen1(p);
      generator_matrix(i, k + 1) = gen2(p);
      k = k + 2;
      p = p + 1;
     end
     
    j = j + 2;
    i = i + 1;
   end
   
   %disp(generator_matrix) - for debugging purposes only!
   
   codeword = dataword * generator_matrix;
   % default matrix multiplication will not work, because instead of addition
   % we will have to xor the values
   
   i = 1;
   while i <= length(codeword) 
    codeword(i) = mod(codeword(i), 2);
    i = i + 1;
   end
   
   % disp(length(codeword)); - for debugging only!
   
end
  
  
  
  
  
  