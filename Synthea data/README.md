## The background

The AU demographic data and US California mental illness data (Synthetic data) is too large to upload even using Git Large File Storage. 
The [AU demographic data](https://wehieduau.sharepoint.com/:f:/r/sites/StudentInternGroupatWEHI/Shared%20Documents/Clinical%20Dashboards/synthea%202023/australian%20data?csf=1&web=1&e=bWyI1x) and [US California data](https://wehieduau.sharepoint.com/:f:/r/sites/StudentInternGroupatWEHI/Shared%20Documents/Clinical%20Dashboards/synthea%202023/synthea/data?csf=1&web=1&e=lKFbA1) are generated on Synthea platform.
We've done a [preprocessing](https://github.com/Clinical-Informatics-Collaborative/socio-economic-data/blob/main/Synthea%20data/preprocess.ipynb) on Synthea USA California data. 
**The main aim is to replace the US zip code to VIC zip code for later plotting and analysis.** 

## Synthea data generated

Run following commands to set up synthea on device ->
git clone https://github.com/synthetichealth/synthea.git
cd synthea
./run_synthea

Manually replace Australian demographics, zipcodes and providers (optional) files to generated customized data for Australia.

*This did not work as expected to have*


Cross-verified whether Synthea-international works

git clone https://github.com/synthetichealth/synthea
git clone https://github.com/synthetichealth/synthea-international
cd synthea-international
cp -R gd/* ../synthea
cd ../synthea
./run_synthea -p 5 Somerset Bristol
 
*This did not as expected to have*


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
Postcodes for California were then replaced with Victorian postcodes 
