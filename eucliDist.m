%Arquivo de função: vetorOrdenado.m
%Propósito:
%   Funcao que calcula a distancia euclidiana entre dois vetores x e y
%Revisão de código
%       Data            Programador             Descrição da mudança
%       ====            ===========             ====================
%   26/04/2018          Victor Nicola             Código original
%                     e Rodrigo Hirama            


function [ dist ] = eucliDist(x, y)
    linX = size(x);
    dist = 0;
    for i = 1:linX(1)
        dist = dist + (x(i)-y(i))*(x(i)-y(i));
    end
    
    dist = sqrt(dist);
end

