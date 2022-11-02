# Parametric representation of synthetic earthquakes 

This repository contains all necessary functions and subroutines for a parametric representation of synthetic earthquakes. 
Specifically, the stochastic ground motion model proposed in Rezaeian & Kiureghian 2010 is employed for the parametric representation of synthetic
earthquake ground motion acceleration signals.
According to this model the ground motion is produced by time-modulating a normalized filtered white noise process. 
In order to simulate the time-varying characteristics of both the temporal and spectral content of a real earthquake, the modulating function and
the Impulse Response Filter (IRF) of the aforementioned model have non-stationary properties.
Thus, via the proposed framework synthetic earthquakes are produced by filtering a white noise process through a non-stationary impulse response filter and a
non-stationary  modulating function in order to simulate the time-varying characteristics for both the temporal and spectral content of a real earthquake. The non-stationary filter and the modulating functions are described by a small number of uncertain parameters, 
with sample observations of the latter being estimated through fitting of the model to real recorded earthquake ground motion signals.

![Process Visualization](/Visualization.jpg?raw=true "Schematic of the process")

Therefore, given a target accelerogram, the parameters $ωmid,ω′, ζf , Ia,D5−95, and tmid$ may be identified 
by matching the properties of the recorded motion
with the corresponding statistical measures of
the stochastic ground motion model (Rezaeian & Kiureghian
2010). The identified model may be subsequently
used for the generation of synthetic ground
motion accelerograms with similar time-frequency
characteristics with that of the real recorded motion.
In a similar way, a pdf may be identified for each
of the stochastic ground motion model parameters in
order to represent not a single but a set of real earthquake
accelerograms. This procedure is presently applied
for the modeling of the 3551 ground motion
signals of the PEER database (horizontal components
only; PEER 2012). From the identified sets of parameters,
only the 1000 with the best model fitting are
kept for the subsequent analysis. The resulting histograms
for the identified parameters and the fitted
pdfs are shown in figure 1 (D5−95 and tmid are shown
in normalized discrete time t/T).

# Code repository
The software implementation of a two-story frame with Bouc-Wen hysteretic links is provided in this repository, as part of a multi-degree of freedom nonlinear response simulator benchmark case study proposed in the ** 5th Edition of the Workshop on Nonlinear System Identification Benchmarks** (April, 2021, [Link](https://sites.google.com/view/nonlinear-benchmark/benchmarks)). Together with the software implementation, the benchmark simulator has been used to create five standardized datasets for identification applications. Those are provided through the zenodo platform [here](https://doi.org/10.5281/zenodo.4742248) for reference purposes.

The implementation of the software aims to be utilized as a benchmark problem to validate methods and tools in structural health monitoring, model reduction, or identification applications. The proposed benchmark is provided as a framework simulator and not a single function, thus offering full flexibility for the user to modify and evaluate the shear frame based on customized needs and requirements of the underlying problem. For this reason, the frame is excited using a parametrized ground motion excitation, created through a stochastic signal, the Bouc-Wen model is parametrized, and the software offers extension possibilities such as multi-story frame assembly, deterioration or degradation phenomena, and localized damage representation. All these possibilities are documented in the description provided. 

## Dataset Repository 

The benchmark simulator has been used to derive five standardized simulation datasets as part of the conference submission to be employed as a comparison reference for identification applications. Each dataset refers to a separate scenario, representing damage phenomena, parameter estimation or calibration case studies. The detailed setup of the datasets can be found on the description file. The datasets are provided through the zenodo platform [here](https://doi.org/10.5281/zenodo.4742248).

## Repository structure

The **main** branch contains the description of the case study, along with a welcome *ReadMe* file.

The standardized MATLAB implementation is provided in the **Version0.0_Matlab** branch, along with a dedicated *ReadMe* file documenting the coding scripts and the subdirectories of the repository. In this branch the files used to simulate the standardized datasets are also provided, along with an additional *ReadMe* documenting the configuration files.

An example python implementation of the framework is also provided in the **Version0.0_Python** branch, along with a dedicated *ReadMe* file.

Any additional branches provide updated or modified versions of the software. Each branch contains a dedicated *ReadMe* file documenting the adjustments compared to the standardized version. 

For example, the  **Version_1.0_Matlab** branch contains a modified frame with hysteretic links assembled only on the rotational degrees of freedom and bending-to-shear coupling to represent a shear frame under earthquake excitation in a more realistic way. All corresponding modifications are documented on the respective *ReadMe* files of the branch.
Modified Features compared to Version 0.0 include:
* Bouc-Wen links are activated only on the rotational degrees of freedom
* Bending and shear degrees of freedom are now coupled
* The option to assemble the Bouc-Wen bw_k coefficient from the EI coefficient of the respective beam element


## Features

* Multi degree of freedom nonlinear response simulator
* Hysteretic behavior of connections through Bouc-Wen links
* Degradation and deterioration phenomena
* Stochastic ground motion excitation
* User-input excitation (signal) possible
* Parametric dynamic response and parametrized Bouc-Wen links
* Multi-story extension possible through automatic input file creation function  
* Simulation of localized phenomena
* Standardized datasets for tasks related to system identification applications, reduced-order or surrogate modelling applications in [here](https://doi.org/10.5281/zenodo.4742248)

## Motivation
A diverse variety of engineering and dynamic systems, ranging from control applications and solid mechanics to biology and economics, feature hysteretic phenomena. This commonly encountered nonlinear behavior can be captured and described via diverse numerical models, with the Bouc-Wen representation comprising a common choice within the nonlinear dynamics and vibration engineering community. In this benchmark, the Bouc-Wen model is employed to characterize the response of the nodal connections of a two-story frame structure. The resulting shear frame with hysteretic links is proposed as a multi-degree of freedom nonlinear response simulator.

This case study can be seen as an extension to the single degree of freedom 'Hysteretic Benchmark with a Dynamic Nonlinearity' problem, which is already featured in the nonlinear benchmark catalogue [here](https://sites.google.com/view/nonlinear-benchmark/). Our simulator employs a similar parameterized representation of the Bouc-Wen model for each nonlinear link and builds upon it to also include strength deterioration and stiffness degradation effects in a structure with increased dimensionality. As a result, the featured parametric shear frame serves as a multi-degree of freedom nonlinear response simulator, able to model a wide range of nonlinear effects through the parametrized Bouc-Wen couplings.

The provided simulator can be utilized as a benchmark problem to validate methods and tools in structural health monitoring, model reduction, or identification applications. It has already been exploited in a reduced order modelling context to validate the performance of parametric, physics-based ROMs for nonlinear, dynamical systems in [2,3,4]. 
Compared to the existing Bouc-Wen oscillator benchmark featured in the nonlinear benchmark website, described in detail in [5], the proposed multi-degree of freedom simulator allows for increased complexity studies due to the higher dimensionality of the system and the potential for multi-parametric numerical examples. In addition, the proposed benchmark is provided as a framework simulator and not a single function, thus offering full flexibility for the user to modify and evaluate the shear frame based on customized needs and requirements of the underlying problem.

## References
[1] PEER (2012). Peer ground motion database: http://peer.berkeley.edu/peer ground motion database.

[2] Rezaeian, S. & A. D. Kiureghian (2010). Simulation of synthetic ground motions for specified earthquake and site characteristics. Earthquake Engineering and Structural Dynamics 39(10), 1155–1180.


## Cite

If you use this nonlinear Bouc-Wen benchmark for academic research, you are encouraged to cite the following paper:

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
