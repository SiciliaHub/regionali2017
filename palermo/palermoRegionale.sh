#!/bin/bash

set -x

mkdir -p ./dati

curl "http://www.elezioni.regione.sicilia.it//rep_5/Palermo/votiCandidatiProvinciaPA.html" > ./dati/votiCandidatiProvinciaPa.html

paragrafo=6
for i in {1..12}
do
    <./dati/votiCandidatiProvinciaPa.html pup "body > div:nth-child(1) > table:nth-child(2)  > tbody > tr:nth-child(2) > td:nth-child(3) > table > tbody > tr:nth-child(2) > td > p:nth-child($paragrafo)" | scrape -be "//table//tr[position() > 2 and position() < last()]" | sed 's/<br\/>/ /g ; s/  / /g' | xml2json | sed 's/\\n   \\n   / /g' | jq '[.html.body.tr[] | {lista:"'"$i"'",numero:.td[0]."$t",nome:.td[1]."$t",anagrafica:.td[2]."$t",preferenze:.td[3]."$t"|gsub("\\."; "")}]' | in2csv --no-inference -f json > ./dati/L_R"$i".csv
    paragrafo=$(expr $paragrafo + 4)
done

rm ./dati/listeProvncialiPalermo.csv

csvstack ./dati/L_R*.csv > ./dati/listeProvncialiPalermo_tmp.csv

csvsql --query "select * from listeProvncialiPalermo_tmp order by preferenze  DESC" ./dati/listeProvncialiPalermo_tmp.csv > ./dati/listeProvncialiPalermo.csv

rm ./dati/L_R*.csv
rm ./dati/*_tmp.csv