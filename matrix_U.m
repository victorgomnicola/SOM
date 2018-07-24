%Arquivo de função: matrix_U.m
%Propósito:
%  Esta função serve para construir a matriz U, que serve pra analisar os
%  resultados do treinamento. A matriz é construída de maneira a exibir
%  numericamente as proximidades dos neurônios com seus vizinhos mais
%  próximos. Esta proximidade é uma relação entre a distância deles no
%  espaço matricial e no espaço vetorial.




function [ uMatrix ] = matrix_U( mWeights, mSpace, rowMSpace, colMSpace)

uMatrix = zeros(2*rowMSpace-1, 2*colMSpace-1);

%matriz que guarda as posicoes de cada neuronio no espaco matricial
mPosition = initializeMPosition(rowMSpace, colMSpace, colMSpace*rowMSpace);


for i = 1:rowMSpace*colMSpace
    
    lin = mPosition(i,1);
    col = mPosition(i,2);
    
    if(lin == 1)
        if(col == 1)
            
            %dx
            uMatrix(lin, 2*col) = eucliDist(mWeights(:,mSpace(lin,col)),mWeights(:, mSpace(lin,col+1)));
            
            %dy
            uMatrix(2*lin, col) = eucliDist(mWeights(:,mSpace(lin,col)),mWeights(:,mSpace(lin+1,col)));
            
            %dxy
            uMatrix(2*lin, 2*col) = eucliDist(mWeights(:,mSpace(lin,col+1)), mWeights(:,mSpace(lin+1,col))) ;
            
            %du
            uMatrix(lin, col) = (uMatrix(lin, 2*col) + uMatrix(2*lin,2*col) + uMatrix(2*lin, col))/3;
            
        elseif (col == colMSpace)
            %dy
            uMatrix(2*lin, 2*col-1) = eucliDist(mWeights(:,mSpace(lin,col)),mWeights(:,mSpace(lin+1,col)));
            
            %du
            uMatrix(2*lin-1, 2*col-1) =  (uMatrix(2*lin-1, 2*col-2) + uMatrix(2*lin,2*col-2) + uMatrix(2*lin, 2*col-1))/3;
            
        else
            
            %dx
            uMatrix(2*lin-1, 2*col) = eucliDist(mWeights(:,mSpace(lin,col)),mWeights(:, mSpace(lin,col+1)));
            
            %dy
            uMatrix(2*lin, 2*col-1) = eucliDist(mWeights(:,mSpace(lin,col)),mWeights(:,mSpace(lin+1,col)));
            
            %dxy
            uMatrix(2*lin, 2*col) = eucliDist(mWeights(:,mSpace(lin,col)), mWeights(:,mSpace(lin+1,col+1)));
            
            %du
            uMatrix(2*lin-1, 2*col-1) = (uMatrix(2*lin-1, 2*col-2) + uMatrix(2*lin,2*col-2) + uMatrix(2*lin, 2*col-1)+ uMatrix(2*lin, 2*col)+ uMatrix(2*lin-1, 2*col))/5;
            
        end
        
    elseif (lin == rowMSpace)
        
        if (col == 1)
            
            %dx
            uMatrix(2*lin-1, 2*col) = eucliDist(mWeights(:,mSpace(lin,col)),mWeights(:, mSpace(lin,col+1)));
            
            %du
            uMatrix(2*lin-1, 2*col-1) = (uMatrix(2*lin-2, 2*col-1) + uMatrix(2*lin-2, 2*col) + uMatrix(2*lin-1, 2*col))/3;
        elseif(col ~= colMSpace)
            %dx
            uMatrix(2*lin-1, 2*col) = eucliDist(mWeights(:,mSpace(lin,col)),mWeights(:, mSpace(lin,col+1)));
            
            %du
            uMatrix(2*lin-1, 2*col-1) = (uMatrix(2*lin-1, 2*col-2) + uMatrix(2*lin-2, 2*col-2) + uMatrix(2*lin-2, 2*col-1) + uMatrix(2*lin-2, 2*col) + uMatrix(2*lin-1, 2*col))/5;
        else
            
            %du
            uMatrix(2*lin-1, 2*col-1) = (uMatrix(2*lin-1, 2*col-2) + uMatrix(2*lin-2, 2*col-2) + uMatrix(2*lin-2, 2*col-1))/3;
        end
        
    elseif(col == colMSpace)
        
        %dy
        uMatrix(2*lin, 2*col-1) = eucliDist(mWeights(:,mSpace(lin,col)),mWeights(:,mSpace(lin+1,col)));
        
        %du
        uMatrix(2*lin-1, 2*col-1) = (uMatrix(2*lin-2, 2*col-1) + uMatrix(2*lin-2, 2*col-2) + uMatrix(2*lin-1, 2*col-2) + uMatrix(2*lin, 2*col-2) + uMatrix(2*lin, 2*col-1))/5;
        
    else
        if(col == 1)
            %dx
            uMatrix(2*lin-1, 2*col) = eucliDist(mWeights(:,mSpace(lin,col)),mWeights(:, mSpace(lin,col+1)));
            
            %dy
            uMatrix(2*lin, 2*col-1) = eucliDist(mWeights(:,mSpace(lin,col)),mWeights(:,mSpace(lin+1,col)));
            
            %dxy
            uMatrix(2*lin, 2*col) = eucliDist(mWeights(:,mSpace(lin,col+1)), mWeights(:,mSpace(lin+1,col)));
            
            %du
            uMatrix(2*lin-1, 2*col-1) = (uMatrix(2*lin-2, 2*col-1) + uMatrix(2*lin-2,2*col) + uMatrix(2*lin-1, 2*col) + uMatrix(2*lin, 2*col) + uMatrix(2*lin, 2*col-1))/5;
            
            
        else
            %dx
            uMatrix(2*lin-1, 2*col) = eucliDist(mWeights(:,mSpace(lin,col)),mWeights(:, mSpace(lin,col+1)));
            
            %dy
            uMatrix(2*lin, 2*col-1) = eucliDist(mWeights(:,mSpace(lin,col)),mWeights(:,mSpace(lin+1,col)));
            
            %dxy
            uMatrix(2*lin, 2*col) = eucliDist(mWeights(:,mSpace(lin,col)), mWeights(:,mSpace(lin+1,col+1)));
            
            %du
            uMatrix(2*lin-1, 2*col-1) = (uMatrix(2*lin-2, 2*col-2) + uMatrix(2*lin-2,2*col-1) + uMatrix(2*lin-2, 2*col)+ uMatrix(2*lin-1, 2*col)+ uMatrix(2*lin, 2*col)+ uMatrix(2*lin, 2*col-1)+ uMatrix(2*lin, 2*col-2)+ uMatrix(2*lin-1, 2*col-2))/8;
        end
        
        
    end
end
end

