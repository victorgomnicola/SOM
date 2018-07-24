%Arquivo de função: updateNeighbors.m
%Propósito:
%   Funcao que atualiza os vizinhos do bmu de acordo com o raio de
%   vizinhanca. Como as relações de vizinhança são armezanadas em uma
%   matriz de adjacências, esta função chama outra função que percorre a
%   matriz com uma busca em largura, que termina quando o raio atinge o
%   limite do raio de vizinhança.
%
%   Com o vetor de vizinhos, é possível atualizar adequadamente os pesos
%   A "força" da atualização é igual para todos os neurônios que são
%   atualizados, independente do raio, pois se baseia na função bubble



function [ newMWeights ] = updateNeighbors( currentData, mAdj, mWeights, bmu, neighborhoodRadius, alfa, words, neurons)

%recebe um vetor de vizinhos, encontrados com uma busca em largura
neighborhoodVector = BFS(mAdj, bmu, round(neighborhoodRadius), neurons);

%laço que percorre acessa e atualiza apenas o BMU e seus vizinhos 
for n = neighborhoodVector
    for w = 1:words
        mWeights(w,n) = mWeights(w,n) + alfa*(currentData(w)-mWeights(w,n));
    end
end

%retorna uma nova matriz de pesos
newMWeights = mWeights;
end
