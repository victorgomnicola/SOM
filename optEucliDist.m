%Arquivo de fun��o: optEucliDist.m
%Prop�sito:
%   Funcao que calcula a dist�ncia euclidiana utilizando operadores
%   matriciais do MATLAB. Al�m disso, o quadrado da diferen�a que faz parte
%   da f�rmula foi expandido para que fosse poss�vel aproveitar os
%   quadrados das dist�ncias pr�-calculados da matriz de dados. OU seja,
%   (x-y)^2 foi expandido em (x^2 - 2xy + y^2)
%

 
function [ dist ] = optEucliDist( currentNeuron, currentData ,currentData2)

%Esta variavel armazena o quadrado do vetor de pesos do neur�nio atual
%Para isso, utiliza-se um operador que multiplica ponto a ponto dois vetores
currentNeuron2 = currentNeuron.*currentNeuron;

%armazena a multiplica��o 2*neuronioAtual*dadoAtual
twoXY = 2*currentNeuron.*currentData;

%retorna a ra�z quadrada do quadrado da diferen�a expandida
dist = sqrt(sum((currentNeuron2 - twoXY + currentData2)));
end

