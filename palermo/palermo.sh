#!/bin/bash

mkdir -p ./dati

Affluenza12="palermoAffluenza12"
curl -sL "http://regionali2017.comune.palermo.it/AFFLSEZ_1_82053_R1.xml" > ./dati/"$Affluenza12".xml


xmlstarlet sel --net -t -m "//CONS/SV" -v "@NUMERO" -o "|" -v "@TOTVOT" -o "|" -v "@UBICAZIONE" -o "|" -v "@ELETTORI" -n \
http://regionali2017.comune.palermo.it/AFFLSEZ_1_82053_R1.xml > ./dati/"$Affluenza12"_tmp.csv

sed -i '1s/^/sezione|votanti|ubicazione|numeroElettori\n/' ./dati/"$Affluenza12"_tmp.csv

csvsql -d "|" --query 'select *, (CAST(votanti AS FLOAT)*100/numeroElettori) AS affluenzaPercentuale from '"$Affluenza12"'_tmp where numeroElettori > 20 order by affluenzaPercentuale DESC' ./dati/"$Affluenza12"_tmp.csv > ./dati/"$Affluenza12".csv

csvsql --query 'select "Palermo" as comune,"12:00" as ora, AVG("affluenzaPercentuale") as mediaAffluenza from '"$Affluenza12"'' ./dati/"$Affluenza12".csv > ./dati/"$Affluenza12"_complessivo.csv