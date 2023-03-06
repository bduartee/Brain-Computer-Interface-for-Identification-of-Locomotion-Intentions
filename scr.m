%----Carregar os ficheiros txt e mat----------%
%----normalização dos dados de -1 a 1---------%
dat1 = normalize(readtable("1"), 'range', [-1 1]);
dat2 = normalize(readtable("2"), 'range', [-1 1]);
dat3 = normalize(readtable("3"), 'range', [-1 1]);
dat4 = normalize(readtable("4"), 'range', [-1 1]);
dat5 = normalize(readtable("5"), 'range', [-1 1]);
dat6 = normalize(readtable("6"), 'range', [-1 1]);
dat7 = normalize(readtable("7"), 'range', [-1 1]);
dat8 = normalize(readtable("8"), 'range', [-1 1]);
dat9 = normalize(readtable("9"), 'range', [-1 1]);
dat10 = normalize(readtable("10"), 'range', [-1 1]);
gait1 = load("g1");
gait2 = load("g2");
gait3 = load("g3");
gait4 = load("g4");
gait5 = load("g5");
gait6 = load("g6");
gait7 = load("g7");
gait8 = load("g8");
gait9 = load("g9");
gait10 = load("g10");

Tout1= pos_ind(gait1,dat1,"RA","RD")
Tout2= pos_ind(gait2,dat2,"RA","RD")
Tout3= pos_ind(gait3,dat3,"RA","RD")
Tout4= pos_ind(gait4,dat4,"RA","RD")
Tout5= pos_ind(gait5,dat5,"RA","RD")
Tout6= pos_ind(gait6,dat6,"RA","RD")
Tout7= pos_ind(gait7,dat7,"RA","RD")
Tout8= pos_ind(gait8,dat8,"RA","RD")
Tout9= pos_ind(gait9,dat9,"RA","RD")
Tout10= pos_ind(gait10,dat10,"RA","RD")

%=======Juntar os valores numa única tabela=================
valores = [Tout1;Tout2;Tout3;Tout4;Tout5;Tout6;Tout7;Tout8;Tout9;Tout10]

function Tout= pos_ind(gait,dat,sigla, sigla1)

    pos=[];
    pos1=[];
    ind_min=[];
    ind_max=[];
    dados=[];
    nomes=[];
    Tout = [];
%============== Fazer um array com o nome das colunas =========%
    for i = 1:36

        b='maximo'
        a=num2str(i)
        c=[b a]
        d='minimo'
        e=[d a]
        f='media'
        g=[f a]
        h='desvio'
        i=[h a]
        l= {c,e,g,i}
        nomes = [nomes l]
    end

    nomes = [nomes 'label']  %ACRESCENTAR A COLUNA LABEL

    for i = 1:(length(gait.gc.label)) %GAURDAR TODAS AS POSIÇÕES EM QUE APARECE A 'sigla'
        if gait.gc.label(i)== sigla 
            pos=[pos; i];
        end
        if gait.gc.label(i)== sigla1 
            pos1=[pos1; i];
        end
    end

    for i= 1:(length(pos)) %Para a 'sigla'
        Features=[]%Abrir vetor para guardar max, min, med e desv de todos os canais para um intervalo
        ind_pos=pos(i);
        ind_min=gait.gc.index(ind_pos);  %ir buscar à lista index os indices
        ind_max=gait.gc.index(ind_pos+1);
        dados=dat(ind_min:ind_max,2:37) %Retira o intervalo do dataset
        
        for i = 1:36 %Para fazer todos os canais (coluna em coluna)
            
                coluna=dados(1:end,i) %Para retirar todos os valores do intervalo no dataset.txt 
                val = table2array(coluna)
                maxi = max(val)     
                mini = min(val)
                media = mean(val)
                desv = std(val)
                T = {maxi,mini,media,desv}      
                Features = [Features T] %Guarda linha com os valores para todas as colunas (144)
        end  
        Features = [Features 0] %Acrescentar label=0 porque é 'RA'
        %Meter a linha 'Features' na nossa tabela
        Tfinal = cell2table(Features,'VariableNames',nomes)
        Tout = [Tout; Tfinal]
    end
    
    for i= 1:(length(pos1)) %Para a 'sigla1'
        Features=[]%Abrir vetor para guardar max, min, med e desv de todos os canais para um intervalo
        ind_pos=pos1(i);
        ind_min=gait.gc.index(ind_pos);  %ir buscar à lista index os indices
        ind_max=gait.gc.index(ind_pos+1);
        dados=dat(ind_min:ind_max,2:37) %Retira o intervalo do dataset a começar em 2 porque a primeira coluna é o tempo
        
        for i = 1:36 %Para fazer todos os canais (coluna em coluna)
            
                coluna=dados(1:end,i) %Para retirar todos os valores do intervalo no dataset.txt 
                val = table2array(coluna)
                maxi = max(val)     
                mini = min(val)
                media = mean(val)
                desv = std(val)
                T = {maxi,mini,media,desv}      
                Features = [Features T] %Guarda linha com os valores para todas as colunas (144)
        end  
        Features = [Features 1] %Acrescentar label=1 porque é 'RD'
        %Meter a linha 'Features' na nossa tabela
        Tfinal = cell2table(Features,'VariableNames',nomes)
        Tout = [Tout; Tfinal]
    end
           
end



