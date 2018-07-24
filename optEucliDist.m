%Arquivo de função: optEucliDist.m
%Propósito:
%   Funcao que calcula a distância euclidiana utilizando operadores
%   matriciais do MATLAB. Além disso, o quadrado da diferença que faz parte
%   da fórmula foi expandido para que fosse possível aproveitar os
%   quadrados das distâncias pré-calculados da matriz de dados. OU seja,
%   (x-y)^2 foi expandido em (x^2 - 2xy + y^2)
%

 
function [ dist ] = optEucliDist( currentNeuron, currentData ,currentData2)

%Esta variavel armazena o quadrado do vetor de pesos do neurônio atual
%Para isso, utiliza-se um operador que multiplica ponto a ponto dois vetores
currentNeuron2 = currentNeuron.*currentNeuron;

%armazena a multiplicação 2*neuronioAtual*dadoAtual
twoXY = 2*currentNeuron.*currentData;

%retorna a raíz quadrada do quadrado da diferença expandida
dist = sqrt(sum((currentNeuron2 - twoXY + currentData2)));
end

