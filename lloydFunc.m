function Q = lloydFunc(img, N)

fmax = max(img(:));
q = fmax/N;
    %we initialize x
    Q = zeros(size(img));
    x = 0:q:N*q;   %N+1         

    for i=1:11
        
        %yi
        for k = 1:size(x,2)-2
            % find values where im(i) between xi & xi+1
            I = find(img >= x(k) & img < x(k+1));
            y(k) = mean(img(I));
        end
        
        I = find(img >= x(N) & img <= x(N+1));
        y(N) = mean(img(I));
        
        
        for k = 2:size(x,2)-1
            x(k) = (y(k-1) + y(k)) /2;
        end
        
        
        for j = 1:size(x,2)-1
             % find values where im(i) between xi & xi+1
            I = find(img >= x(j) & img < x(j+1));
            Q(I) = y(j);
        end
      
        
    end
    

end