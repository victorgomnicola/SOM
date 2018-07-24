%Arquivo de fun��o: categorizeBMU.m
%Prop�sito:
%  Como os conjuntos de dados analisados foram pr�-categorizados, foi
%  criada uma fun��o para associar um neur�nio a uma determinada categoria.
%  
%  Para isto, ap�s o treinamento da rede neural, a fun��o recebe a matriz
%  de dados, os pesos e as labels com as categorias, encontra o BMU para
%  cada um dos dados e, de acordo com a categoria do dado, incrementa um
%  contador de categorias para o BMU. Ao final do primeiro la�o, haver� uma
%  matriz em que o n�mero de linhas � o n�mero de categorias e o n�mero de
%  colunas � o n�mero de neur�nios. 
%
%  Cada elemento dessa matriz representa quantos dados de determinada
%  categoria consideraram determinado neur�nio como BMU
%
%  A categoria que tiver maior contagem ser� considera a categoria que o
%  neur�nio representa.


function [ categorized ] = categorizeBMU( mData, mWeights, categories, rowMSpace, colMSpace)

    [words, texts] = size(mData);
    neurons = rowMSpace*colMSpace;
    mData2 = mData.*mData;
    
    categorized.mLabels = zeros(rowMSpace, colMSpace);
    count = zeros(max(categories,neurons));
    
    
    for data = 1:texts
        bmu = minDist(mData(:,data), mWeights, neurons, mData2(:,data));
        count(categories(data),bmu(1)) = count(categories(data),bmu(1)) + 1;
    end
    
    aux = 1;
    for i = 1:rowMSpace
        for j = 1:colMSpace
            [maxValue, maxIndex] = max(count(:,aux));
            categorized.mLabels(i,j) = maxIndex;
            
            aux = aux+1;
        end
    end
    categorized.count = count;
    
end

