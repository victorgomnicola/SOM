latice = 2;
initialization = 0;
epochs = 40;
learningFunction = 0;
neighborhoodFunction = 1;
neighborhoodRadiusFunction = 1;


for alfa = [0.5:0.1:1]
    
    n = int2str(alfa*10)
    input = ['discoverTF'];
    
    for representation = [1]


        filePath = ['preProcessamento\', input,'.csv']
        
        mData = csvread(filePath);
        mData = mData';
        size(mData)
        
        for rowColum = [5:10]
            
            rowMSpace = rowColum;
            colMSpace= rowColum;
            
            for nR = [1:round(rowColum/2)]
                
                
                nomeArquivo = ['Resultados\', outputFileName, '.xlsx']
                mWeights = xlsread(nomeArquivo,'weights','A');
                [lin, neuron] = size(mWeights);
                
                
                [words, texts] = size(mData);
                neurons = rowMSpace*colMSpace;
                mData2 = mData.*mData;
               
                for data = [1:neuron]
                    
                end



                xlswrite(['Resultados\', outputFileName, '.xlsx'], som.mWeights, 'weights');
%                 xlswrite(['Resultados\', outputFileName, '.xlsx'], categorized.mLabels, 'LabeledNeurons');
%                 xlswrite(['Resultados\', outputFileName, '.xlsx'], categorized.count, 'categoriesCount');
                xlswrite(['Resultados\', outputFileName, '.xlsx'], som.errorQ, 'errorQ');
                xlswrite(['Resultados\', outputFileName, '.xlsx'], som.errorT, 'errorT');
                xlswrite(['Resultados\', outputFileName, '.xlsx'], uMatrix2, 'uMatrix');
                xlswrite(['Resultados\', outputFileName, '.xlsx'], som.bmuCount, 'bmuCount');
                
            end
        end
    end
end