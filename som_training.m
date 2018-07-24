%Arquivo de função: som_training.m
%Propósito:
%   Esta função serve para treinar uma rede neural do tipo SOM (Self
%   Organizing Maps). 
%   Ela recebe como parâmetros, respectivamente: 
%       - Matriz de dados que servirão para realizar o treinamento
%       - Número de linhas do espaço matricial
%       - Número de colunas do espaço matricial
%       - Estrutura de lattice que determina as relações de vizinhança
%       - Inicialização (apenas a aleatória foi implementada)
%       - Número de épocas que determina o número de iterações do
%       treinamento
%       - Raio inicial de vizinhança
%       - Taxa de aprendizagem inicial
%       - Função de atualização da taxa de aprendizagem (linear, inverso do
%       tempo ou série de potências ou fixa)
%       - Função de atualização do raio de vizinhança (fixa ou decrescente)
%       - Função de atualização dos pesos dentro do raio de vizinhança
%       (Bubble ou Gaussiana)
%  

function [som] = som_training( mData, representation, rowMSpace, colMSpace, latice, initialization, epochs, neighborhoodRadius, learningRate, learningFunction, neighborhoodFunction, neighborhoodRadiusFunction)

%mData é a estrutura que armazena os dados de entrada
%Trata-se de uma matriz em que as linhas são os termos e as colunas são os
%textos
[words, texts] = size(mData);

%o número de neurônios depende do número de linhas e colunas do espaço
%matricial. De maneira geral, os testes foram feitos com matrizes
%quadradas, mas a função permite escolher linhas e colunas de maneira
%independente
neurons = rowMSpace*colMSpace;


%A matriz de pesos (mWeights) é uma matriz que guarda as coordenadas de
%cada um dos neurônios no espaço vetorial. Ela possui o mesmo número de
%linhas que a matriz de entrada e o número de colunas é a quantidade total
%de neurônios

%inicializacao das posicioes dos neuronios no espaco vetorial
%apenas a inicialização aleatória foi implementada
mWeights = initializeMWeights(mData, representation, rowMSpace, colMSpace, initialization, words);


%mSpace guarda as posições dos neurônios no espaço matricial é uma matriz
%com o número de linhas e colunas pré-determinados nos parâmetros de
%treinamento. Cada elemento guarda o número do neurônio

%inicializacao das posicioes dos neuronios no espaco matricial
mSpace = initializeMSpace(rowMSpace, colMSpace);

%para guardar as relações de vizinhanças entre os neurônios, foi criado um
%grafo que está representado por uma matriz de adjacências. Essa relação
%depende do lattice, que pode ser passado por parâmetro

%inicializacao do grafo de vizinhanca
%esta função permite construir a matriz de adjacências para o lattice
%retangular e um latticce completo, que considera que um neurônio é vizinho
%de todos ao redor dele no espaço matricial
mAdj = initializeMAdj(rowMSpace, colMSpace, mSpace, latice);


%mPosition é uma matriz auxiliar que guarda as posições de cada neurônio no
%espaço matricial. Ela é utilizada, principalmente, para construir a matriz
%U, após o treinamento.

%A matriz possui o número de neurônios como quantidade de linhas e apenas 2
%colunas. A coluna 1 indica qual a linha do neurônio no espaço matricial e
%a coluna 2 indica a posição da coluna do neurônio no espaço matricial
mPosition = initializeMPosition(rowMSpace,colMSpace,neurons);

%A fim de otimizar o cálculo da distância euclidiana, calcula-se os
%quadrados da matriz de dados apenas uma vez

%mData2 é a matriz que armazena os quadrados dos elementos do conjunto de dados
mData2 = mData.*mData;

mSpaceBMU = zeros(rowMSpace, colMSpace);

%este é o laço em que ocorre o treinamento e ele roda um número
%pré-determinado de épocas, passado como parâmetro da função

%laco das epocas
for t = 1:epochs
    
    %Na implementação desta há a opção de 3 formas de atualizar a taxa de
    %aprendizagem: linear, inverso do tempo e séries de potência. As
    %fórmulas foram obtidas em bibliografia complementar e implementadas
    
    
    %alteracao da taxa de aprendizado
    %funcao linear
    if(learningFunction == 0)
        alfa = learningRate/t;
        
        %inverso do tempo
    elseif(learningFunction == 1)
        alfa = learningRate*(1 - t/epochs);
        
        %power serie
    elseif(learningFunction == 2)
        
        alfa = learningRate*(exp(t/epochs));
        
    end
    
    %Para testes com muitas épocas, como a taxa de aprendizagem diminui
    %constantemente, adotou-se como possível critério de parada, alfa ser
    %igual a zero, pois seria possível que o número se torna-se tão
    %pequeno, a ponto de ser arredondado para zero
    if(alfa == 0)
        break;
    end
    
    %o parâmetro neighborhoodRadiusFunction define se o raio de vizinha
    %diminuirá com o passar das execuções ou será fixo
    if(neighborhoodRadiusFunction == 1)
        neighborhoodRadius = neighborhoodRadius*exp(-1*t/epochs);
    end
    
    %para cada época, as medidas de erro de quantização e de distorção
    %topológicas são recalculados para serem armazenados em um vetor e seu
    %comportamento no decorrer das épocas possa ser analisado
    quantizationError = 0;
    topologicalError = 0;
    

    
%     timeStamp1 = datetime('now'); %linha adicionada para avaliar o
%     desempenho do processamento em uma época
    
    %laco que percorre o conjunto de dados, encontra o primeiro e segundo BMUs e atualiza
    %as distancias distancia dos neuronios vizinhos ao primeiro,de acordo com
    %o raio de vizinhanca e a taxa de aprendizado
    
    for data = randperm(texts)  %a função randperm garante que os dados sejam apresentados de maneira aleatória
        
        %A função minDist encontra o primeiro e segundo BMU e as distâncias
        %do dado analisado a eles. Ela utilizada a distância euclidiana
        %otimizada, citada anteriormente e retorna um vetor com 4 posições:
        %o índice do primeiro BMU, a distância do dado à ele, o índice do
        %segundo BMU e a distância do dado à ele
        
        bmu = minDist(mData(:,data), mWeights, rowMSpace*colMSpace, mData2(:,data));
        
        %O erro de quantização depende da distância do dado ao primeiro BMU
        %e é cumulativo com os dados de treino.
        quantizationError = quantizationError + bmu(2);
        
        %o erro de distorção topológica é calculado com base na informação
        %de vizinhança entre o primeiro e segundo BMUs. Caso eles não sejam
        %vizinhos no espaço matricial, soma-se um ao erro
        if(mAdj(bmu(1),bmu(3)) ~= 1)
            topologicalError = topologicalError + 1;
        end
        
        %esta matriz foi criada para ajudar a vizualizar as informações do
        %treinamento. Ela possui o mesmo número de linhas e colunas do
        %espaço matricial e sempre que um neurônio é considerado BMU, ela
        %incrementa um na posição dele no espaço matricial
        mSpaceBMU(mPosition(bmu(1),1), mPosition(bmu(1),2)) =  mSpaceBMU(mPosition(bmu(1),1), mPosition(bmu(1),2)) + 1;
        
        %a atualização de pesos depende do parâmetro neighborhoodFunction,
        %pois é possível fazer a atualização com base na função bubble ou
        %na função gaussiana
        if(neighborhoodFunction == 0)
            
            %atualiza os pesos do BMU e de todos os vizinhos dele com a
            %função bubble
            mWeights = updateNeighbors(mData(:,data), mAdj, mWeights, bmu(1), neighborhoodRadius, alfa, words, neurons);
            
        %atualiza os pesos do BMU e de todos os vizinhos dele, de acordo
        %com a função gaussiana
        elseif(neighborhoodFunction == 1)
            mWeights = updateNeighborsGaussian(mData(:,data),mAdj, mWeights, bmu(1), neighborhoodRadius, alfa, words, neurons, mPosition);
        end 
    end
    
%     timeStamp2 = datetime('now');
%     duration(t) = timeStamp2 - timeStamp1;
    
    %vetores que armazenam os erros ao longo das iterações sobre o laço das
    %épocas
    errorQ(t) = quantizationError;
    errorT(t) = topologicalError;
 
end

%retorno da função
% a função retorna os erros no decorrer da execução, os pesos dos neurônios
% treinados, as posições dos neurônios no espaço matricial e o contador de
% BMUs
som.errorQ = errorQ/texts;
som.errorT = errorT/texts;
som.mWeights = mWeights;
som.mSpace = mSpace;
som.bmuCount = mSpaceBMU;
% som.duration = duration;


end

