# Parametric representation of synthetic earthquakes 

This public repository contains all necessary functions and subroutines for a parametric representation of synthetic earthquakes, as described in: *Spiridonakos, Minas & Chatzi, Eleni. (2015). Metamodeling of nonlinear structural systems with parametric uncertainty subject to stochastic dynamic excitation. Earthquakes and Structures. 8. 915-934. 10.12989/eas.2015.8.4.915.*

Specifically, the stochastic ground motion model proposed in Rezaeian & Kiureghian (2010) is employed for the parametric representation of synthetic
earthquake ground motion acceleration signals. According to this model, the ground motion is produced by time-modulating a normalized filtered white noise process, in this way simulating the time-varying characteristics of both the temporal and spectral content of actual earthquak signals. Synthetic earthquakes are produced by filtering a white noise process through a non-stationary impulse response filter and a non-stationary  modulating function. The non-stationary filter and the modulating functions are described by a finite set of parameters, with sample observations of the latter being estimated through fitting of the model to real recorded earthquake ground motion signals. A visualization of the framework is depicted below for reference.


![Process Visualization](/Visualization.png?raw=true "Schematic of the process")


Based on the notation in the figure above, given a target accelerogram, the parameters $\omega_{mid}, \tilde{omega}, \zeta_f, I_a,D_{5−95}$, and $t_{mid}$ may be identified by matching the properties of the recorded motion with the corresponding statistical measures of the derived stochastic ground motion model. The identified model may be subsequently used for the generation of synthetic ground motion accelerograms with similar time-frequency characteristics with that of the real recorded motion. In a similar way, a pdf may be identified for each of the stochastic ground motion model parameters in order to represent not a single but a set of real earthquake accelerograms. This procedure is presently applied for the modeling of the 3551 ground motion
signals of the PEER database (horizontal components only; PEER 2012). 

## Repository structure

The **main** branch contains the two main scripts to utilise the framework, the license file and the *ReadMe* file.

Specifically, **Runpad_Compute_Parameters_PEER.m** drives the parametrization process of a database of accelerograms, whereas **SingleAccelerogram_DistributionFittingExample.m** serves as an example implementaion file that evaluates the respective distributions of the extracted parameters and employs the respective probability density functions to parametrise further unseen accelerograms, i.e., not already included in the database.

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
  author={Spiridonakos, Minas D and Chatzia, Eleni N},
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


