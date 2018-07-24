%Arquivo de função: initializeMAdj.m
%Propósito:
%   Esta função cria um grafo com as relações de vizinhanca entre os
%   neurônios no espaco matricial. Para cada lattice, ela pode criar um
%   grafo diferente
%




function [ mAdj ] = initializeMAdj(rowMSpace, colMSpace, mSpace, latice)
    
    %inicializa a matriz de adjacências com zeros e de acordo com o lattice
    %e as condições implementadas preenchem com 1 a matriz. Ou seja, para
    %saber se o neurônio i é vizinho do neurônio j, basta olhar a posição
    %(i,j) da matriz
    mAdj = zeros(rowMSpace*colMSpace);
    
    %lattice em que os neurônios são vizinhos a todos que estão ao seu
    %redor, a um de distância no espaço matricial
    if(latice == 1)
        for i = 1:rowMSpace

            for j = 1:colMSpace
                if(i == 1)
                    if(j == 1)
                        mAdj(mSpace(i,j),mSpace(i,j+1)) = 1;
                        mAdj(mSpace(i,j),mSpace(i+1,j+1)) = 1;
                        mAdj(mSpace(i,j),mSpace(i+1,j)) = 1;

                    elseif(j == colMSpace)

                        mAdj(mSpace(i,j),mSpace(i,j-1)) = 1;
                        mAdj(mSpace(i,j),mSpace(i+1,j-1)) = 1;
                        mAdj(mSpace(i,j),mSpace(i+1,j)) = 1;

                    else
                        mAdj(mSpace(i,j),mSpace(i,j-1)) = 1;
                        mAdj(mSpace(i,j),mSpace(i+1,j-1)) = 1;
                        mAdj(mSpace(i,j),mSpace(i+1,j)) = 1;  
                        mAdj(mSpace(i,j),mSpace(i+1,j+1)) = 1;
                        mAdj(mSpace(i,j),mSpace(i,j+1)) = 1;  

                    end
                elseif(i == rowMSpace)
                    if(j == 1)
                        mAdj(mSpace(i,j),mSpace(i-1,j)) = 1;
                        mAdj(mSpace(i,j),mSpace(i-1,j+1)) = 1;
                        mAdj(mSpace(i,j),mSpace(i,j+1)) = 1;
                    elseif(j == colMSpace)
                         mAdj(mSpace(i,j),mSpace(i-1,j)) = 1;
                         mAdj(mSpace(i,j),mSpace(i-1,j-1)) = 1;
                         mAdj(mSpace(i,j),mSpace(i,j-1)) = 1;
                    else
                        mAdj(mSpace(i,j),mSpace(i,j-1)) = 1;
                        mAdj(mSpace(i,j),mSpace(i-1,j-1)) = 1;
                        mAdj(mSpace(i,j),mSpace(i-1,j)) = 1;  
                        mAdj(mSpace(i,j),mSpace(i-1,j+1)) = 1;  
                        mAdj(mSpace(i,j),mSpace(i,j+1)) = 1;
                    end

                elseif(j == 1)

                        mAdj(mSpace(i,j),mSpace(i-1,j)) = 1;
                        mAdj(mSpace(i,j),mSpace(i-1,j+1)) = 1;
                        mAdj(mSpace(i,j),mSpace(i,j+1)) = 1;
                        mAdj(mSpace(i,j),mSpace(i+1,j+1)) = 1;
                        mAdj(mSpace(i,j),mSpace(i+1,j)) = 1;
                elseif(j == colMSpace)
                        mAdj(mSpace(i,j),mSpace(i,j-1)) = 1;
                        mAdj(mSpace(i,j),mSpace(i+1,j-1)) = 1;
                        mAdj(mSpace(i,j),mSpace(i+1,j)) = 1;
                        mAdj(mSpace(i,j),mSpace(i-1,j-1)) = 1;
                        mAdj(mSpace(i,j),mSpace(i-1,j)) = 1;

                else

                        mAdj(mSpace(i,j),mSpace(i-1,j-1)) = 1;
                        mAdj(mSpace(i,j),mSpace(i-1,j)) = 1;
                        mAdj(mSpace(i,j),mSpace(i-1,j+1)) = 1;
                        mAdj(mSpace(i,j),mSpace(i,j+1)) = 1;
                        mAdj(mSpace(i,j),mSpace(i+1,j+1)) = 1;
                        mAdj(mSpace(i,j),mSpace(i+1,j)) = 1;
                        mAdj(mSpace(i,j),mSpace(i+1,j-1)) = 1;
                        mAdj(mSpace(i,j),mSpace(i,j-1)) = 1;
                end
            end
        end
    
    %latice retangular, em que todo neurônio é vizinho apenas aos que estão
    %na mesma linha e coluna, a um de distância no espaço matricial
    elseif(latice == 2)
        for i = 1:rowMSpace

            for j = 1:colMSpace
                if(i == 1)
                    if(j == 1)
                        mAdj(mSpace(i,j),mSpace(i,j+1)) = 1;
                        mAdj(mSpace(i,j),mSpace(i+1,j)) = 1;

                    elseif(j == colMSpace)
                        mAdj(mSpace(i,j),mSpace(i,j-1)) = 1;
                        mAdj(mSpace(i,j),mSpace(i+1,j)) = 1;

                    else
                        mAdj(mSpace(i,j),mSpace(i,j-1)) = 1;
                        mAdj(mSpace(i,j),mSpace(i+1,j)) = 1; 
                        mAdj(mSpace(i,j),mSpace(i,j+1)) = 1; 
                    end
                elseif(i == rowMSpace)
                    if(j == 1)

                        mAdj(mSpace(i,j),mSpace(i-1,j)) = 1;
                        mAdj(mSpace(i,j),mSpace(i,j+1)) = 1;

                    elseif(j == colMSpace)
                        mAdj(mSpace(i,j),mSpace(i-1,j)) = 1;
                        mAdj(mSpace(i,j),mSpace(i,j-1)) = 1;
            
                    else

                        mAdj(mSpace(i,j),mSpace(i,j-1)) = 1;
                        mAdj(mSpace(i,j),mSpace(i-1,j)) = 1; 
                        mAdj(mSpace(i,j),mSpace(i,j+1)) = 1;

                    end

                elseif(j == 1)
                    mAdj(mSpace(i,j),mSpace(i-1,j)) = 1;
                    mAdj(mSpace(i,j),mSpace(i,j+1)) = 1;
                    mAdj(mSpace(i,j),mSpace(i+1,j)) = 1;

                elseif(j == colMSpace)

                    mAdj(mSpace(i,j),mSpace(i,j-1)) = 1;
                    mAdj(mSpace(i,j),mSpace(i+1,j)) = 1; 
                    mAdj(mSpace(i,j),mSpace(i-1,j)) = 1;
                    
                else
                    mAdj(mSpace(i,j),mSpace(i-1,j)) = 1;
                    mAdj(mSpace(i,j),mSpace(i,j+1)) = 1;
                    mAdj(mSpace(i,j),mSpace(i+1,j)) = 1; 
                    mAdj(mSpace(i,j),mSpace(i,j-1)) = 1; 

                end
            end
        end
    %latice hexagonal    
    elseif(latice == 3)
    
    %latice invalido
    else
        %imprime que o valor da matriz eh -1, pois a representacao eh
        %invalida
        mAdj = -1
    end

end

