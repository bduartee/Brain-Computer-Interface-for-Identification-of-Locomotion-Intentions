%% Carregar tabelas de features
L=height(valores);
Ltreino=0.7*L
Lvalidacao=0.85*L

valores_random = valores(randperm(size(valores,1)), :);%criar tabela aleatoria com a tabela de valores

valores_treino=valores_random((1:round(Ltreino)),:);
valores_validar=valores_random((round(Ltreino)+1:(round(Lvalidacao))),:)
valores_teste=valores_random((round(Lvalidacao)+1):end,:)

Ttreino_mais_validar= [valores_treino; valores_validar]; %junção da tabela treino+validação
treino_validacao = table2array(Ttreino_mais_validar(:, 1:end-1));%dados do treino+validaçao
classe_tre_val = table2array(Ttreino_mais_validar(:, end)); %classes do treino+validaçao

dados_teste = table2array(valores_teste(:, 1:end-1));
classe_teste = table2array(valores_teste(:, end));
tamanho = height(treino_validacao);%tamanho de 85% da tabela (treino+validação) 


%% Cross validation
cross_validation = cvpartition(tamanho, 'KFold', 10);

%% PCA-Extração de Features
[coeff,scoreTrain,~,~,explained,mu] = pca(treino_validacao);

95% de toda a variabilidade
sum_explained = 0;
idx = 0;
while sum_explained < 95
    idx = idx + 1;
    sum_explained = sum_explained + explained(idx);
end

%% Otimização dos Hiperparâmetros
% Treinar o modelo só com essas comentários 
Matriz = scoreTrain(:,1:idx);
%Criação do Classificador
mdl = fitcsvm(Matriz, classe_tre_val,'KernelFunction','linear', 'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions', struct('optimizer', 'gridsearch', 'ShowPlots',true,...
    'CVPartition', cross_validation, 'AcquisitionFunctionName','expected-improvement-plus'));

%% Accuracy do treino+validação com as melhores features
L1 = height(predict(mdl,Matriz));      % retorna as labels 

accuracy_treino_validacao = ((sum((predict(mdl,Matriz)) == classe_tre_val)) / (L1)) * 100

%% Teste
Matriz_teste = (dados_teste-mu)*coeff(:,1:idx);
L2 = height(predict(mdl,Matriz_teste));  
accuracy_teste = ((sum((predict(mdl,Matriz_teste))== classe_teste)) / (L2)) * 100

%% Matrizes de confusão
subplot(1,2,1)
matriz_confusao_treino = confusionchart(classe_tre_val, predict(mdl,Matriz))
title('Matriz de Confusão de Treino e Validação');
subplot(1,2,2)
matriz_confusao_teste = confusionchart(classe_teste, predict(mdl,Matriz_teste))
title('Matriz de Confusão de Teste');


%% Plot Gráfico
figure
gscatter(dados_teste(:,1),dados_teste(:,2) ,classe_teste);

h = gca;
lims = [h.XLim h.YLim]; % Extract the x and y axis limits
title('{\bf Diagrama de Dispersão}');


