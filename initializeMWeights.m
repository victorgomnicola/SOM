%Arquivo de função: initializeMWeights.m
%Propósito:
%   Inicializa o vetor com os pesos dos neuronios que serao treinados.
%   Os pesos representam as coordenadas de cada neuronio no espaco vetorial
%   em que os dados se encontram. Depende do tipo de inicializacao e da
%   representacao dos dados. No entanto, apenas a inicialização aleatória
%   foi implementada
%

function [ mWeights ] = initializeMWeights( mData, representation, rowMSpace, colMSpace, initialization, words )
    %inicializacao aleatoria
    if(initialization == 0)
        
        %Se for representacao Binaria
        if(representation == 0)
            
            %cria uma matriz de palavras X neuronios com valores
            %binarios aleatorios 
            mWeights = round(rand(words, rowMSpace*colMSpace));
            
        %Se for representacao TF
        elseif(representation == 1)
            
            %cria uma matriz de palavras X neuronios com valores
            %inteiros aleatorios - o maximo valor possivel eh o maximo
            %valor de mData
            m = max(max(mData));
           mWeights = round(rand(words, rowMSpace*colMSpace)*m);
            
        %Se for representacao TFIDF
        elseif(representation == 2)
            
            %cria uma matriz de palavras X neuronios com valores
            %aleatorios entre 0 e 1
            mWeights = rand(words, rowMSpace*colMSpace);
        
            %teste com iris
        elseif(representation == 3)
             m = max(max(mData))
             mWeights = rand(words, rowMSpace*colMSpace)*m;
             
        %representacao invalida
        else
            %imprime que o valor da matriz eh -1, pois a representacao eh
            %invalida
            initializeMWeights = -1
        end
        
    %inicializacao linear   
    elseif(initialization == 1)
    
    %inicializacao com conhecimentos a priori
    elseif(initialization == 2)
    
    %inicializacao invalida     
    else

    end

end

