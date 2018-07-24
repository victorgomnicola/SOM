%Arquivo de função: vetorOrdenado.m
%Propósito:
%   Dado um vetor de tamanho n que contém uma série, este algoritmo
%   discretiza o vetor para um vetor de tamanhoNovo, passado como 
%   parâmetro da função
%
%Revisão de código
%       Data            Programador             Descrição da mudança
%       ====            ===========             ====================
%   26/04/2018          Victor Nicola             Código original
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

