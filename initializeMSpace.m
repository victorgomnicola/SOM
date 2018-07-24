%Arquivo de fun��o: vetorOrdenado.m
%Prop�sito:
%   Dado um vetor de tamanho n que cont�m uma s�rie, este algoritmo
%   discretiza o vetor para um vetor de tamanhoNovo, passado como 
%   par�metro da fun��o
%
%Revis�o de c�digo
%       Data            Programador             Descri��o da mudan�a
%       ====            ===========             ====================
%   26/04/2018          Victor Nicola             C�digo original
%                     e Rodrigo Hirama            

function [ mSpace ] = initializeMSpace( rowMSpace, colMSpace )

    mSpace = zeros(rowMSpace, colMSpace);
    
    %cria uma matrix com os indices dos neuronios em cada posicao da matriz
    in = 1;
    for(i = 1:rowMSpace)
        fi = in + colMSpace - 1;
        mSpace(i,:) = in:fi;
        in = fi + 1;
    end
end

