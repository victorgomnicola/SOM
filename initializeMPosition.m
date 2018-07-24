%Arquivo de fun��o: initializeMPosition.m
%Prop�sito:
%   Esta fun��o cria uma matriz que coloca o n�mero de cada neur�nio na
%   posi��o adequada da matriz, de acordo com o n�mero de linhas e colunas
%   definidas como par�metro de treinamento.
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

