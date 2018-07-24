%Arquivo de fun��o: vetorOrdenado.m
%Prop�sito:
%   Funcao que calcula a distancia euclidiana entre dois vetores x e y
%Revis�o de c�digo
%       Data            Programador             Descri��o da mudan�a
%       ====            ===========             ====================
%   26/04/2018          Victor Nicola             C�digo original
%                     e Rodrigo Hirama            


function [ dist ] = eucliDist(x, y)
    linX = size(x);
    dist = 0;
    for i = 1:linX(1)
        dist = dist + (x(i)-y(i))*(x(i)-y(i));
    end
    
    dist = sqrt(dist);
end

