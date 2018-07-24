%Arquivo de fun��o: updateNeighbors.m
%Prop�sito:
%   Funcao que atualiza os vizinhos do bmu de acordo com o raio de
%   vizinhanca. Como as rela��es de vizinhan�a s�o armezanadas em uma
%   matriz de adjac�ncias, esta fun��o chama outra fun��o que percorre a
%   matriz com uma busca em largura, que termina quando o raio atinge o
%   limite do raio de vizinhan�a.
%
%   Com o vetor de vizinhos, � poss�vel atualizar adequadamente os pesos
%   A "for�a" da atualiza��o � igual para todos os neur�nios que s�o
%   atualizados, independente do raio, pois se baseia na fun��o bubble



function [ newMWeights ] = updateNeighbors( currentData, mAdj, mWeights, bmu, neighborhoodRadius, alfa, words, neurons)

%recebe um vetor de vizinhos, encontrados com uma busca em largura
neighborhoodVector = BFS(mAdj, bmu, round(neighborhoodRadius), neurons);

%la�o que percorre acessa e atualiza apenas o BMU e seus vizinhos 
for n = neighborhoodVector
    for w = 1:words
        mWeights(w,n) = mWeights(w,n) + alfa*(currentData(w)-mWeights(w,n));
    end
end

%retorna uma nova matriz de pesos
newMWeights = mWeights;
end
