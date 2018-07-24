%Arquivo de fun��o: som_training.m
%Prop�sito:
%   Esta fun��o serve para treinar uma rede neural do tipo SOM (Self
%   Organizing Maps). 
%   Ela recebe como par�metros, respectivamente: 
%       - Matriz de dados que servir�o para realizar o treinamento
%       - N�mero de linhas do espa�o matricial
%       - N�mero de colunas do espa�o matricial
%       - Estrutura de lattice que determina as rela��es de vizinhan�a
%       - Inicializa��o (apenas a aleat�ria foi implementada)
%       - N�mero de �pocas que determina o n�mero de itera��es do
%       treinamento
%       - Raio inicial de vizinhan�a
%       - Taxa de aprendizagem inicial
%       - Fun��o de atualiza��o da taxa de aprendizagem (linear, inverso do
%       tempo ou s�rie de pot�ncias ou fixa)
%       - Fun��o de atualiza��o do raio de vizinhan�a (fixa ou decrescente)
%       - Fun��o de atualiza��o dos pesos dentro do raio de vizinhan�a
%       (Bubble ou Gaussiana)
%  

function [som] = som_training( mData, representation, rowMSpace, colMSpace, latice, initialization, epochs, neighborhoodRadius, learningRate, learningFunction, neighborhoodFunction, neighborhoodRadiusFunction)

%mData � a estrutura que armazena os dados de entrada
%Trata-se de uma matriz em que as linhas s�o os termos e as colunas s�o os
%textos
[words, texts] = size(mData);

%o n�mero de neur�nios depende do n�mero de linhas e colunas do espa�o
%matricial. De maneira geral, os testes foram feitos com matrizes
%quadradas, mas a fun��o permite escolher linhas e colunas de maneira
%independente
neurons = rowMSpace*colMSpace;


%A matriz de pesos (mWeights) � uma matriz que guarda as coordenadas de
%cada um dos neur�nios no espa�o vetorial. Ela possui o mesmo n�mero de
%linhas que a matriz de entrada e o n�mero de colunas � a quantidade total
%de neur�nios

%inicializacao das posicioes dos neuronios no espaco vetorial
%apenas a inicializa��o aleat�ria foi implementada
mWeights = initializeMWeights(mData, representation, rowMSpace, colMSpace, initialization, words);


%mSpace guarda as posi��es dos neur�nios no espa�o matricial � uma matriz
%com o n�mero de linhas e colunas pr�-determinados nos par�metros de
%treinamento. Cada elemento guarda o n�mero do neur�nio

%inicializacao das posicioes dos neuronios no espaco matricial
mSpace = initializeMSpace(rowMSpace, colMSpace);

%para guardar as rela��es de vizinhan�as entre os neur�nios, foi criado um
%grafo que est� representado por uma matriz de adjac�ncias. Essa rela��o
%depende do lattice, que pode ser passado por par�metro

%inicializacao do grafo de vizinhanca
%esta fun��o permite construir a matriz de adjac�ncias para o lattice
%retangular e um latticce completo, que considera que um neur�nio � vizinho
%de todos ao redor dele no espa�o matricial
mAdj = initializeMAdj(rowMSpace, colMSpace, mSpace, latice);


%mPosition � uma matriz auxiliar que guarda as posi��es de cada neur�nio no
%espa�o matricial. Ela � utilizada, principalmente, para construir a matriz
%U, ap�s o treinamento.

%A matriz possui o n�mero de neur�nios como quantidade de linhas e apenas 2
%colunas. A coluna 1 indica qual a linha do neur�nio no espa�o matricial e
%a coluna 2 indica a posi��o da coluna do neur�nio no espa�o matricial
mPosition = initializeMPosition(rowMSpace,colMSpace,neurons);

%A fim de otimizar o c�lculo da dist�ncia euclidiana, calcula-se os
%quadrados da matriz de dados apenas uma vez

%mData2 � a matriz que armazena os quadrados dos elementos do conjunto de dados
mData2 = mData.*mData;

mSpaceBMU = zeros(rowMSpace, colMSpace);

%este � o la�o em que ocorre o treinamento e ele roda um n�mero
%pr�-determinado de �pocas, passado como par�metro da fun��o

%laco das epocas
for t = 1:epochs
    
    %Na implementa��o desta h� a op��o de 3 formas de atualizar a taxa de
    %aprendizagem: linear, inverso do tempo e s�ries de pot�ncia. As
    %f�rmulas foram obtidas em bibliografia complementar e implementadas
    
    
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
    
    %Para testes com muitas �pocas, como a taxa de aprendizagem diminui
    %constantemente, adotou-se como poss�vel crit�rio de parada, alfa ser
    %igual a zero, pois seria poss�vel que o n�mero se torna-se t�o
    %pequeno, a ponto de ser arredondado para zero
    if(alfa == 0)
        break;
    end
    
    %o par�metro neighborhoodRadiusFunction define se o raio de vizinha
    %diminuir� com o passar das execu��es ou ser� fixo
    if(neighborhoodRadiusFunction == 1)
        neighborhoodRadius = neighborhoodRadius*exp(-1*t/epochs);
    end
    
    %para cada �poca, as medidas de erro de quantiza��o e de distor��o
    %topol�gicas s�o recalculados para serem armazenados em um vetor e seu
    %comportamento no decorrer das �pocas possa ser analisado
    quantizationError = 0;
    topologicalError = 0;
    

    
%     timeStamp1 = datetime('now'); %linha adicionada para avaliar o
%     desempenho do processamento em uma �poca
    
    %laco que percorre o conjunto de dados, encontra o primeiro e segundo BMUs e atualiza
    %as distancias distancia dos neuronios vizinhos ao primeiro,de acordo com
    %o raio de vizinhanca e a taxa de aprendizado
    
    for data = randperm(texts)  %a fun��o randperm garante que os dados sejam apresentados de maneira aleat�ria
        
        %A fun��o minDist encontra o primeiro e segundo BMU e as dist�ncias
        %do dado analisado a eles. Ela utilizada a dist�ncia euclidiana
        %otimizada, citada anteriormente e retorna um vetor com 4 posi��es:
        %o �ndice do primeiro BMU, a dist�ncia do dado � ele, o �ndice do
        %segundo BMU e a dist�ncia do dado � ele
        
        bmu = minDist(mData(:,data), mWeights, rowMSpace*colMSpace, mData2(:,data));
        
        %O erro de quantiza��o depende da dist�ncia do dado ao primeiro BMU
        %e � cumulativo com os dados de treino.
        quantizationError = quantizationError + bmu(2);
        
        %o erro de distor��o topol�gica � calculado com base na informa��o
        %de vizinhan�a entre o primeiro e segundo BMUs. Caso eles n�o sejam
        %vizinhos no espa�o matricial, soma-se um ao erro
        if(mAdj(bmu(1),bmu(3)) ~= 1)
            topologicalError = topologicalError + 1;
        end
        
        %esta matriz foi criada para ajudar a vizualizar as informa��es do
        %treinamento. Ela possui o mesmo n�mero de linhas e colunas do
        %espa�o matricial e sempre que um neur�nio � considerado BMU, ela
        %incrementa um na posi��o dele no espa�o matricial
        mSpaceBMU(mPosition(bmu(1),1), mPosition(bmu(1),2)) =  mSpaceBMU(mPosition(bmu(1),1), mPosition(bmu(1),2)) + 1;
        
        %a atualiza��o de pesos depende do par�metro neighborhoodFunction,
        %pois � poss�vel fazer a atualiza��o com base na fun��o bubble ou
        %na fun��o gaussiana
        if(neighborhoodFunction == 0)
            
            %atualiza os pesos do BMU e de todos os vizinhos dele com a
            %fun��o bubble
            mWeights = updateNeighbors(mData(:,data), mAdj, mWeights, bmu(1), neighborhoodRadius, alfa, words, neurons);
            
        %atualiza os pesos do BMU e de todos os vizinhos dele, de acordo
        %com a fun��o gaussiana
        elseif(neighborhoodFunction == 1)
            mWeights = updateNeighborsGaussian(mData(:,data),mAdj, mWeights, bmu(1), neighborhoodRadius, alfa, words, neurons, mPosition);
        end 
    end
    
%     timeStamp2 = datetime('now');
%     duration(t) = timeStamp2 - timeStamp1;
    
    %vetores que armazenam os erros ao longo das itera��es sobre o la�o das
    %�pocas
    errorQ(t) = quantizationError;
    errorT(t) = topologicalError;
 
end

%retorno da fun��o
% a fun��o retorna os erros no decorrer da execu��o, os pesos dos neur�nios
% treinados, as posi��es dos neur�nios no espa�o matricial e o contador de
% BMUs
som.errorQ = errorQ/texts;
som.errorT = errorT/texts;
som.mWeights = mWeights;
som.mSpace = mSpace;
som.bmuCount = mSpaceBMU;
% som.duration = duration;


end

