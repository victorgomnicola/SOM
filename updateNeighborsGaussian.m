%Arquivo de fun��o: updateNeighborsGaussian.m
%Prop�sito:
%   Funcao que atualiza os vizinhos do bmu de acordo com o raio de
%   vizinhanca. Como as rela��es de vizinhan�a s�o armezanadas em uma
%   matriz de adjac�ncias, esta fun��o chama outra fun��o que percorre a
%   matriz com uma busca em largura, que termina quando o raio atinge o
%   limite do raio de vizinhan�a.
%
%   Com o vetor de vizinhos, � poss�vel atualizar adequadamente os pesos
%   A "for�a" da atualiza��o varia de acordo com o raio de vizinhan�a, o
%   que significa que neur�nios mais distantes do BMU no espa�o matricial
%   ser�o menos afetados. Essa altera��o baseia-se na fun��o gaussiana




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

