#!/bin/bash

set -x

### requisiti ###
# scrape https://github.com/jeroenjanssens/data-science-at-the-command-line/blob/master/tools/scrape
# jq https://stedolan.github.io/jq
# csvkit https://csvkit.readthedocs.io
# xml2json https://github.com/Inist-CNRS/node-xml2json-command
### requisiti ###

mkdir -p ./dati
mkdir -p ./risorse

curl "http://www.elezioni.regione.sicilia.it//rep_6/affluenzaRegionale1.html" | \
scrape -be "//html/body/div//table/tr/td/table/tr/td//table/tr[position() > 1 and position() < 11]" | \
xml2json | jq '[.html.body.tr[] | {provincia:.td[0].a."$t",elettori:.td[1]."$t"|gsub("\\."; ""),votanti:.td[2]."$t"|gsub("\\."; ""),percentuale:.td[3]."$t"|gsub("%"; "")|gsub("\\,"; ".")}]' | in2csv -f json > ./dati/affluenza12.csv

curl  "http://www.elezioni.regione.sicilia.it//rep_6/affluenzaRegionale1.html" | \
scrape -be "//html/body/div//table/tr/td/table/tr/td//table/tr[position() > 1 and position() < 11]" | \
xml2json | jq -r '.html.body.tr[] | [.td[0].a.href] | @csv' | sed 's/"//g' > ./dati/provinceURL_12.txt

while read p; do
  nome=$(echo "$p" | sed -r 's/\/.*//g')
  curl "http://www.elezioni.regione.sicilia.it//rep_6/$p" | scrape -be "//html/body/div//table/tr/td/table/tr/td//table/tr[position() > 1]" | xml2json | jq '[.html.body.tr[] | {comune:.td[0]."$t",elettori:.td[1]."$t"|gsub("\\."; ""),votanti:.td[2]."$t"|gsub("\\."; ""),percentuale:.td[3]."$t"|gsub("%"; "")|gsub("\\,"; ".")}]' | in2csv -f json > ./dati/affluenza12Comuni"$nome".csv
done <./dati/provinceURL_12.txt

csvstack ./dati/affluenza12Com*.csv > ./dati/affluenza12_Comuni.csv

curl "http://www.elezioni.regione.sicilia.it//rep_6/affluenzaRegionale2.html" | \
scrape -be "//html/body/div//table/tr/td/table/tr/td//table/tr[position() > 1 and position() < 11]" | \
xml2json | jq '[.html.body.tr[] | {provincia:.td[0].a."$t",elettori:.td[1]."$t"|gsub("\\."; ""),votanti:.td[2]."$t"|gsub("\\."; ""),percentuale:.td[3]."$t"|gsub("%"; "")|gsub("\\,"; ".")}]' | in2csv -f json > ./dati/affluenza19.csv

curl  "http://www.elezioni.regione.sicilia.it//rep_6/affluenzaRegionale2.html" | \
scrape -be "//html/body/div//table/tr/td/table/tr/td//table/tr[position() > 1 and position() < 11]" | \
xml2json | jq -r '.html.body.tr[] | [.td[0].a.href] | @csv' | sed 's/"//g' > ./dati/provinceURL_19.txt

while read p; do
  nome=$(echo "$p" | sed -r 's/\/.*//g')
  curl "http://www.elezioni.regione.sicilia.it//rep_6/$p" | scrape -be "//html/body/div//table/tr/td/table/tr/td//table/tr[position() > 1]" | xml2json | jq '[.html.body.tr[] | {comune:.td[0]."$t",elettori:.td[1]."$t"|gsub("\\."; ""),votanti:.td[2]."$t"|gsub("\\."; ""),percentuale:.td[3]."$t"|gsub("%"; "")|gsub("\\,"; ".")}]' | in2csv -f json > ./dati/affluenza19Comuni"$nome".csv
done <./dati/provinceURL_19.txt

csvstack ./dati/affluenza19Com*.csv > ./dati/affluenza19_Comuni.csv

curl "http://www.elezioni.regione.sicilia.it//rep_6/affluenzaRegionale3.html" | \
scrape -be "//html/body/div//table/tr/td/table/tr/td//table/tr[position() > 1 and position() < 11]" | \
xml2json | jq '[.html.body.tr[] | {provincia:.td[0].a."$t",elettori:.td[1]."$t"|gsub("\\."; ""),votanti:.td[2]."$t"|gsub("\\."; ""),percentuale:.td[3]."$t"|gsub("%"; "")|gsub("\\,"; ".")}]' | in2csv -f json > ./dati/affluenza22.csv

curl  "http://www.elezioni.regione.sicilia.it//rep_6/affluenzaRegionale3.html" | \
scrape -be "//html/body/div//table/tr/td/table/tr/td//table/tr[position() > 1 and position() < 11]" | \
xml2json | jq -r '.html.body.tr[] | [.td[0].a.href] | @csv' | sed 's/"//g' > ./dati/provinceURL_22.txt

while read p; do
  nome=$(echo "$p" | sed -r 's/\/.*//g')
  curl "http://www.elezioni.regione.sicilia.it//rep_6/$p" | scrape -be "//html/body/div//table/tr/td/table/tr/td//table/tr[position() > 1]" | xml2json | jq '[.html.body.tr[] | {comune:.td[0]."$t",elettori:.td[1]."$t"|gsub("\\."; ""),votanti:.td[2]."$t"|gsub("\\."; ""),percentuale:.td[3]."$t"|gsub("%"; "")|gsub("\\,"; ".")}]' | in2csv -f json > ./dati/affluenza22Comuni"$nome".csv
done <./dati/provinceURL_22.txt

csvstack ./dati/affluenza22Com*.csv > ./dati/affluenza22_Comuni.csv

rm ./dati/provinceURL_*.txt

# curl "http://www.elezioni.regione.sicilia.it//rep_3/votiListeRegionali.html" | pup 'body > div > table > tbody > tr > td > table > tbody > tr > td > p > table json{}'  | jq "[.[0].children[0].children[] | {numero:.children[0].text,nome:.children[1].text,contrassegno:.children[2].children[0].children[0].children[0].children[1].text,voti:.children[3].text,perc:.children[4].text}]"