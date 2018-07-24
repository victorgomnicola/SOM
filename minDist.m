%Arquivo de fun��o: minDist.m
%Prop�sito:
%   Funcao que encontra o primeiro e segundo BMU (Best Matching Unit) para um determinado dado
%   utilizando a dist�ncia euclidiana. Ela retorna um vetor de quatro
%   posi��es em que a primeira e segunda posi��es guardam o �ndice do
%   primeiro BMU e a dist�ncia do dado a ela. A terceira e quarta posi��o
%   fazem o mesmo para o segundo BMU

function [ BMU ] = minDist(currentData, mWeights, neurons, currentData2)


%inicialmente, o primeiro BMU � o primeiro neur�nio
BMU(1) = 1;
BMU(2) = optEucliDist(mWeights(:,1), currentData, currentData2);

%Esses condicionais comparam o primeiro BMU com o segundo neur�nio e, caso
%a dist�ncia do segundo seja menor que a do primeiro, o segundo neur�nio passa 
%a ser o primeiro BMU e o primeiro neur�nio passa a ser o segundo BMU 
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
%posi��es e dist�ncias do primeiro e segundo BMU. O la�o come�a a partir do
%terceiro neur�nio, pois os neur�nios 1 e 2 j� foram comparados
for i = 3:neurons
    
    %aux guarda a dist�ncia do dado atualmente analisado ao neur�nio atual
    aux = optEucliDist(mWeights(:,i), currentData, currentData2);
    
    %condicionais que comparam os BMUs encontrados at� ent�o para atualizar
    %o primeiro e segundo BMU quando necess�rio
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

