function generate_induced_e_density_evolution(Folder, outerRadius, innerRadius, Gridsize, Spacing)
    % the folder should contain the induced density along the x axis with time (can be generated using generate_induced_density_x_axis) and the laser field.
    omega=(2*pi/0.1422);
    TotalTime =1000;
    Step=0.1;
    Recording=5;
    Sampling=Step*Recording;

    L=strcat(Folder,'/laser');
    filename=fullfile(L);
    laser=readtable(filename);
    laser.Properties.VariableNames{2} = 't';
    laser.Properties.VariableNames{3} = 'x';


    D=strcat(Folder,'/density');
    filename=fullfile(D);
    density=table2array(readtable(filename));
    [X,Y] = meshgrid(0:Sampling:TotalTime,(-Gridsize:Spacing:Gridsize)/outerRadius);

    pcolor((X/omega),Y,(density(:,1:(TotalTime/Sampling+1))-density(:,1)))
    xlim([0 TotalTime/omega]);
    ylim([-Gridsize Gridsize]);
    hold on;
    %Laser field
    plot ((laser.t(1:TotalTime/Step)/omega),(laser.x(1:TotalTime/Step))*10000,'r','Linewidth',0.5);
    %Boundaries
    plot ([0 24],[outerRadius/outerRadius outerRadius/outerRadius],'--k','Linewidth',1);
    plot ([0 24],[innerRadius/outerRadius innerRadius/outerRadius],'--k','Linewidth',1);
    plot ([0 24],[-innerRadius/outerRadius -innerRadius/outerRadius],'--k','Linewidth',1);
    plot ([0 24],[-outerRadius/outerRadius -outerRadius/outerRadius],'--k','Linewidth',1);

    title('   ')
    xlabel('t/T')
    ylabel('x/R_O')
    view(2);
    colorbar;
    colormap(jet)
    c=max(max(abs((density(:,1:(TotalTime/Sampling+1)))-density(:,1))));
    caxis([-c c])
    shading interp
    ax = gca;
    ax.FontSize = 65; 
    axis([7 17 -1.5 1.5])
    set(gca,'Layer','top')
    set(gcf,'units','inches','position',[5,5,3.25,1.75])
    set(gca,'units','inches','position',[0.45,0.4,2.15,1.1])
    set(gca, 'FontName', 'Arial')
    set(gca,'FontSize',10)
    box on
    set(gca,'Linewidth',1)  
end