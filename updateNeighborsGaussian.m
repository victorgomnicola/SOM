%Arquivo de função: updateNeighborsGaussian.m
%Propósito:
%   Funcao que atualiza os vizinhos do bmu de acordo com o raio de
%   vizinhanca. Como as relações de vizinhança são armezanadas em uma
%   matriz de adjacências, esta função chama outra função que percorre a
%   matriz com uma busca em largura, que termina quando o raio atinge o
%   limite do raio de vizinhança.
%
%   Com o vetor de vizinhos, é possível atualizar adequadamente os pesos
%   A "força" da atualização varia de acordo com o raio de vizinhança, o
%   que significa que neurônios mais distantes do BMU no espaço matricial
%   serão menos afetados. Essa alteração baseia-se na função gaussiana




function [ newMWeights ] = updateNeighborsGaussian(currentData, mAdj, mWeights, bmu, neighborhoodRadius, alfa, words, neurons, mPosition)
neighborhoodVector = BFS(mAdj, bmu, round(neighborhoodRadius), neurons);

for n = neighborhoodVector
    aux = -1*sqrt((mPosition(n, 1) - mPosition(bmu,1))^2 + (mPosition(n, 2) - mPosition(bmu,2))^2);
    neighborhoodFunction = alfa*exp(aux/(2*neighborhoodRadius^2));
    
    for w = 1:words
        mWeights(w,n) = mWeights(w,n) + alfa*neighborhoodFunction*(currentData(w)-mWeights(w,n));
    end
end

newMWeights = mWeights;
end

