function generate_KS_state_evolution(Folder, omega)
    % Folder should contain sqr_projections and info from octopus
    L=strcat(Folder,'/sqr_projections');
    filename=fullfile(L);
    Projectiontable=readtable(filename, 'ReadVariableNames', false);
    Projection=table2array(Projectiontable(:,1:22500));

    L=strcat(Folder,'/info');
    filename=fullfile(L);
    Stat_info=readtable(filename, 'ReadVariableNames', false);

    f=table2array(Stat_info(:,4));
    states=table2array(Stat_info(:,3));

    OcupNo=size(f,1);
    time=size(Projection,1);
    P=zeros(time,OcupNo);

    Pdiff=zeros(time,OcupNo);
    
    T=2*pi/omega;
    sampling = 5;

    for i=1:time
        for j=1:OcupNo
            for k=1:OcupNo
               P(i,j)=P(i,j)+f(k)*Projection(i,150*(j-1)+k); 
            end
            Pdiff(i,j)=P(i,j)-f(j);

        end
    end

    imagesc(Pdiff');

    colorbar
    c=max(max(abs((Pdiff))));
    caxis([-c c]);

    %colormap settings
    n=100;
    r = [(0:1:n-1)/n,ones(1,n)]; 
    g = [(0:n-1)/n, (n-1:-1:0)/n]; 
    b = [ones(1,n),(n-1:-1:0)/n]; 
    c = [r(:), g(:), b(:)];
    colormap(c);
    hold on;


    xlabel('t/T','FontSize',65);
    ylabel('Kohn-Sham state','FontSize',65);
    view(2);
    %xticks for periods
    t=0:1:time*sampling/T;
    xticks(t*T/sampling);
    xticklabels(t);

    %Cross lines for states (deduced from energy level differences)
    hold on;
    r=[0.5:1:time+0.5];

    w=[1,3,5,7,9,11,13,1,15,3,5,7,17,9,1,11,15,1,3,3,5,1,4];   % thin shell
    %w = [1,3,5,7,9,11,1,3,13,5,7,15,9,1,17,3,11,5,1,7,3,5,1,7] %medium shell
    %w=[1,3,5,7,1,9,3,5,11,7,1,13,3,9,15,5,1,11,3,1,7,13,3,1,5,3,7] %thick shell
    sum_w=150;
    y_ticks=zeros(size(w));
    for i=1:size(w,2)
        sum_w=sum_w-w(i);
        y_ticks(i)=150-sum_w-w(i)/2;
        q=ones(size(r))*(150.5-sum_w);
        plot(r,q,'k--');   
    end

    A={'1s','1p','1d','1f','1g','1h','1i','2s','1j','2p','2d','2f','1k','2g','3s','2h','2j','4s','3p','4p','3d','5s','3f'}; % thin shell
    %A={'1s','1p','1d','1f','1g','1h','2s','2p','1i','2d','2f','1j','2g','3s','1k','3p','2h','3d','4s','3f','4p','4d','5s','4f'}% medium
    %A={'1s','1p','1d','1f','2s','1g','2p','2d','1h','2f','3s','1i','3p','2g','1j','3d','4s','2h','4p','5s','3f','2i','5p','6s','5d','6p','5f'} %thick

    yticks(y_ticks); 
    yticklabels(A);    
    set(gca,'FontSize',20)
    xlabel('t/T','FontSize',65);
    ylabel('Kohn-Sham state','FontSize',65);

    set(gcf,'units','inches','position',[5,5,3.25,5])
    set(gca,'units','inches','position',[0.45,0.4,2.15,4.3])
    set(gca, 'FontName', 'Arial')
    set(gca,'FontSize',10)
    box on
    set(gca,'Linewidth',1)
    set(gca,'Layer','top')
    xlim([100,165])
end