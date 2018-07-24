%Arquivo de função: minDist.m
%Propósito:
%   Funcao que encontra o primeiro e segundo BMU (Best Matching Unit) para um determinado dado
%   utilizando a distância euclidiana. Ela retorna um vetor de quatro
%   posições em que a primeira e segunda posições guardam o índice do
%   primeiro BMU e a distância do dado a ela. A terceira e quarta posição
%   fazem o mesmo para o segundo BMU

function [ BMU ] = minDist(currentData, mWeights, neurons, currentData2)


%inicialmente, o primeiro BMU é o primeiro neurônio
BMU(1) = 1;
BMU(2) = optEucliDist(mWeights(:,1), currentData, currentData2);

%Esses condicionais comparam o primeiro BMU com o segundo neurônio e, caso
%a distância do segundo seja menor que a do primeiro, o segundo neurônio passa 
%a ser o primeiro BMU e o primeiro neurônio passa a ser o segundo BMU 
if(optEucliDist(mWeights(:,1), currentData, currentData2) <= optEucliDist(mWeights(:,2), currentData, currentData2))
    
    BMU(1) = 1;
    BMU(2) = optEucliDist(mWeights(:,1), currentData, currentData2);
    BMU(3) = 2;
    BMU(4) = optEucliDist(mWeights(:,2), currentData, currentData2);
    
else
    
    BMU(1) = 2;
    BMU(2) = optEucliDist(mWeights(:,2), currentData, currentData2);
    BMU(3) = 1;
    BMU(4) = optEucliDist(mWeights(:,1), currentData, currentData2);
end


%Laco que percorre todos os neuronios calculando a distancia euclidiana
%entre cada neuronio e o dado analisado e atualizando os valores das
%posições e distâncias do primeiro e segundo BMU. O laço começa a partir do
%terceiro neurônio, pois os neurônios 1 e 2 já foram comparados
for i = 3:neurons
    
    %aux guarda a distância do dado atualmente analisado ao neurônio atual
    aux = optEucliDist(mWeights(:,i), currentData, currentData2);
    
    %condicionais que comparam os BMUs encontrados até então para atualizar
    %o primeiro e segundo BMU quando necessário
    if(aux < BMU(4))
        if(aux < BMU(2))
            
            BMU(3) = BMU(1);
            BMU(4) = BMU(2);
            
            BMU(1) = i;
            BMU(2) = aux;
            
        else
            
            BMU(3) = i;
            BMU(4) = aux;
            
        end
    end
end
end

