function err_codeword = get_err_code(codeword, x, N)
  % This function returns words that have error in x-bits wrt actual
  % codeword, which is passed as an argument
  % The last argument gives the number of error induced codewords returned.
  
  % disp(class(N));
  err_codeword = zeros(uint8(N), length(codeword));
  
  
  % fprintf('Original Codeword: ');
  % disp(codeword);
  % randn returns normally distributed numbers. SO, we get a uniform sampling
  % of error induced codewords.
  
  for i=1:N
    j = 1;
    pos = zeros(length(codeword));
    temp_codeword = codeword;
    while j <= x
      k = randi([1, length(codeword)]);
      
      % if that position has already been used
      while pos(k) == 1
        k = randi([1, length(codeword)]);
      end
      
      pos(k) = 1;
      % making note of the flipped position in codeword
      % flippin the bit in original codeword
      
      temp_codeword(k) = ~codeword(k);     
      j = j + 1; 
      
    end
    
    % copying values from temp_codeword to err_codeword
    for j=1:length(codeword)
      err_codeword(i, j) = temp_codeword(j);
    end
  end
  
  % disp('Matrix of error induced codewords is:'); 
  % fprintf('Number of errors introduced is : %d\n', x);
  % disp(err_codeword);
  
  
end
     
      
      