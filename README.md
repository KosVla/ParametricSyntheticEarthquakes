# Parametric representation of synthetic earthquakes 

This public repository contains all necessary functions and subroutines for a parametric representation of synthetic earthquakes, as described in: *Spiridonakos, Minas & Chatzi, Eleni. (2015). Metamodeling of nonlinear structural systems with parametric uncertainty subject to stochastic dynamic excitation. Earthquakes and Structures. 8. 915-934. 10.12989/eas.2015.8.4.915.*

Specifically, the stochastic ground motion model proposed in Rezaeian & Kiureghian (2010) is employed for the parametric representation of synthetic earthquake ground motion acceleration signals. According to this model, the ground motion is produced by time-modulating a normalized filtered white noise process, in this way simulating the time-varying characteristics of both the temporal and spectral content of actual earthquak signals. Synthetic earthquakes are produced by filtering a white noise process through a non-stationary impulse response filter and a non-stationary  modulating function. The non-stationary filter and the modulating functions are described by a finite set of parameters, with sample observations of the latter being estimated through fitting of the model to real recorded earthquake ground motion signals. A visualization of the framework is depicted below for reference.


![Process Visualization](/Visualization.png?raw=true "Schematic of the process")


Based on the notation in the figure above and given that $\omega_f(\tau)=\omega_{mid}+\omega'(\tau-t_{mid})$, the parameters $\omega_{mid}, {\omega}', \zeta_f, I_a,D_{5−95}$, and $t_{mid}$ may be identified for a target accelerogram by matching the properties of the recorded motion with the corresponding statistical measures of the derived stochastic ground motion model. The parameter $I_a$ denotes the expected Arias intensity, which forms a measure of the total energy contained in the motion, $D_{5-95} is the effective duration of the motion 5 (the time interval between the instants at which the $5\%$ and $95\%$ of the expected Arias intensities are reached), and finally, $t_{mid}$ is the time at which a 45% level of the expected Arias intensity is reached. The identified model may be subsequently used for the generation of synthetic ground motion accelerograms with similar time-frequency characteristics with that of the real recorded motion. In a similar way, a pdf may be identified for each of the stochastic ground motion model parameters in order to represent not a single but a set of real earthquake accelerograms. This procedure is presently applied for the modeling of the 3551 ground motion
signals of the PEER database (horizontal components only; PEER 2012). 

## Repository structure

The **main** branch contains the two main scripts to utilise the framework, the license file and the *ReadMe* file.

Specifically, **Runpad_Compute_Parameters_PEER.m** drives the parametrization process of a database of accelerograms, whereas **SingleAccelerogram_DistributionFittingExample.m** serves as an example implementation file that evaluates the respective distributions of the extracted parameters and employs the respective probability density functions to parametrise further unseen accelerograms, i.e., not already included in the database.
Finally, **ForwardProcessExample.m** contains an example evaluation of the full forward process given the parameters.
The source software files are contained in the respective folder **SourceCode** and include all functions and subroutines employed for pre- and post-processing, PSO optimation and filtering operations.

The folder **PEERExamples** contains a few example accelerograms from the PEER database to evaluate the code on the fly, whereas all raw data and workspaces can be found in the repository link provided in the folder **PEER_ALL**.

## References
[1] PEER (2012). Peer ground motion database: http://peer.berkeley.edu/peer ground motion database.

[2] Rezaeian, S. & A. D. Kiureghian (2010). Simulation of synthetic ground motions for specified earthquake and site characteristics. Earthquake Engineering and Structural Dynamics 39(10), 1155–1180.


## Cite

If you use the algorithmic framework presented here you are kindly requested to cite the following work:

```
@article{spiridonakos2015metamodeling,
  title={Metamodeling of nonlinear structural systems with parametric uncertainty subject to stochastic dynamic excitation},
  author={Spiridonakos, Minas D and Chatzi, Eleni N},
  journal={Earthquakes and Structures},
  volume={8},
  number={4},
  pages={915--934},
  year={2015},
  publisher={Techno-Press}
}
```
Further sources which can be of interest include:
```
@article{https://doi.org/10.1002/eqe.997,
author = {Rezaeian, Sanaz and Der Kiureghian, Armen},
title = {Simulation of synthetic ground motions for specified earthquake and site characteristics},
journal = {Earthquake Engineering \& Structural Dynamics},
volume = {39},
number = {10},
pages = {1155-1180},
keywords = {earthquake ground motions, model validation, NGA database, simulation, stochastic models, strong-motion records, synthetic motions},
doi = {https://doi.org/10.1002/eqe.997},
url = {https://onlinelibrary.wiley.com/doi/abs/10.1002/eqe.997},
eprint = {https://onlinelibrary.wiley.com/doi/pdf/10.1002/eqe.997},
year = {2010}
}
```
```
@INPROCEEDINGS{20.500.11850/442909,
copyright = {In Copyright - Non-Commercial Use Permitted},
year = {2020-09-09},
type = {Conference Paper},
institution = {EC and EC},
author = {Vlachas, Konstantinos and Tatsis, Konstantinos and Agathos, Konstantinos and Brink, Adam R. and Chatzi, Eleni},
size = {12 p. accepted version; 27 p. presentation},
keywords = {Reduced order model; Nonlinear dynamical systems; Earthquake ground motions; Parametric modeling},
language = {en},
address = {Zurich},
publisher = {ETH Zurich, Environmental and Geomatic Engineering},
DOI = {10.3929/ethz-b-000442909},
title = {A physics-based, local POD basis approach for multi-parametric reduced order models},
Note = {International Conference on Noise and Vibration Engineering (ISMA 2020) in conjunction with the 8th International Conference on Uncertainty in Structural Dynamics (USD 2020); Conference Location: online; Conference Date: September 7-9, 2020; Conference lecture held on September 9, 2020}
}
```


