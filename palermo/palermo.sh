#!/bin/bash

set -x

### requisiti ###
# xmlstarlet http://xmlstar.sourceforge.net
# csvkit https://csvkit.readthedocs.io
### requisiti ###

mkdir -p ./dati

## affluenze

for i in {1..3}; do
    echo $i;
    if [ "$i" -eq 1 ]; then
        ora="12"
    elif [ "$i" -eq 2 ]; then
        ora="19"
    else
        ora="22"    
    fi
    nome="palermoAffluenza$ora"

    curl -sL "http://regionali2017.comune.palermo.it/AFFLSEZ_1_82053_R$i.xml" > ./dati/"$nome".xml

    xmlstarlet sel --net -t -m "//CONS/SV" -v "@NUMERO" -o "|" -v "@TOTVOT" -o "|"  -v "@TOTVOTM" -o "|"  -v "@TOTVOTF" -o "|" -v "@UBICAZIONE" -o "|" -v "@ELETTORI" -n \
    http://regionali2017.comune.palermo.it/AFFLSEZ_1_82053_R"$i".xml > ./dati/"$nome"_tmp.csv

    sed -i '1s/^/sezione|votanti|votantiUomini|votantiDonne|ubicazione|numeroElettori\n/' ./dati/"$nome"_tmp.csv

    csvsql -d "|" --query 'select *, (CAST(votanti AS FLOAT)*100/numeroElettori) AS affluenzaPercentuale from '"$nome"'_tmp where numeroElettori > 20 order by affluenzaPercentuale DESC' ./dati/"$nome"_tmp.csv > ./dati/"$nome".csv

    csvsql --query 'select "Palermo" as comune,"'"$ora"':00" as ora, AVG("affluenzaPercentuale") as mediaAffluenza from '"$nome"'' ./dati/"$nome".csv > ./dati/"$nome"_complessivo.csv
done

rm ./dati/*_tmp.csv
