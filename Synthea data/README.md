## The background

The AU demographic data and US California mental illness data (Synthetic data) is too large to upload even using Git Large File Storage. 
The [AU demographic data](https://wehieduau.sharepoint.com/:f:/r/sites/StudentInternGroupatWEHI/Shared%20Documents/Clinical%20Dashboards/synthea%202023/australian%20data?csf=1&web=1&e=bWyI1x) and [US California data](https://wehieduau.sharepoint.com/:f:/r/sites/StudentInternGroupatWEHI/Shared%20Documents/Clinical%20Dashboards/synthea%202023/synthea/data?csf=1&web=1&e=lKFbA1) are generated on Synthea platform.
We've done a [preprocessing](https://github.com/Clinical-Informatics-Collaborative/socio-economic-data/blob/main/Synthea%20data/preprocess.ipynb) on Synthea USA California data. 
**The main aim is to replace the US zip code to VIC zip code for later plotting and analysis.** The output data, `vic_anxiety.csv`, can be founded [here](https://wehieduau.sharepoint.com/:x:/r/sites/StudentInternGroupatWEHI/Shared%20Documents/Clinical%20Dashboards/synthea%202023/synthea/vic_anxiety.csv?d=w1d7015a86138430e913cfe1d681f1e1c&csf=1&web=1&e=YqigKe).

## Synthea data generated

Run following commands to set up synthea on device -> 
git clone https://github.com/synthetichealth/synthea.git 
cd synthea 
./run_synthea 
  
Preprocessing for the following files was done in excel, can be done in  python


Australian demographics file: 
 
Download population data from ABS website (census) 
Download income data from ABS website (calculate quartile ranges by calculating proportions from 1st, 2nd, 3rd and 4th quartiles) 
For instance, to calculate proportion of population earning between 0-0.1 quartile (calculate 40% of 1st quartile value and divide by total population). 
Similarly, to calculate proportion of population earning between 0.2-0.3 quartile (calculate 20% of 1st quartile value and 20% of second quartile value and divide by total population). 
 
Download education data from ABS website 
Download diversity data from ABS website 
Combine population based on heredity and countries and then calculate proportion 


Australian postcodes file: 
 
File downloaded from ABS website 



In synthea folder > src > main > resources > geography replace demographics.csv and zipcodes.csv 
Manually replace Australian demographics, zipcodes and providers (optional) files to generated customised data for Australia. 
  
*This did not work as expected to have* 
  
  
Cross-verified whether Synthea-international works 
  
git clone https://github.com/synthetichealth/synthea 
git clone https://github.com/synthetichealth/synthea-international 
cd synthea-international 
cp -R gd/* ../synthea 
cd ../synthea 
./run_synthea -p 5 Somerset Bristol 
  
*This did not work as expected to have* 
  
  
Used the original synthea directory to generate anxiety patients: 
git clone https://github.com/synthetichealth/synthea.git 
cd synthea 
./run_synthea -p 5000 -m anxiety_screening.json --exporter.csv.export = true 
  
*This was expected to generate 5000 patients from Massachusetts* 
  
*Output generated patient data, however had no records for conditions or medical reports* 
  
  
Ultimately generated the following data: 
git clone https://github.com/synthetichealth/synthea.git 
cd synthea 
./run_synthea -p 5000 California --exporter.csv.export = true 
  
This created patient data for multiple health conditions 
  
Following preprocessing techniques were used in python 
Using patients.csv, conditions.csv and observations.csv patients were filtered with anxiety conditions 
Observations were grouped and mean anxiety index values were computed for each patient 
Postcodes for California were then replaced with Victorian postcodes 
