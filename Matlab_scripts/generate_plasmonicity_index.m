close all;
clear all;

% Input the induced density file names as an array.
path = [];

% Update the frequencies as an array
freq = [];

labels =char("abcdefgh");
Q_size=size(path,1);
type = 3;

% Update the grid size and spacing
Gridsize = 60;
Spacing =0.5;

for q=1:Q_size

    if type==1 
        RI = 11.176;
        RO = 16;
        name = {'(a) thin nanoshell'}';
    elseif type==2
        RI = 9;
        RO = 15.07;
        name = {'(b) medium-sized nanoshell'};
    else
        RI = 4;
        RO = 14.03;
        name = {'(c) thick nanoshell'};
    end

    file = fopen(string(path(q)));
    tline = fgetl(file);
    i = 0;
    j = 1;
    while ischar(tline)
        i = i+1;
        try
            Density = strsplit(tline)
            X = cell2mat(Density(1));
            Y = cell2mat(Density(2));
            D = cell2mat(Density(3));
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


    V_induced = zeros(size(X,1),size(Y,1));
    for s=1:size(Density,1)
        for w=1:size(Density,1)
            V_induced(s,w)= 0;
            for e=1:size(Density,1)
                for r=1:size(Density,1)
                    if (s~=e && w~=r)
                            V_induced(s,w)= V_induced(s,w)+ Density(e,r)/(sqrt((s-e)^2+(w-r)^2))*Spacing^2;   
                    end
                end
            end
        end
    end

    subplot(4,2,q)
    PI(q)=sum(sum((abs(V_induced)).^2))/(sum(sum((abs(Density)).^2))*Spacing^2);
    RHO_induced(q) = sum(sum((abs(Density)).^2))*Spacing^2;
    induced_V(q) = sum(sum((abs(V_induced)).^2));

    pcolor(Y/RO,X/RO,Density)

    axis([-1.25 1.25 -1.25 1.25])
    caxis([-1e-5 1e-5])

    colormap(jet)
    shading interp
    box on

    syms a; syms b;
    hold on
    fimplicit(@(a,b) (a).^2+(b).^2-1.^2,'k--','MeshDensity',2000,'Linewidth',1)
    fimplicit(@(a,b) (a).^2+(b).^2-(RI/RO).^2,'k--','MeshDensity',2000,'Linewidth',1)


    set(gca, 'FontName', 'Arial')
    set(gca,'FontSize',10)
    box on
    grid off
    set(gca,'Linewidth',1)
    set(gca,'Layer','top')
    ylabel('')
    set(gca,'yticklabel',[])
    xlabel('')
    set(gca,'xticklabel',[])

    hold on
    txt = labels(q);
    text(-1,1,txt,'FontSize',10)
end

offest = 0.49;
yoffset = 0.5;

subplot(4,2,7)
set(gca,'units','inches','position',[offest,yoffset+0.0,0.5,0.5])
subplot(4,2,5)
set(gca,'units','inches','position',[offest,yoffset+0.5,0.5,0.5])
subplot(4,2,3)
set(gca,'units','inches','position',[offest,yoffset+1.0,0.5,0.5])
subplot(4,2,1)
set(gca,'units','inches','position',[offest,yoffset+1.5,0.5,0.5])

subplot(4,2,2)
set(gca,'units','inches','position',[offest+0.5,yoffset+1.5,0.5,0.5])
caxis([-0.75e-5 0.75e-5])
subplot(4,2,4)
set(gca,'units','inches','position',[offest+0.5,yoffset+1.0,0.5,0.5])
caxis([-0.5e-5 0.5e-5])
subplot(4,2,6)
set(gca,'units','inches','position',[offest+0.5,yoffset+0.5,0.5,0.5])


set(gcf,'units','inches','position',[5,5,1.5,2.55])
pause;


close all;
abspath = 'C:\Users\aper0034\Documents\thick\cross_section_vector_4';


files = dir(abspath);
color ={'r-','k-','b-'};
k =1;
filename=fullfile(path);

CSV1=readtable(filename);
CSV1.Properties.VariableNames{1} = 'omega';
CSV1.Properties.VariableNames{2} = 'x';
CSV1.Properties.VariableNames{5} = 'strength';

wavelength = 4.556335177e-8*1e9./CSV1.omega;
plot(wavelength ,CSV1.strength/max(CSV1.strength),'k', 'Linewidth',1)
hold on

xlabel('Wavelength (nm)')
ylabel('Plasmonicity Index (arb. units)')


axis([200 450 0 1.15])
set(gca,'FontSize',45)
stem(4.556335177e-8*1e9./freq,PI/max(PI),'diamondb','filled')
set(gcf,'units','inches','position',[5,5,2.15,2.65])

set(gca,'units','inches','position',[0.5,0.5,1.62,2])
set(gca, 'FontName', 'Arial')
set(gca,'FontSize',10)
box on
set(gca,'Linewidth',1)
text(4.556335177e-8*1e9./freq-11, PI/max(PI)-0.02, {'a','b','c','d','e','f','g'}, 'HorizontalAlignment','center', 'VerticalAlignment','bottom','FontName', 'Arial')
