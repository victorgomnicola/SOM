%Arquivo de fun��o: initializeMAdj.m
%Prop�sito:
%   Esta fun��o cria um grafo com as rela��es de vizinhanca entre os
%   neur�nios no espaco matricial. Para cada lattice, ela pode criar um
%   grafo diferente
%




function [ mAdj ] = initializeMAdj(rowMSpace, colMSpace, mSpace, latice)
    
    %inicializa a matriz de adjac�ncias com zeros e de acordo com o lattice
    %e as condi��es implementadas preenchem com 1 a matriz. Ou seja, para
    %saber se o neur�nio i � vizinho do neur�nio j, basta olhar a posi��o
    %(i,j) da matriz
    mAdj = zeros(rowMSpace*colMSpace);
    
    %lattice em que os neur�nios s�o vizinhos a todos que est�o ao seu
    %redor, a um de dist�ncia no espa�o matricial
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
    
    %latice retangular, em que todo neur�nio � vizinho apenas aos que est�o
    %na mesma linha e coluna, a um de dist�ncia no espa�o matricial
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

