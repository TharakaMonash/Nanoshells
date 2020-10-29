function generate_optical_spectra(filename)
% Generated the absorption spectra graph for a given file
    absorption=readtable(filename);
    absorption.Properties.VariableNames{1} = 'omega';
    absorption.Properties.VariableNames{2} = 'x';
    absorption.Properties.VariableNames{5} = 'strength';

    wavelength = 4.556335177e-8*1e9./absorption.omega;
    plot(wavelength ,absorption.strength/max(absorption.strength), 'Linewidth',1)

    xlabel('Wavelength (nm)')
    ylabel('Absorption (arbitrary units)')

    axis([200 500 -0.05 1.15])
    set(gca,'FontSize',45)

    set(gcf,'units','inches','position',[5,5,3.25,2.25])
    set(gca,'units','inches','position',[0.5,0.5,2.6,1.5])
    set(gca, 'FontName', 'Arial')
    set(gca,'FontSize',10)
    box on
    set(gca,'Linewidth',1)
end