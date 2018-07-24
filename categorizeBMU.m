%Arquivo de função: categorizeBMU.m
%Propósito:
%  Como os conjuntos de dados analisados foram pré-categorizados, foi
%  criada uma função para associar um neurônio a uma determinada categoria.
%  
%  Para isto, após o treinamento da rede neural, a função recebe a matriz
%  de dados, os pesos e as labels com as categorias, encontra o BMU para
%  cada um dos dados e, de acordo com a categoria do dado, incrementa um
%  contador de categorias para o BMU. Ao final do primeiro laço, haverá uma
%  matriz em que o número de linhas é o número de categorias e o número de
%  colunas é o número de neurônios. 
%
%  Cada elemento dessa matriz representa quantos dados de determinada
%  categoria consideraram determinado neurônio como BMU
%
%  A categoria que tiver maior contagem será considera a categoria que o
%  neurônio representa.


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

