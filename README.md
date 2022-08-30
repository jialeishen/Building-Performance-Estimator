# Building-Performance-Estimator
Building performance estimation tools for predicting indoor thermal and air quality metrics including PMV/PPD, DALYs to certain air pollutants, and airborne infection risks. 

## Thermal Comfort
### PMV/PPD
A matlab function that takes clothing, metabolic rate, external work, air temperature, MRT, air velocity and RH as inputs and PMV and PPD as outputs (comply with ASHRAE 55). 

Tool: [PMVPPD](https://github.com/jialeishen/Building-Performance-Estimator/blob/main/PMVPPD.m)

## Indoor Air Quality (IAQ)
### DALYs
An online tool (Google Sheets) for estimating Disability Adjusted Life Years (DALYs) of exposure to various indoor pollutants (e.g. PM2.5, Ozone, NO2, VOCs, etc.), including IND and ID approaches.

Tool: [DALYs in Indoor Air](https://docs.google.com/spreadsheets/d/1lQxR5frw5s5wiK_D02Wj1OCCnwapQ8GbxC8YHqjgxM0/edit?usp=sharing) (For permission to use it, please [contact with me](mailto:jshen20@syr.edu))

### Infection risk of airborne viruses
An online tool (Google Sheets) to estimate the COVID-19 indoor infection risk through airborne transmission with the Wells-Riley model. 

Tool: [Indoor Airborne Risk COVID-19 Estimator](https://docs.google.com/spreadsheets/d/1xMF5hGuPSDddIIUpt9iV_dvuKdB6T7I8SA3-Z2LCcV0/edit?usp=sharing) (For permission to use it, please [contact with me](mailto:jshen20@syr.edu))

### Virus spreading model
A matlab program that simulates the virus spreading among population (considering all possible transmission routes) based on the Susceptible-Exposed-Infectious-Removed (SEIR) model.

Tool: [SEIR](https://github.com/jialeishen/Building-Performance-Estimator/blob/main/SEIR.m)
