%Arquivo de função: BFS.m
%Propósito:
%   Função que percorre a matriz de adjacências, que guarda as relações de
%   vizinhança, com uma busca em largura que inicia no BMU e termina quando
%   atinge limite pré-definido com o raio de vizinhança. 
%  
%   A função retorna um vetor com os índices dos neurônios que terão
%   seus pesos alterados, ou seja, o BMU e os vizinhos dentro do raio de
%   vizinhança
%


function [ neighborhoodVector ] = BFS(mAdj, bmu, neighborhoodRadius, neurons)
color = zeros(1,neurons);
d = zeros(1, neurons);
color(bmu) = 1;
d(bmu) = 0;
neighborhoodVector(1) = bmu;

next = 1;   %proximo a sair da fila
nextSpace = 2; %proximo espaco vazio
while(next <= length(neighborhoodVector) && d(neighborhoodVector(next)) < neighborhoodRadius)
    
    u = neighborhoodVector(next);
    next = next+1;
    
    for i = 1:neurons
        if(mAdj(u, i) == 1)
            if(color(i) == 0)
                color(i) = 1;
                d(i) = d(u) + 1;
                neighborhoodVector(nextSpace) = i;
                 nextSpace = nextSpace + 1;
            end
        end
    end
    color(u) = 2;
end
end

