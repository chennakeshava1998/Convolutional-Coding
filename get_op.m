function outputs = get_op(gen1, gen2)

    
    % output(i, 1) has the output of gen1(MSB) and gen2 when 0 is pushed at LHS
    % output(i, 2) has the output of gen1(MSB) and gen2 when 1 is pushed at LHS
    
    m = 9;
    outputs =zeros(2^m, 2);
    
    for i=1:2^m
        % matlab, by default, produces binary vectors where msb is at
        % right, this flag allows us to specify otherwise
        tmp = de2bi(i-1, m, 'left-msb');
        
        tmp1 = [0, tmp];
        tmp2 = [1, tmp];
        
        % (.*) syntax specifies element-wise operations
        % calculations for pushing 0-bit at LHS
        ans1 = sum(tmp1.*gen1);ans1 = mod(ans1, 2);
        ans2 = sum(tmp1.*gen2);ans2 = mod(ans2, 2);
        
        outputs(i, 1) = ans1*2 + ans2*1;
        
        % calculation for pushing 1-bit at LHS:
        ans1 = sum(tmp2.*gen1);ans1 = mod(ans1, 2);
        ans2 = sum(tmp2.*gen2);ans2 = mod(ans2, 2);
        
        outputs(i, 2) = ans1*2 + ans2*1;
    end
    
    disp(outputs);
end
        
    