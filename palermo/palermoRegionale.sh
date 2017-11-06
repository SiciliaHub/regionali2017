#!/bin/bash

set -x

mkdir -p ./dati

curl "http://www.elezioni.regione.sicilia.it//rep_5/Palermo/votiCandidatiProvinciaPA.html" > ./dati/votiCandidatiProvinciaPa.html

cat ./dati/votiCandidatiProvinciaPa.html | scrape -be "//th/div/table//tr[td]/td/div" | xml2json | jq '.html.body.div[]."$t"' | sed -r 's/null//g;/^$/d'  | nl -nrn  -s "," | sed -r 's/^ *//g' > ./dati/listeProvinciaPa.csv

sed -i '1s/^/idLista,nomeLista\n/' ./dati/listeProvinciaPa.csv

paragrafo=6
for i in {1..12}
do
    <./dati/votiCandidatiProvinciaPa.html pup "body > div:nth-child(1) > table:nth-child(2)  > tbody > tr:nth-child(2) > td:nth-child(3) > table > tbody > tr:nth-child(2) > td > p:nth-child($paragrafo)" | scrape -be "//table//tr[position() > 2 and position() < last()]" | sed 's/<br\/>/ /g ; s/  / /g' | xml2json | sed 's/\\n   \\n   / /g' | jq '[.html.body.tr[] | {lista:"'"$i"'",numeroCandidato:.td[0]."$t",nome:.td[1]."$t",anagrafica:.td[2]."$t",preferenze:.td[3]."$t"|gsub("\\."; "")}]' | in2csv --no-inference -f json > ./dati/L_R"$i".csv
    paragrafo=$(expr $paragrafo + 4)
done

rm ./dati/listeProvncialiPalermo.csv

csvstack ./dati/L_R*.csv > ./dati/listeProvncialiPalermo_tmp.csv

csvsql --query "select * from listeProvncialiPalermo_tmp order by preferenze  DESC" ./dati/listeProvncialiPalermo_tmp.csv > ./dati/listeProvncialiPalermo2_tmp.csv

csvsql --query 'select a.*,b."nomeLista" from "listeProvncialiPalermo2_tmp" as a left JOIN  "listeProvinciaPa" as b ON a.lista=b."idLista"' ./dati/listeProvncialiPalermo2_tmp.csv ./dati/listeProvinciaPa.csv > ./dati/listeProvncialiPalermo.csv

rm ./dati/L_R*.csv
rm ./dati/*_tmp.csv