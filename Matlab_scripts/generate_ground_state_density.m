function generate_ground_state_density(filename, outerRadius, innerRadius)
    % filename should point to the electron density of a converged system.(
    % ground state)
    file = fopen(filename);
    Gridsize = 60;
    Spacing =0.5;

    tline = fgetl(file);
    i = 0;
    j = 1;
    while ischar(tline)
        i = i+1;
        try
            Density = strsplit(tline);
            X = cell2mat(Density(2));
            Y = cell2mat(Density(3));
            D = cell2mat(Density(4));
            x(j) = str2num(X);
            y(j) = str2num(Y);
            rho(j) = str2num(D);
            j = j+1;
        catch
        end
        tline = fgetl(file);
    end
    fclose(file);

    [X,Y] = meshgrid(-Gridsize:Spacing:Gridsize,-Gridsize:Spacing:Gridsize);
    Density = zeros(size(X,1),size(Y,1));
    for i=1:size(rho,2)
       x_index = round((x(i)+ Gridsize)/ Spacing) +1;
       y_index = round((y(i)+ Gridsize)/ Spacing) +1;
       Density(x_index,y_index)= rho(i);
    end

    plot(X(1,:)/outerRadius,Density(round(size(X,1)/2),:), 'Linewidth',1)
    hold on

    JD = trapz(Density(round(size(X,1)/2),:))*Spacing/(2*(outerRadius-innerRadius));
    plot([1, 1],[0, JD],'k','HandleVisibility','off', 'Linewidth',1)
    plot([innerRadius/outerRadius, 1],[JD, JD],'k','HandleVisibility','off', 'Linewidth',1)
    plot([innerRadius/outerRadius, innerRadius/outerRadius],[0, JD],'k','HandleVisibility','off', 'Linewidth',1)

    plot([-1, -1],[0, JD],'k','HandleVisibility','off', 'Linewidth',1)
    plot([-1, -innerRadius/outerRadius],[JD, JD],'k','HandleVisibility','off', 'Linewidth',1)
    plot([-innerRadius/outerRadius, -innerRadius/outerRadius],[0, JD],'k','HandleVisibility','off', 'Linewidth',1)

    xlabel('x/RO')
    ylabel('Electron density (\rho)')
    set(gca,'FontSize',45)
    axis([-1.5 2.6 0 0.011])

    leg=legend('show','Location','northeast');
    leg.ItemTokenSize = [10,10];
    set(gcf,'units','inches','position',[5,5,3.25,2])
    set(gca,'units','inches','position',[0.59,0.4,2.6,1.45])
    set(gca, 'FontName', 'Arial')
    set(gca,'FontSize',10)
    box on
    set(gca,'Linewidth',1)
    set(gca,'Layer','top')
end