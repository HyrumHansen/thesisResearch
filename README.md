# **Hyrum Hansen Master's Thesis**

This repository contains all functions and scripts required to find G-optimal designs using methods outlined in the text. A link to the document will be available here once published. 

### Reproducable Example:

This repository contains a script that can be downloaded and immediately executed, assuming the correct add-ons have been added to the MATLAB path. 

**Step 1: Add dependencies**
Navigate to the add-ons menu in the 'environment' section of the 'home' tab. 
   - Global Optimization Toolbox
   - Statistics and Machine Learning Toolbox
   - Optimization Toolbox


**Step 2: Download the repository**
Clone or download this repository. You now have access to all the tools we built for finding G-optimal designs with Gloptipoly & SeDuMi.

**Step 3: Run the example script**
Navigate to the folder 'reproducable examples.' Inside this folder open the 'main.m' file. You may be prompted to add the file to the path. Do so, and it should execute correctly. 

You may specify one of 'nm', 'pexch', or 'pso' as the argument to the run_example() function. A seed is set for reproducibility. The PEXCH design has a G-efficiency of 77% with respect to SOA, the Nelder-Mead design has about 89%. 
