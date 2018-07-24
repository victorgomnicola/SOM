%Arquivo de função: initializeMPosition.m
%Propósito:
%   Esta função cria uma matriz que coloca o número de cada neurônio na
%   posição adequada da matriz, de acordo com o número de linhas e colunas
%   definidas como parâmetro de treinamento.
%

function [ mPosition ] = initializeMPosition( rowMSpace,colMSpace,neurons)

mPosition = zeros(neurons, 2);
lin = 1;
col = 1;

for i = 1:rowMSpace
    for j = 1:colMSpace
        mPosition(lin, col) = i;
        col = 2;
        
        mPosition(lin, col)= j;
        lin = lin + 1;
        col = 1;
    end
    
    
end

