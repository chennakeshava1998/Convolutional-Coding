function ns = nextState()
    % this function needs to be called only once. It constructs the
    % nextState matrci, necessary fot the trellis structure
    
    
    % constructing the next states
    % nextState(i, 1) ==> Contains the next state of state i, when 0 bit is
    % pushed from left to right
    % nextState(i, 2) ==> Contains the next state of state i, when 1 bit is
    % pushed from left to right
    m = 9;
    nextState = zeros(2^m, 2);
    
    for i=1:2^m
        tmp = de2bi(i - 1, m);
        % flip the vector, because matlab produces vectors in the opposite
        % of conventional fashion
        tmp = fliplr(tmp);
        
        % these statements append 0 and 1, at the beginning of the vectors
        tmp1 = [0, tmp]; % for finding nextState(i, 1)
        tmp2 = [1, tmp]; % for nextState(i, 2)
        
        % chopping off the last bit
        tmp1 = tmp1(1, length(tmp1) - 1);
        tmp2 = tmp2(1, length(tmp2) - 1);
        
        nextState(i, 1) = bi2de(tmp1);
        nextState(i, 2) = bi2de(tmp2);
    end
    
    disp(nextState);
    ns = nextState;
    disp('length = ');
    disp(length(nextState));
   
end
        
        
    