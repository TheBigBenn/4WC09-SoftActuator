# 4WC09-SoftActuator
Code and data belonging to the BEP of B.W.B. Proper, this contains all the code, 
measurements and plots of said measurements created for the project.

//Arduino
  Contains all arduino code developed for the case
  //Arduino/PressureController
  Contains the code for the complete controller
  
  //Arduino/PressureRegulator
  Contains the code given at the start of the case
  
  //Arduino/PressureRegulatorMeasurement
  Contains the code used for the standard measurements
  
  //Zip file
  Contains all code in easy to download zip
  
  //Other
  Contains libraries

//Extra files
  Contains extra files used for the project, these range from certain images to text files with links for research

//Metingen BEP
  Contains raw files of the measurements including measurement settings using the program Coolterm
  
//Model
  Contains everything relating to the model and code
  //Verwerkt and Plots
  Contains all processed plots, and are therefore largely inconsequential, use the same naming scheme as the data obtained from the measurements
  
  //Scriptextra
  Contains additional scripts written for specific functions. Examples are fits and averaging scripts
  
  //DataProcOud
  Contains code for processing measurements, Is only applicable for older measurements, This means everything in the folders Data/Old, Data/Verwerkt and Data/VoorNT
  
  //StateSpaceFix
  Contains matlab code to run the simulink model, the model can be found in Model2.slx
  
  //PlotCompareN
  Uses function ComparePlotN to compare measurements, only works on data from Data/VoorPID
  
  //SystemEstimate
  Were used for parameter estimation, would run the scripts for different settings
  
  //Meting files,
  PID is for the PID measurements, usable for all the files that do not have their own location in Data, and Data/DataAfterPID
  ProcessLFN, takes the raw files and plots them in their entirety, usable on Data/VoorPID
  ProcessN, automatically approximates start of signal, also only works with Data/VoorPID
  
  To make different files work for different formats, the read function has to be changed, as an example, there are a total of three 
  measurement types, Files containing two vectors of format [Duration Pressure], two vectors of format [Ticks Pressure] and
  three vectors of [Ticks Signal Pressure] Duration must be converted to absolute time, pressure and signal can be taken as is, and
  ticks must be multiplied by the samplerate, 0.025s in the case of these measurements.

//Printbaar
  Contains printable files, the NX10 sketch can be used to create an air tank of custom dimensions.



