#!/bin/bash

mkdir -p ./dati

curl "http://www.elezioni.regione.sicilia.it//rep_6/affluenzaRegionale1.html" | \
scrape -be "//html/body/div//table/tr/td/table/tr/td//table/tr[position() > 1 and position() < 11]" | \
xml2json | jq '[.html.body.tr[] | {provincia:.td[0].a."$t",elettori:.td[1]."$t"|gsub("\\."; ""),votanti:.td[2]."$t"|gsub("\\."; ""),percentuale:.td[3]."$t"|gsub("%"; "")|gsub("\\,"; ".")}]' | in2csv -f json > ./dati/affluenza12.csv

curl "http://www.elezioni.regione.sicilia.it//rep_6/affluenzaRegionale2.html" | \
scrape -be "//html/body/div//table/tr/td/table/tr/td//table/tr[position() > 1 and position() < 11]" | \
xml2json | jq '[.html.body.tr[] | {provincia:.td[0].a."$t",elettori:.td[1]."$t"|gsub("\\."; ""),votanti:.td[2]."$t"|gsub("\\."; ""),percentuale:.td[3]."$t"|gsub("%"; "")|gsub("\\,"; ".")}]' | in2csv -f json > ./dati/affluenza19.csv

curl "http://www.elezioni.regione.sicilia.it//rep_6/affluenzaRegionale3.html" | \
scrape -be "//html/body/div//table/tr/td/table/tr/td//table/tr[position() > 1 and position() < 11]" | \
xml2json | jq '[.html.body.tr[] | {provincia:.td[0].a."$t",elettori:.td[1]."$t"|gsub("\\."; ""),votanti:.td[2]."$t"|gsub("\\."; ""),percentuale:.td[3]."$t"|gsub("%"; "")|gsub("\\,"; ".")}]' | in2csv -f json > ./dati/affluenza22.csv
