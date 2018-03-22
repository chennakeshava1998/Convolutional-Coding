function main

    % considering the best generators for constraint length of 10 and rate = 1/2. 
    gen1 = [0 1 1 0 1 1 1 0 0 1];
    gen2 = [1 1 1 0 0 1 1 0 0 1];
    
    % generating similar generator polynomials with differences in 3 bits
    mat_generators1 = get_err_code(gen1, 3, 4);
    mat_generators2 = get_err_code(gen2, 3, 4);
    
    mat_gen = zeros(10, 10);
    
    % storing all of the generator polynomials in a single matrix
    
    for i=1:4
        mat_gen(i, 10) = mat_generators1(i, 10);
        mat_gen(i+5, 10) = mat_generators2(i, 10);
    end
    
    mat_gen(5, :) = gen1;
    mat_gen(10, :) = gen2;
    
    

    % using the cnt(10, 10) matrix to store the errors incurred by all pairs of generators.
    cnt = zeros(10, 10);
    
    for i=1:10
        for j=1:10
            
            gen1 = mat_gen(i, 10);
            gen2 = mat_gen(j, 10);

            ns = nextState();
            outputs = get_op(gen1, gen2);

            % constructing the trellis structure
            m = 9;

            trellis=struct('numInputSymbols',2^1,'numOutputSymbols',2^2, 'numStates',2^m,'nextStates',ns,'outputs',outputs);
            % istrellis checks if the given trellis is valid or not
            [isok,status]=istrellis(trellis);
            disp(status);

            % random number generator seed is used so that all the pairs of
            % generators are evaluated on the same set of datawords.
            % Otherwise, different pseudo random numbers are generated every time 
            rng(0);
            for k=1:1000

                dataword = randn(1, 6);
                dataword = sign(dataword);

                % the output of randn gives normally distributed numbers(according to
                % gaussian distribution between -1 to 1

                % sign is the function, which reduces all numbers to 1, 0 or -1
                % In this loop, we are getting rid of -1's by replacing them with 0

                for p=1:length(dataword)
                    if dataword(p) < 0
                        dataword(p) = 0;
                    end
                end


                % encode the dataword
                codeword = encoder(gen1, gen2, dataword);
                % using add white gaussian noise to the data
                y = awgn(codeword, 1);
                decoded_ans = vitdec(y, trellis, 2, 'term', 'unquant');


                fprintf('i = %d\tj = %d\tk = %d\n ', i, j, k);disp(decoded_ans);

                if length(decoded_ans) > length(dataword)
                    decoded_ans = decoded_ans(1, length(decoded_ans) - length(dataword) + 1:length(decoded_ans));
                end

                biterror = biterr(decoded_ans,dataword);
                fprintf('dataword = ');disp(dataword);
                fprintf('decoded answer = ');disp(decoded_ans);
                display(biterror);

                cnt(i, j) = cnt(i, j) + biterror;
                end
        end
                
    end
    
    disp(cnt);
    
    % finding the minimum in the cnt matrix
    mini = 100000000;
    pos_i = -1;
    pos_j = -1;
    
    % surf function generates a 3D plot for the matrix
    surf(cnt);
    
    for i=1:10
        for j=1:10
            if cnt(i, j) < mini
                pos_i = i;
                pos_j = j;
                mini = cnt(i, j);
                break;
            end
        end
    end
    
    
    fprintf('The pair of generators at %d and %d have the best count value of %d\n', pos_i, pos_j, cnt(pos_i, pos_j));
    disp(mat_gen(pos_i, :));
    disp(mat_gen(pos_j, :));
    
end
    
    