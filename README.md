# Nanoshells
Plasmonic Properties of Metallic Nanoshells in Quantum Limit: From Single Particle Excitations to Plasmons

This project presents the codes used for analyzing the optical characteristics of nanoshells in the quantum limit.

Steps to run:

1) Update the octopus input file with the system parameters.
2) Run octopus package.
3) Use size_convergence and spacing_convergence shell scripts to find a suitable size and spacing where the system converges.
4) Once all the parameters are decided, compute the ground state using the input file.
5) Once you have a converged ground state, update the input file to compute the absorption spectra.
Refer to inline comments on the template input file.
6) Use oct-propagation-spectrum to calculate the cross section vectors. 
Then use generate_optical_spectra matlab script to generate the absorbtion spectra.
Significant resonances can be identified using the absorbtion spectra.
7) For each recognized wavelength/frequency perturbate the system with a corresponding electric field,
and run the time dependant simulations.
8) Use the generate_induced_density_x_axis.sh, generate_induced_density_z_plane.sh and generate_squared_projections.sh
to calculate the induced electron densities and squared projections.
9) Use the scripts in Matlab subfolder to analyze the dynamics of the system.
